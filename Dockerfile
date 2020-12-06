FROM ubuntu:20.04
MAINTAINER Dominik Laton <dominik.laton@web.de>

RUN apt-get update && apt-get -yqq install software-properties-common

RUN add-apt-repository --yes ppa:kicad/kicad-5.1-releases && \
	apt-get -yqq --no-install-recommends install kicad kicad-libraries kicad-packages3d kicad-symbols kicad-templates kicad-footprints

RUN apt-get -yqq install \
	curl \
	dpkg-dev \
	fakeroot \
	findutils \
	git \
	imagemagick \
	jq \
	librsvg2-bin \
	libxdo3 \
	python3 \
	python3-colorama \
	python3-lxml \
	python3-mistune \
	python3-numpy \
	python3-pip \
	python3-psutil \
	python3-wand \
	python3-wxgtk4.0 \
	python3-xlsxwriter \
	python3-xvfbwrapper \
	python3-yaml \
	recordmydesktop \
	xclip \
	xdotool \
	xserver-common \
	xvfb

# could be set to -u <github_user>:<github_pass/github_token>
ARG EXTRA_PARM=""

RUN \
	curl -LJO $(curl $EXTRA_PARM -s https://api.github.com/repos/INTI-CMNB/InteractiveHtmlBom/releases/latest | jq -j '.assets[0].browser_download_url') && \
	curl -LJO $(curl $EXTRA_PARM -s https://api.github.com/repos/INTI-CMNB/KiAuto/releases/latest | jq -j '.assets[0].browser_download_url') && \
	curl -LJO $(curl $EXTRA_PARM -s https://api.github.com/repos/INTI-CMNB/KiBoM/releases/latest | jq -j '.assets[0].browser_download_url') && \
	curl -LJO $(curl $EXTRA_PARM -s https://api.github.com/repos/INTI-CMNB/KiBot/releases/latest | jq -j '.assets[0].browser_download_url') && \
	curl $EXTRA_PARM -s https://api.github.com/repos/INTI-CMNB/PcbDraw/releases/latest | jq -j '.assets | map(.browser_download_url) | join(" ")' | xargs -n1 curl -LJO && \
	dpkg --install ./*.deb && rm *.deb


RUN rm -rf /var/lib/apt/lists/*
