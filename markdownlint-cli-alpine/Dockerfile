FROM alpine:latest
LABEL version="1.0" MAINTAINER="Praveen Chamarthi"

# Install prerequisites
RUN apk update\
    && apk upgrade\
    && apk add wget bash git\
    # Install nodejs, npm
    && apk add nodejs nodejs-npm

# Install markdownlint-cli tool
RUN git clone https://github.com/igorshubovych/markdownlint-cli\
    && cd markdownlint-cli\
    && npm install -g markdownlint-cli\
    && cd ..\
    && rm -rf markdownlint-cli

ENTRYPOINT [ "/bin/bash" ]
