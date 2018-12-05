cwlVersion: v1.0
class: CommandLineTool

requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.fill)
      - $(inputs.tools)
      - $(inputs.tools_h)
      - $(inputs.settings)

inputs:
  fill:
    type: Directory
  tools:
    type: File
  tools_h:
    type: File
  settings:
    type: File
  outfile:
    type: string
    default: output-DATA-1.root

baseCommand: /bin/sh

arguments:
  - prefix: -c
    valueFrom: |
      mv $(inputs.settings.basename) $(inputs.tools.basename) $(inputs.tools_h.basename) fill/.; \
      cd fill; \
      root -l -b -q mk_fillHistosData.C

outputs:
  output-DATA-1:
    type: File
    outputBinding:
      glob: $(inputs.outfile)
