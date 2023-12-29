FROM ubuntu:jammy
# install some basic tools:
RUN apt update && apt install -y sudo curl git python3-pip
# install the github cli:
RUN type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
RUN sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
RUN sudo apt update && sudo apt install gh -y
# install github cli extensions:
RUN gh extension install https://github.com/nektos/gh-act
# install microsoft odbc driver 17 & sql tools:
RUN curl https://packages.microsoft.com/keys/microsoft.asc | tee /etc/apt/trusted.gpg.d/microsoft.asc
RUN curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list | tee /etc/apt/sources.list.d/mssql-release.list
RUN apt update && ACCEPT_EULA=Y apt install -y msodbcsql17 mssql-tools
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc

