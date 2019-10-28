#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

hints:
 DockerRequirement:
   dockerImageId: umccr/pipeline-cwl

requirements:
  EnvVarRequirement:
    envDef:
      DEPLOY_ENV: $(inputs.denv)
  InitialWorkDirRequirement:
    listing:
      - $(inputs.samplesheet)
      - entry: $(inputs.outdir)
        writable: true

inputs:
  outdir: 
    type: Directory
    
  denv: string

  samplesheet:
    type: File
    inputBinding:
      position: 1

  config:
    type: Directory
    inputBinding:
      position: 2

outputs:
  log_out:
    type: stdout

  split_samplesheets:
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"

stdout: samplesheet-check.log

baseCommand: [python, /scripts/samplesheet-check.py]
