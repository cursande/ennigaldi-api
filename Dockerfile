FROM ruby:2.5.1-alpine

ENV BUNDLE_JOBS=16 \
  BUNDLE_PATH=/bundle \
  HANAMI_HOST=0.0.0.0

RUN apk add --update --no-cache \
  build-base \
  postgresql-client \
  postgresql-dev \
  nodejs-current \
  git \
  tzdata \
  bash \
  zip

WORKDIR /app

# Use Gemfiles as docker cache markers
COPY Gemfile Gemfile.lock ./

# Install gems, then clean up cache files, and C source + compiled object files
RUN bundle install --without development \
  && rm -rf $BUNDLE_PATH/cache/*.gem \
  && find $BUNDLE_PATH/gems/ -name "*.c" -delete \
  && find $BUNDLE_PATH/gems/ -name "*.o" -delete

COPY . /app

EXPOSE 5000

ENTRYPOINT ["bundle", "exec"]
