FROM ruby:3.2.0-bullseye AS quantu-server

# Libraries
RUN apt-get update -qq && apt-get install -y postgresql-client

# Install Rails
RUN gem update --system
RUN gem install rails bundler

# Create default application working directory
ENV INSTALL_PATH /opt/app
RUN mkdir -p $INSTALL_PATH

WORKDIR /opt/app

# Default value to allow debug server to serve content over GitHub Codespace's port forwarding service
# The value is a comma-separated list of allowed domains 
ENV RAILS_DEVELOPMENT_HOSTS=".githubpreview.dev,.preview.app.github.dev,.app.github.dev"

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

COPY . /opt/app
RUN bundle install