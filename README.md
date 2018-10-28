concourse-pipeline-template
---
This concourse pipeline is just for the PoC of spring projects.

This contains the blue green deployments and changing job name feature.

## Prerequisites
#### 1. Running Concourse CI

Please refer the official document.

https://concourse-ci.org/

#### 2. PWS or PCF
This pipeline deploys your application to Cloud Foundry.

#### 3. Gitlab repository with 2 branches
One branch is for development and another is for production.

This pipeline creates a merge request on production branch after successful deployments for dev branch.

#### 4. A repository for the artifacts
This pipeline pushes build artifacts to the repository.

As the artifacts grows, the pipeline will slow down.

## Getting started
#### 1. Clone
Clone this repository and push it to your repository.

#### 2. Edit credentials.yml.sample
Replace values in `credentials.yml.sample` to yours and rename it.

#### 3. Login and set pipeline
Use `login_to_poc_target.sh` and `set_pipeline.sh`.

#### 4. Un-pause your pipeline in concourse ci
Click un-pause button in your concourse ci. Then it will start your new pipeline automatically.

#### 5. Push your application
If you push commits for your application, first job in your pipeline will start to build.

## References
https://github.com/myminseok/articulate-ci-demo

https://github.com/pivotalservices/concourse-pipeline-samples/tree/master/concourse-pipeline-patterns
