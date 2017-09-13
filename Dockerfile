# DEVELOPMENT DOCKERFILE

FROM ruby:2.4.1

RUN apt-get update && apt-get install vim postgresql-client redis-tools cifs-utils -y

RUN gem install rails

RUN cd /usr/local                                                        \
    && wget https://nodejs.org/dist/v8.4.0/node-v8.4.0-linux-x64.tar.xz  \
    && tar -xvf node-v8.4.0-linux-x64.tar.xz                             \
    && mv node-v8.4.0-linux-x64 node                                     \
    && rm node-v8.4.0-linux-x64.tar.xz

ENV PATH "/usr/local/node/bin:$PATH"
ENV PORT "3333"
ENV HOST "0.0.0.0"
ENV RAILS_ENV "development"

RUN npm i -g yarn
COPY . /usr/src/app
WORKDIR /usr/src/app

RUN bundle install

ENV RAILS_SERVE_STATIC_FILES=true
ENV SECRET_KEY_BASE "2c322e4da8c9357dd61b1e6c19c999ff2c866972654806838a1af65db827affc9ba3625dacbfb3783a3d38df78d1214d10240c8b3bb5f50660b3c448c266a249"
RUN rails assets:clobber && rais assets:precompile

EXPOSE 3333
CMD ["rails", "server"]
