cwlVersion: v1.0
class: CommandLineTool

requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.settings)
      - $(inputs.combine)
      - $(inputs.2a_DATA)

inputs:
  settings:
    type: File
  combine:
    type: File
  data_type:
    type: string
    default: DATA
  2a_DATA:
    type: File
  outfile:
    type: string
    default: output-DATA-2b.root

baseCommand: /bin/sh

arguments:
  - prefix: -c
    valueFrom: |
      root -l -b -q '$(inputs.combine.basename)("$(inputs.data_type)")'

outputs:
  output-DATA-2b:
    type: File
    outputBinding:
      glob: $(inputs.outfile)
