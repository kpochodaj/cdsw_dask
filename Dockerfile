FROM docker.repository.cloudera.com/cdsw/engine:10

RUN pip3 install "dask[complete]"
RUN pip3 install sklearn
RUN pip3 install "dask-ml[complete]" --no-cache-dir
