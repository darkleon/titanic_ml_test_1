FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    ca-certificates \
    gnupg \
    dirmngr \
    && rm -rf /var/lib/apt/lists/*

COPY ./requirements.txt /app
RUN pip3 install -r /app/requirements.txt
COPY . /app

CMD ["python3", "app_api.py"]
