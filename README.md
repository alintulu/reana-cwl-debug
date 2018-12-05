# reana-cwl-debug

## Run with [CWL](https://www.commonwl.org/)

To run the workflow with `cwltool` use the workflow directory [workflow](workflow)

Follow the steps:

```
$ git clone git@github.com:alintulu/reana-cwl-debug.git
$ cd reana-cwl-debug
$ cwltool --outdir="outputs" workflow/workflow.cwl input.yml
```

The output files from every step of the workflow will go to the directory [outputs](outputs)

## Run with [REANA](http://www.reanahub.io/)

To run the workflow with the reana-client, check out instructions for getting started on [reanas home page](https://reana-client.readthedocs.io/en/latest/gettingstarted.html). Use the directory [workflowReana](workflowReana).
These files have the proper environment requirements which are missing in the files used with `cwltool`.

```
requirements:
  DockerRequirement:
    dockerPull:
      reanahub/reana-env-root6

```
Follow the steps:

```
$ git clone git@github.com:alintulu/reana-cwl-debug.git
$ cd reana-cwl-debug
$ reana-client create -n test-cwl
$ export REANA_WORKON=test-cwl
$ reana-client upload
$ reana-client start
```

## (crude) Workflow visualised

```
+----------+      +----------------+       +-------------+
| Draw Plot|<-----| Normalize Data |       | Normalize MC|   
+----------+      +----------------+       +-------------+
                         |                       |
                         |                       |        
                         v                       v 
                  +-------------+         +------------+
                  | Combine Data|         | Combine MC |   
                  +-------------+         +------------+  
                        |                        |
                        |     +------------+     |        
                        +---> | Theory Data|<--- +
                        |     +------------+     |
                        |      +------------+    |        
                        +--->  |  Theory MC |<---+
                               +------------+
```
