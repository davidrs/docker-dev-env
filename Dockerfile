FROM ubuntu:xenial

RUN apt-get update \
 && apt-get install -y \
      build-essential \
			libssl-dev \
			libffi-dev \
			python-dev \
			libmysqlclient-dev \
      libgtk2.0-dev \
			pkg-config \
			libavcodec-dev \
			libavformat-dev \
			libswscale-dev \
			python-opencv \
 && curl -LO http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh \
 && bash Miniconda-latest-Linux-x86_64.sh -p /miniconda -b \
 && rm Miniconda-latest-Linux-x86_64.sh

ENV PATH=/miniconda/bin:${PATH}

RUN conda update -y conda \
 && conda install -y opencv \
 && conda install -y -c menpo dlib=18.18 \
 && conda install -y pil \
 && conda install -y boost \
 && pip install jupyter

COPY ./requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Optional google cloud vision API
# RUN pip install --ignore-installed google-cloud-vision


EXPOSE 8888
