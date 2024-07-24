FROM ubuntu:jammy

RUN apt update && apt dist-upgrade -y

RUN apt install \
    curl \
    python3-pip \
    python3-venv \
    unixodbc-dev \
    g++ \
    gcc \
    git \
    libpq-dev \
    -y

RUN curl https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc
RUN curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list | tee /etc/apt/sources.list.d/mssql-release.list
RUN apt update && ACCEPT_EULA=Y apt install -y msodbcsql17 mssql-tools
