FROM python:3

RUN apt-get update && \
    yes | apt-get -y install libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6 && \
    wget -P /tmp https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh && \
    yes yes | bash /tmp/Anaconda3-2020.02-Linux-x86_64.sh && \
    source ~/.bashrc && \
    PATH=$PATH:$HOME/anaconda3/bin

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN $HOME/anaconda3/bin/conda create --name videos-python-with-mongo
RUN $HOME/anaconda3/bin/conda activate videos-python-with-mongo
RUN pip install --no-cache-dir -r requirements.txt && \
    pip install python-dotenv

COPY . .

CMD flask run

EXPOSE 5000