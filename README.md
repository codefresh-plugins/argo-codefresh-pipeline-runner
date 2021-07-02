# Codefresh pipeline runner Argo Workflows

Codefresh is a CI/CD platform that engineers actually love to use. The [Codefresh pipeline](https://codefresh.io/docs/docs/configure-ci-cd-pipeline/pipelines/) runner GitHub action will trigger an existing Codefresh pipeline from a GitHub action.

It is based on the [Codefresh CLI](https://codefresh-io.github.io/cli/) which can execute Codefresh pipelines remotely (using an API key for authentication). The Codefresh CLI is already available as a [public Docker image](https://hub.docker.com/r/codefresh/cli/), so creating a GitHub action with it is a trivial process.

## Prerequisites

Make sure that you have

* a Argo workflow is installed
* a [Codefresh account](https://codefresh.io/docs/docs/getting-started/create-a-codefresh-account/) with one or more existing pipelines ready
* a [Codefresh API token](https://codefresh.io/docs/docs/integrations/codefresh-api/#authentication-instructions) that will be used as a secret in the Argo workflow


## How the Codefresh action works

The GitHub workflow is placed on the [push event](https://developer.github.com/v3/activity/events/types/#pushevent) and therefore starts whenever a Git commit happens. The Workflow has a single action that starts the Codefresh pipeline runner.

The pipeline runner is a Docker image with the Codefresh CLI. It uses the Codefresh API token to authenticate to Codefresh and then calls a an existing pipeline via its trigger.

The result is that all the details from the Git push (i.e. the GIT hash) are transferred to the Codefresh pipeline that gets triggered remotely

## How to use the Codefresh Argo workflow

```
argo submit -n argo steps.yaml -p 'CF_API_KEY=****' -p 'PIPELINE_NAME=****'
```
### Env variables
* A secret with name `CF_API_KEY` and value your Codefresh API token ( https://codefresh.io/docs/docs/integrations/codefresh-api/#authentication-instructions )
* An environment variable called `PIPELINE_NAME` with a value of `<project_name>/<pipeline_name>`
* An optional environment variable called `TRIGGER_NAME` with trigger name attached to this pipeline. See the [triggers section](https://codefresh.io/docs/docs/configure-ci-cd-pipeline/triggers/) for more information
* An optional environment variable called `CF_BRANCH` with branch name .


### Outputs
The action will report if the pipeline execution was successful. For example, if your pipeline has unit tests that fail, by default, it will report the action failed. The logs from the pipeline will be streamed into the Argo workflow console.

