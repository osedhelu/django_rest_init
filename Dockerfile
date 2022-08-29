FROM python:3.8
# Arguments defined in docker-compose.yml
ARG user
ARG uid
# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1
# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

RUN python -m pip install --upgrade pip

WORKDIR /app

COPY requirements.txt /app/requirements.txt
RUN pip3 install -r requirements.txt

RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/ && \
    chown -R $user:$user /home/$user

COPY . /app
USER $user