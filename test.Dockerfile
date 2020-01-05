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
    py-pip \
    python-dev \
    pip install docker \
    pip install docker-compose \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR /app/test

COPY Gemfile ./
COPY Gemfile.lock ./

RUN bundle install 

COPY ./ ./

USER jenkins
