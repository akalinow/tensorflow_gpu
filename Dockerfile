# Use the official centos image as parent image
FROM tensorflow/tensorflow:latest-gpu

# Define who is responsible for this Dockerifle
LABEL maintainer="Artur.Kalinowski@fuw.edu.pl"

USER root
RUN /usr/bin/python3 -m pip install --upgrade pip
RUN apt update
RUN apt -y install \
	python3 python3-pip \
	python3-numpy \
	graphviz git

# Install software tools
RUN pip3 install --upgrade jupyterlab jupyter_contrib_nbextensions nodejs npm rise
RUN jupyter contrib nbextension install
RUN jupyter-nbextension install rise --py --sys-prefix
RUN jupyter nbextension enable rise --py --sys-prefix
RUN pip3 install --upgrade pandas pyarrow fastparquet tables
RUN pip3 install --upgrade graphviz pydot pydot_ng opencv-contrib-python-headless
RUN pip3 install --upgrade scikit-learn scipy scikit-image scikit-hep
RUN pip3 install --upgrade seaborn plotly hide_code[lab] scikit-hep
RUN pip3 install --upgrade uproot awkward awkward-pandas dask
RUN pip3 install --upgrade opencv-contrib-python-headless
RUN pip3 install --upgrade tensorflow-model-analysis tensorflow-addons tensorflow-probability tensorflow-text
RUN pip3 install --upgrade tensorboard_plugin_profile tensorflow_datasets
RUN pip3 install --upgrade torch torchvision torchaudio -f https://download.pytorch.org/whl/torch_stable.html

##Create users
RUN groupadd -g 1000 jupyter && \
     useradd -m -r -u 1000 -g jupyter jupyter

RUN groupadd -g 29916 user1 && \
     useradd -m -r -u 29916 -g user1 user1

USER user1
COPY start-jupyter.sh /home/user1
     
USER jupyter
COPY start-jupyter.sh /home/jupyter
