cwlVersion: v1.0
class: CommandLineTool

requirements:
  DockerRequirement:
    dockerPull:
      reanahub/reana-env-root6
  InitialWorkDirRequirement:
    listing:
      - $(inputs.settings)
      - $(inputs.normalize)
      - $(inputs.1_DATA)

inputs:
  settings:
    type: File
  normalize:
    type: File
  1_DATA:
    type: File
  data_type:
    type: string
    default: DATA
  outfile:
    type: string
    default: output-DATA-2a.root

baseCommand: /bin/sh

arguments:
  - prefix: -c
    valueFrom: |
      root -l -b -q '$(inputs.normalize.basename)("$(inputs.data_type)")' 

outputs:
  output-DATA-2a:
    type: File
    outputBinding:
      glob: $(inputs.outfile)
