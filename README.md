### Dask for ML
Based on https://github.com/fastforwardlabs/dask_xgboost_parallel/blob/master/daskschedular.py

The goal of the session is to:
- demonstrate how to create new base images in CML
- show how to use Dask for machine learning

## Create new base container with Dask libraries
# Open shell by running https://your-cluster-IP:4200 (to be found in the spreadsheet)
Use centos as loging and password provided in the presentation.

# Sudo to root
sudo su

# Create docker file in /tmp
mkdir /tmp/daskdocker
cd /tmp/daskdocker
vi Dockerfile

# Copy/paste the following into vi
FROM docker.repository.cloudera.com/cdsw/engine:10

RUN pip3 install "dask[complete]"
RUN pip3 install sklearn
RUN pip3 install "dask-ml[complete]" --no-cache-dir
RUN pip3 install jupyterlab


# Save and quit vi using :wq!

# Build new docker image
docker build --network=host -t cdsw10_dask:cdsw10_dask . -f Dockerfile

# Confirm that new docker image is available
docker images

# Whitelist container in Engine Images section in Admin / Engines by adding:
Description - Base Image v10 with dask
Repository:Tag - cdsw10_dask:cdsw10_dask

# Change base image in the project's settings (Engine Image)

# Add JupyterLab in Editors tab of the project's settings
Name: JupyterLabs
Command:
!/home/cdsw/.local/bin/jupyter-lab --no-browser --ip=127.0.0.1 --port=${CDSW_APP_PORT} --NotebookApp.token= --NotebookApp.allow_remote_access=True --log-level=ERROR

# Start new JupyterLab session
Open workbench, change editor, launch new session

# Run all sections in 1_Dask Parallel Xgboost.ipynb

# Confirm resource usage in resource dashboard in CML

# Terminate JupyterLab session

# Start new workbench session with base CML Editors

# Open Dask scheduler UI while running 2_Launchdaskschwithdash.py
