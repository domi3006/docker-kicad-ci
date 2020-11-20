FROM ubuntu:20.04
MAINTAINER Dominik Laton <dominik.laton@web.de>

RUN apt-get update && apt-get -yqq install software-properties-common

RUN add-apt-repository --yes ppa:kicad/kicad-5.1-releases && \
	apt-get -yqq --no-install-recommends install kicad kicad-libraries

RUN apt-get -yqq install \
	python3-pip \
	git

RUN pip3 install kiauto
RUN pip3 install --no-compile kibot
RUN pip3 install kibom
RUN pip3 install pcbdraw

RUN mkdir -p $HOME/.kicad_plugins && \
	cd $HOME/.kicad_plugins && \
	git clone https://github.com/openscopeproject/InteractiveHtmlBom.git && \
	cd InteractiveHtmlBom && \
	git fetch --tags && git checkout $(git describe --tags `git rev-list --tags --max-count=1`)
