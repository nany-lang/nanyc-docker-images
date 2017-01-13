FROM debian:stretch-slim
MAINTAINER Nanyc Team

RUN apt-get update
RUN apt-get --yes upgrade
RUN apt-get --yes install apt-utils build-essential cmake unzip
