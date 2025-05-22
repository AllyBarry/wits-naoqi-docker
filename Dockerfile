FROM ubuntu:16.04

ARG PYTHON_VERSION=2.7
ENV HOME=/home/user

# Install dependencies
RUN apt-get update && apt-get install -y iproute2 telnet iputils-ping \
    wget gcc make openssl libffi-dev libgdbm-dev libsqlite3-dev libssl-dev zlib1g-dev \
    && apt-get clean

# Build Python from source
WORKDIR /tmp/
RUN wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tgz \
  && tar --extract -f Python-$PYTHON_VERSION.tgz \
  && cd ./Python-$PYTHON_VERSION/ \
  && ./configure --with-ensurepip=install --enable-optimizations --prefix=/usr/local \
  && make && make install \
  && cd ../ \
  && rm -r ./Python-$PYTHON_VERSION*

ENV PYTHONPATH=/usr/local/bin/python

# Build pip from source
# RUN wget https://bootstrap.pypa.io/pip/2.7/get-pip.py \
#     && python get-pip.py

# Set the working directory to /naoqi
WORKDIR /naoqi

# Copy the NAOqi for Python SDK
ADD pynaoqi-python2.7-2.8.6.23-linux64-20191127_152327.tar.gz /naoqi/

# Copy the boost fix
# See https://community.ald.softbankrobotics.com/en/forum/import-issue-pynaoqi-214-ubuntu-7956
COPY boost/* /naoqi/pynaoqi-python2.7-2.8.6.23-linux64-20191127_152327/

# Set the path to the SDK
ENV PYTHONPATH=${PYTHONPATH}:/naoqi/pynaoqi-python2.7-2.8.6.23-linux64-20191127_152327/lib/python2.7/site-packages/
ENV LD_LIBRARY_PATH="/naoqi/pynaoqi-python2.7-2.8.6.23-linux64-20191127_152327"

# Install required packages
RUN apt-get update && apt-get install -y fontconfig libsdl2-dev libxaw7 libqt5gui5  \
    && apt-get clean

# Add Choreograph files (to be installed manually)
ADD choregraphe-suite-2.5.10.7-linux64-setup.run /choregraphe/

# Copy the samples folder
ADD ./samples /home/user/naoqi/samples
