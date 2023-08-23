# Introduction 
This folder contains the deployment pipeline to deploy IaC with Bicep to Azure

## azure pipelines step templates
```text
pipelines
|
|--------main.yaml
         |------------build.yaml
         |------------cleanup.yaml
         |------------deploy.yaml
         |------------pipeline.variables.yaml
```
<b>main.yaml</b> - contains the main stages build & deploy  
<b>build.yaml</b> - contains the build stage job template to validate the bicep template deployment and publish as pipeline artifact  
<b>cleanup.yaml</b> - contains cleanup job , to remove dev and/or staging deployments after testing, this includes an approval serverless job.  
<b>deploy.yaml</b> - contains deployment job of the bicep template IaC.  
<b>pipeline.variables.yaml</b> - contains variables for the separate stages and input for the azure deployment tasks.  