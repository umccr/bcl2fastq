#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow

hints:
 DockerRequirement:
   dockerImageId: umccr/pipeline
   dockerPull: umccr/bcl2fastq

requirements:
  ScatterFeatureRequirement: {}
  EnvVarRequirement:
    envDef:
      DEPLOY_ENV: $(inputs.denv)

inputs:
  denv: string
  input_folder: Directory
  samplesheet: File
  config: Directory
  input_folder: Directory 

steps:
  runFolderCheck:
    run: ./tools/runFolderCheck.cwl
    in:
      denv: denv
      input_folder: input_folder
    out:
      - runFolderCheckLog

  sampleSheetCheck:
    run: ./tools/sampleSheetCheck.cwl
    in:
      denv: denv
      samplesheet: sampleshhet
      config: config
    out:
      - [splitSampleSheets]

  bcl2fastq:
    run: .tools/bcl2fastq.cwl
    scatter: input_folder
    in:
      denv: denv
      input_folder: sampleSheetCheck/splitSampleSheets
      output_folder: output_folder
    out:
      - [fastqs]

outputs:
  fatsqs:
    type: File[]
    outputSource: bcl2fastq/fastqs

