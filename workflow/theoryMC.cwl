cwlVersion: v1.0
class: CommandLineTool

requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.settings)
      - $(inputs.tools)
      - $(inputs.tools_h)
      - $(inputs.theory_MC)
      - $(inputs.theory)
      - $(inputs.2b_DATA)
      - $(inputs.2b_MC)

inputs:
  settings:
    type: File
  tools:
    type: File
  tools_h:
    type: File
  theory:
    type: File
  theory_MC:
    type: File
  2b_DATA:
    type: File
  2b_MC:
    type: File
  outfile:
    type: string
    default: output-MC-2c.root

baseCommand: /bin/sh

arguments:
  - prefix: -c
    valueFrom: |
      root -l -b -q $(inputs.theory_MC.basename)

outputs:
  output-MC-2c:
    type: File
    outputBinding:
      glob: $(inputs.outfile)
