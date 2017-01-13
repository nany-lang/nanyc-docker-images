FROM ubuntu:17.04
MAINTAINER Nanyc Team

RUN apt-get update
RUN apt-get --yes upgrade
RUN apt-get --yes install apt-utils build-essential wget cmake unzip
