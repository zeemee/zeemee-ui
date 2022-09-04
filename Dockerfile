FROM ruby:3.1.2-slim

RUN apt-get update -qq && apt-get install -yq --no-install-recommends \
    build-essential \
    gnupg2 \
    less \
    git \
    libpq-dev \
    libvips42 \
    curl \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3 
  
RUN gem update --system && gem install bundler

RUN curl https://deb.nodesource.com/setup_12.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y nodejs yarn
RUN curl -o- -L https://yarnpkg.com/install.sh | bash
# unsure if this is needed or correct
RUN $HOME/.yarn/bin/yarn install
RUN $HOME/.yarn/bin/yarn add foundation-sites
RUN yarn

WORKDIR /usr/src/app

ENTRYPOINT ["./entrypoint.sh"]

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

RUN gem install bundler
ADD Gemfile* $APP_HOME/
RUN bundle install

ADD . $APP_HOME
RUN bundle exec rake assets:precompile

EXPOSE 3001

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
