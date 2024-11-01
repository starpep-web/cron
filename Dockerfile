FROM ruby:3.4-rc-alpine

RUN adduser -D starpep-cron
USER starpep-cron

WORKDIR /opt/app

COPY --chown=starpep-cron Gemfile* ./
RUN bundle install

COPY . .

CMD ["ruby", "./src/main.rb"]
