# CICD Scripts

This is the common Scripts template.

## Configurations

All the Global application configs are placed in globalEnvVars.properties

## Files list

```
cicd/
├── globalEnvVars.properties       
├── unit_test.sh
├── build.sh       
├── pr_push.sh
├── release_push.sh    
├── pr_deploy.sh
├── pr_cluster_cleanup.sh
└── release_deploy.sh
```
Note: The file names are not be changes 

## Prerequisite

All repos need to have the cicd directory with the exact script names as mentioned above.
Note: Please clone this repo into your project and edit the scripts as per your need.

## Further help


