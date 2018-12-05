#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.1_DATA)
      - $(inputs.1_MC)
      - $(inputs.settings)
      - $(inputs.tools)
      - $(inputs.tools_h)
      - $(inputs.tdr_style)
      - $(inputs.resolution)
      - $(inputs.normalize)
      - $(inputs.combine)
      - $(inputs.theory)
      - $(inputs.theory_DATA)
      - $(inputs.theory_MC)
      - $(inputs.drawPlots)
      - $(inputs.drawMetSumetRatio)

inputs:
  1_DATA:
    type: File
  1_MC:
    type: File
  settings:
    type: File
  tools:
    type: File
  tools_h:
    type: File
  tdr_style:
    type: File
  resolution:
    type: File
  normalize:
    type: File
  combine:
    type: File
  theory:
    type: File
  theory_DATA:
    type: File
  theory_MC:
    type: File
  drawPlots:
    type: File
  drawMetSumetRatio:
    type: File

outputs:
  met_sumet_ratio_of_different_pt_events.pdf:
    type: File
    outputSource:
      drawMetSumet/met_sumet_ratio_of_different_pt_events
  output-DATA-2a.root:
    type: File
    outputSource:
      normalizeHistosData/output-DATA-2a
  output-MC-2a.root:
    type: File
    outputSource:
      normalizeHistosMC/output-MC-2a
  output-DATA-2b.root:
    type: File
    outputSource:
      combineHistosData/output-DATA-2b
  output-MC-2b.root:
    type: File
    outputSource:
      combineHistosMC/output-MC-2b
  output-DATA-2c.root:
    type: File
    outputSource:
      theoryData/output-DATA-2c
  output-MC-2c.root:
    type: File
    outputSource:
      theoryMC/output-MC-2c
  jets_per_bin.pdf:
    type: File
    outputSource:
      draw/jets_per_bin

steps:
  drawMetSumet:
    run: drawMetSumetRatio.cwl
    in:
      drawMetSumetRatio: drawMetSumetRatio
      tdr_style: tdr_style
      1_DATA: 1_DATA 
    out: [met_sumet_ratio_of_different_pt_events]
  normalizeHistosData:
    run: normalizeHistosData.cwl
    in:
      settings: settings
      normalize: normalize
      1_DATA: 1_DATA
    out: [output-DATA-2a]
  normalizeHistosMC:
    run: normalizeHistosMC.cwl
    in:
      settings: settings
      normalize: normalize
      1_MC: 1_MC
    out: [output-MC-2a]
  combineHistosData:
    run: combineHistosData.cwl
    in:
      settings: settings
      combine: combine
      2a_DATA: normalizeHistosData/output-DATA-2a
    out: [output-DATA-2b]
  combineHistosMC:
    run: combineHistosMC.cwl
    in:
      settings: settings
      combine: combine
      2a_MC: normalizeHistosMC/output-MC-2a
    out: [output-MC-2b]
  theoryData: 
    run: theoryData.cwl
    in:
      settings: settings
      theory_DATA: theory_DATA
      theory: theory
      tools: tools
      tools_h: tools_h
      2b_DATA: combineHistosData/output-DATA-2b
      2b_MC: combineHistosMC/output-MC-2b
    out: [output-DATA-2c]
  theoryMC:
    run: theoryMC.cwl
    in:
      settings: settings
      theory_MC: theory_MC
      theory: theory
      tools: tools
      tools_h: tools_h
      2b_DATA: combineHistosData/output-DATA-2b
      2b_MC: combineHistosMC/output-MC-2b
    out: [output-MC-2c]
  draw:
    run: drawPlots.cwl
    in:
      drawPlots: drawPlots
      tdr_style: tdr_style
      2a_DATA: normalizeHistosData/output-DATA-2a
    out: [jets_per_bin]

