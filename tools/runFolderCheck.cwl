#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

hints:
 DockerRequirement:
   dockerPull: umccr/umccr_pipeline

inputs:
  script:
    type: File
    inputBinding: 
      position 1

  input_folder:
    type: string?
    inputBinding:
      position: 2

outputs:
  log_out:
    type: File
    outputBinding:
      glob: *.log

baseCommand: [bash, '-c']