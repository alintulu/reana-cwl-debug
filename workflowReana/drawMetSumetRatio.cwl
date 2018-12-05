cwlVersion: v1.0
class: CommandLineTool

requirements:
  DockerRequirement:
    dockerPull:
      reanahub/reana-env-root6
  InitialWorkDirRequirement:
    listing:
      - $(inputs.tdr_style)
      - $(inputs.drawMetSumetRatio)
      - $(inputs.1_DATA)

inputs:
  tdr_style:
    type: File
  drawMetSumetRatio:
    type: File
  1_DATA:
    type: File
  pdf:
    type: string
    default: met_sumet_ratio_of_different_pt_events.pdf

baseCommand: /bin/sh

arguments:
  - prefix: -c
    valueFrom: |
      root -l -b -q drawMetSumetRatio.C 

outputs:
  met_sumet_ratio_of_different_pt_events:
    type: File
    outputBinding:
      glob: $(inputs.pdf)
