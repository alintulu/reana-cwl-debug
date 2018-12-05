cwlVersion: v1.0
class: CommandLineTool

requirements:
  DockerRequirement:
    dockerPull:
      reanahub/reana-env-root6
  InitialWorkDirRequirement:
    listing:
      - $(inputs.settings)
      - $(inputs.tools)
      - $(inputs.tools_h)
      - $(inputs.theory)
      - $(inputs.theory_DATA)
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
  theory_DATA:
    type: File
  2b_DATA:
    type: File
  2b_MC:
    type: File
  outfile:
    type: string
    default: output-DATA-2c.root

baseCommand: /bin/sh

arguments:
  - prefix: -c
    valueFrom: |
      root -l -b -q $(inputs.theory_DATA.basename)

outputs:
  output-DATA-2c:
    type: File
    outputBinding:
      glob: $(inputs.outfile)
