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

inputs:    
  denv: string

  input_folder:
    type: Directory
    inputBinding:
      position: 1

outputs:
  log_out:
    type: stdout

stdout: runfolder-check.sh.log

baseCommand: [bash, /scripts/runfolder-check.sh]
