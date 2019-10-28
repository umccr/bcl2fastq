#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

hints:
 DockerRequirement:
   dockerPull: umccr/bcl2fastq

requirements:
  EnvVarRequirement:
    envDef:
      DEPLOY_ENV: $(inputs.denv)
  InitialWorkDirRequirement:
    listing:
      - $(inputs.samplesheet)
      - entry: $(inputs.input_folder)
        writable: true

inputs:    
  denv: string

  input_folder:
    type: Directory
    inputBinding:
      position: 1
      prefix: -R

  output_folder:
    type: Directory
    inputBinding:
      position: 3
      prefix: -o
  
  samplesheet:
    type: File
    inputBinding:
      prefix: --sample-sheet

arguments: ["--no-lane-splitting"]

outputs:
  log_out:
    type: stdout

  split_samplesheets_fastq:
    type:
      type: array
      items: File
    outputBinding:
      glob: "*.fastq"

stdout: bcl2fastq.log

baseCommand: []
