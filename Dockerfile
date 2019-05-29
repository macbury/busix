FROM phusion/baseimage:latest

ENV RAILS_ENV production
ENV NODE_ENV production
ENV TZ 'Europe/Warsaw'

RUN apt-add-repository ppa:brightbox/ruby-ng && apt-get update
RUN apt-get install -y ruby-switch ruby2.5 ruby2.5-dev
RUN ruby-switch --set ruby2.5

RUN apt-get update && apt-get -y install git build-essential libxslt-dev libxml2-dev zlib1g-dev libpq-dev nodejs
RUN echo $TZ > /etc/timezone && \
      apt-get update && apt-get install -y tzdata && \
      rm /etc/localtime && \
      ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
      dpkg-reconfigure -f noninteractive tzdata && \
      apt-get clean

RUN gem install bundler

RUN mkdir /etc/service/app
ADD start.sh /etc/service/app/run
RUN chmod +x /etc/service/app/run

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile /app
COPY Gemfile.lock /app
RUN bundle install

COPY . /app

CMD ["/sbin/my_init"]