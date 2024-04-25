# Use the official centos image as parent image
FROM tensorflow/tensorflow:latest-gpu

# Define who is responsible for this Dockerifle
LABEL maintainer="Artur.Kalinowski@fuw.edu.pl"

USER root
RUN apt-get update
RUN apt -y install \
	python3 python3-pip \
	python3-numpy \
	graphviz git \
	screen \
	cargo

RUN /usr/bin/python3 -m pip install --upgrade pip	

# Install software tools
RUN pip3 install --upgrade jsonschema attrs
RUN pip3 install --upgrade jupyter jupyterlab jupyter_contrib_nbextensions nodejs npm rise jupyterlab_rise
RUN pip3 install --upgrade pandas pyarrow fastparquet tables numba click
RUN pip3 install --upgrade graphviz pydot pydot_ng opencv-contrib-python-headless
RUN pip3 install --upgrade scikit-learn scipy scikit-image scikit-hep
RUN pip3 install --upgrade seaborn plotly hide_code[lab] idx2numpy
RUN pip3 install --upgrade uproot awkward awkward-pandas dask
RUN pip3 install --upgrade opencv-contrib-python-headless
#RUN pip3 install --upgrade tensorflow-model-analysis tensorflow-addons tensorflow-probability #tensorflow-text problems with python versions
RUN pip3 install --upgrade tensorboard_plugin_profile tensorflow_datasets tensorflow-text
RUN pip3 install --upgrade torch torchvision torchaudio -f https://download.pytorch.org/whl/torch_stable.html

#Fix issue with nvcc problem in 12.3 version
RUN apt -y install cuda-nvcc-12-2 tensorrt
RUN rm /etc/alternatives/cuda
RUN ln -s /usr/local/cuda-12.2/ /etc/alternatives/cuda
RUN ln -s /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1
############################################

##Create users
RUN groupadd -g 1000 jupyter && \
     useradd -m -r -u 1000 -g jupyter jupyter

RUN groupadd -g 29916 user1 && \
     useradd -m -r -u 29916 -g user1 user1

USER user1
COPY start-jupyter.sh /home/user1
     
USER jupyter
COPY start-jupyter.sh /home/jupyter
