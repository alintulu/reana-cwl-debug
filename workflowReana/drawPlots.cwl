cwlVersion: v1.0
class: CommandLineTool

requirements:
  DockerRequirement:
    dockerPull:
      reanahub/reana-env-root6
  InitialWorkDirRequirement:
    listing:
      - $(inputs.tdr_style)
      - $(inputs.drawPlots)
      - $(inputs.2a_DATA)

inputs:
  tdr_style:
    type: File
  drawPlots:
    type: File
  2a_DATA:
    type: File
  pdf2:
    type: string
    default: jets_per_bin.pdf

baseCommand: /bin/sh

arguments:
  - prefix: -c
    valueFrom: |
      root -l -b -q drawPlots.C 

outputs:
  jets_per_bin:
    type: File
    outputBinding:
      glob: $(inputs.pdf2)
