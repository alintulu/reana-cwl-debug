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
      - $(inputs.1_MC)

inputs:
  settings:
    type: File
  normalize:
    type: File
  1_MC:
    type: File
  data_type:
    type: string
    default: MC
  outfile:
    type: string
    default: output-MC-2a.root

baseCommand: /bin/sh

arguments:
  - prefix: -c
    valueFrom: |
      root -l -b -q '$(inputs.normalize.basename)("$(inputs.data_type)")' 

outputs:
  output-MC-2a:
    type: File
    outputBinding:
      glob: $(inputs.outfile)
