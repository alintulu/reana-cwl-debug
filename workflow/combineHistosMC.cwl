cwlVersion: v1.0
class: CommandLineTool

requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.settings)
      - $(inputs.combine)
      - $(inputs.2a_MC)

inputs:
  settings:
    type: File
  combine:
    type: File
  data_type:
    type: string
    default: MC
  2a_MC:
    type: File
  outfile:
    type: string
    default: output-MC-2b.root

baseCommand: /bin/sh

arguments:
  - prefix: -c
    valueFrom: |
      root -l -b -q '$(inputs.combine.basename)("$(inputs.data_type)")'

outputs:
  output-MC-2b:
    type: File
    outputBinding:
      glob: $(inputs.outfile)
