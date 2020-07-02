FROM ruby:2.7.1-alpine AS builder

LABEL maintainer="Mike Rogers <me@mikerogers.io>"

RUN apk add --no-cache --virtual \
    nodejs-dev yarn bash \
    tzdata build-base libffi-dev

FROM builder as bridgetown-installer

# Setup directories within our container to run the code.
RUN mkdir -p /usr/src/bin
RUN mkdir -p /usr/src/App-Template
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install required gems
RUN gem install bridgetown

# Copy the interactive install script
COPY docker/interactive-install.rb /usr/src/bin

# Copy the "better defaults" app template
COPY App-Template /usr/src/App-Template/

# Let's run the rails new command
CMD ["ruby", "/usr/src/bin/interactive-install.rb"]
