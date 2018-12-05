cwlVersion: v1.0
class: CommandLineTool

requirements:
  InitialWorkDirRequirement:
    listing:
      - $(inputs.fill)
      - $(inputs.tools)
      - $(inputs.tools_h)

inputs:
  fill:
    type: Directory
  tools:
    type: File
  tools_h:
    type: File
  outfile:
    type: string
    default: output-MC-1.root

baseCommand: /bin/sh

arguments:
  - prefix: -c
    valueFrom: |
      mv $(inputs.tools.basename) $(inputs.tools_h.basename) fill/.; \
      cd fill; \
      root -b -q mk_fillHistosMC.C

outputs:
  output-MC-1:
    type: File
    outputBinding:
      glob: $(inputs.outfile)
