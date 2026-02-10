# Use the official centos image as parent image
#FROM tensorflow/tensorflow:2.16.1-gpu
FROM akalinow/tensorflow-gpu:latest

# Define who is responsible for this Dockerfile
LABEL maintainer="Artur.Kalinowski@fuw.edu.pl"


USER root
RUN apt-get update
RUN apt -y install \
	cmake \
	python3-pip \
	python3-numpy \
	graphviz \
	screen \
	cargo

RUN python3 -m pip install --upgrade pip	

# Install RAPIDS
# https://rapids.ai/start.html
# ...not yet

RUN pip3 install --upgrade jsonschema attrs
RUN pip3 install --upgrade jupyter jupyterlab jupyter_contrib_nbextensions nodejs npm rise jupyterlab_rise
RUN pip3 install --upgrade pandas pyarrow fastparquet tables numba click
RUN pip3 install --upgrade graphviz pydot pydot_ng opencv-contrib-python-headless
RUN pip3 install --upgrade scikit-learn scipy scikit-image scikit-hep
RUN pip3 install --upgrade seaborn plotly hide_code[lab] idx2numpy
RUN pip3 install --upgrade uproot awkward awkward-pandas dask
RUN pip3 install --upgrade opencv-contrib-python-headless
RUN pip3 install --upgrade tensorboard_plugin_profile
RUN pip3 install --upgrade tensorflow_datasets 
#RUN pip3 install --upgrade tensorflow-text  #not available in TF2.20
#RUN pip3 install --upgrade tensorflow-probability # not available in TF2.20
#RUN pip3 install --upgrade tensorflow-model-analysis # not available in TF2.20
RUN pip3 install --upgrade tf-models-official==2.17.0
RUN pip3 install --upgrade google-genai
RUN pip3 install --upgrade kagglehub

RUN pip3 install --upgrade iminuit
RUN pip3 install --upgrade nbdime


#Install pytorch
#RUN pip3 install --upgrade torch torchvision torchaudio -f https://download.pytorch.org/whl/torch_stable.html

#Fix issue with nvcc problem in 12.3 version
#RUN apt -y install cuda-nvcc-12-2 tensorrt
#RUN rm /etc/alternatives/cuda
#RUN ln -s /usr/local/cuda-12.2/ /etc/alternatives/cuda
#RUN ln -s /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1
############################################

# install user scripts
RUN mkdir -p /opt/scripts
COPY start-jupyter.sh /opt/scripts/start-jupyter.sh
RUN chmod +x /opt/scripts/start-jupyter.sh

##Create users
RUN groupadd -g 1000 jupyter && \
     useradd -m -r -u 1000 -g jupyter jupyter

RUN groupadd -g 29916 user1 && \
     useradd -m -r -u 29916 -g user1 user1
