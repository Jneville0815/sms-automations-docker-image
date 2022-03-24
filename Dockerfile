FROM ubuntu

ENV LANG="en_US.UTF-8"
ENV LC_CTYPE="en_US.UTF-8"

WORKDIR /tmp

RUN apt-get update && \
    apt-get -y upgrade python3.8 python3-pip unzip wget zip git curl && \

    wget https://releases.hashicorp.com/terraform/1.1.7/terraform_1.1.7_linux_amd64.zip && \
    unzip terraform_1.1.7_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \

    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \

    pip3 install pipenv && \
    mkdir all_python_deps && cd all_python_deps && \
    pipenv --python 3.8 && \
    pip3 install --target=$(pipenv --venv)/lib/python3.8/site-packages bs4 twilio

ENTRYPOINT ["/usr/bin/env", "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"]