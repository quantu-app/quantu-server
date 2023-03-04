ARG RUBY_VERSION=3.2.0
FROM ruby:$RUBY_VERSION-slim

RUN apt update -qq && \
    apt install -y build-essential libvips libpq-dev && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man

WORKDIR /app

ENV RAILS_LOG_TO_STDOUT="1" \
    RAILS_SERVE_STATIC_FILES="true" \
    RAILS_ENV="production" \
    BUNDLE_WITHOUT="development"

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

RUN bundle exec bootsnap precompile --gemfile app/ lib/

ENTRYPOINT ["/app/entrypoint.sh"]

EXPOSE 3000

CMD ["/app/bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]