FROM ruby:2.3.8

USER root

RUN apt-get update && \
    apt-get install -y build-essential \
    libcurl4-openssl-dev \
    libxml2-dev \
    libsqlite3-dev \
    libpq-dev \
    nodejs \
    postgresql \
    postgresql-client \
    python-pip \
    wget
    # apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
RUN apt-get update && \
    apt-get install -y apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/debian \
        $(lsb_release -cs) \
        stable" && \
    apt-get update && apt-get install -y docker-ce && \
    usermod -aG docker root
    # usermod -aG root jenkins

RUN curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /app/test

COPY Gemfile ./
COPY Gemfile.lock ./

RUN bundle install 

ENV RAILS_ENV=test

COPY ./ ./

# USER jenkins
