FROM ubuntu:latest
RUN apt-get -y update \
    && apt-get install -y curl \
    && apt-get -y autoclean
# nvm environment variables
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 10.16.3

# install nvm
# https://github.com/creationix/nvm#install-script
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash

# install node and npm
RUN . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# confirm installation
RUN node -v
RUN npm -v

# create directory for child images to store configuration in
RUN apt-get -y install supervisor && \
mkdir -p /var/log/supervisor && \
mkdir -p /etc/supervisor/conf.d
# supervisor base configuration
ADD supervisor.conf /etc/supervisor.conf

WORKDIR /usr/src/webapp/app1
COPY app1/ /usr/src/webapp/app1

WORKDIR /usr/src/webapp/app2
COPY app2/ /usr/src/webapp/app2
CMD ["supervisord", "-c", "/etc/supervisor.conf"]