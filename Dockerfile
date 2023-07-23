FROM ruby:3.2.2

ARG APP_NAME

RUN apt-get update -qq && apt-get install -y default-mysql-client
RUN mkdir /${APP_NAME}
WORKDIR /${APP_NAME}
COPY Gemfile /${APP_NAME}/Gemfile
COPY Gemfile.lock /${APP_NAME}/Gemfile.lock
RUN bundle install
COPY . /${APP_NAME}

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
