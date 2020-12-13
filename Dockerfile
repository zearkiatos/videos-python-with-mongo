FROM python:3 as anaconda-stage

RUN apt-get update && apt-get upgrade -y && \
yes | apt-get -y install libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6 && \
cd ~ && \
mkdir tmp && \
cd tmp && \
wget https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh && \
bash Anaconda3-2020.02-Linux-x86_64.sh -b -p $HOME/conda

ENV PATH=$PATH:/root/conda/bin

RUN echo 'export PATH=/root/conda/bin:$PATH' >> /root/.bashrc 

WORKDIR /usr/src/app

COPY requirements.txt ./

RUN conda init bash

SHELL ["bash", "-lc"]

RUN conda create --name videos-python-with-mongo && \
conda activate videos-python-with-mongo && \
pip install --no-cache-dir -r requirements.txt && \
pip install python-dotenv

COPY . .

CMD flask run --host=0.0.0.0 --port=5000

EXPOSE 5001