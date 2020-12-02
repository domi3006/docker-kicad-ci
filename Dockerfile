FROM ubuntu:20.04
MAINTAINER Dominik Laton <dominik.laton@web.de>

RUN apt-get update && apt-get -yqq install software-properties-common

RUN add-apt-repository --yes ppa:kicad/kicad-5.1-releases && \
	apt-get -yqq --no-install-recommends install kicad kicad-libraries kicad-packages3d kicad-symbols kicad-templates kicad-footprints

RUN apt-get -yqq install \
	jq \
	python3 \
	python3-yaml \
	python3-wxgtk4.0 \
	python3-xlsxwriter \
	python3-pip \
	findutils \
	curl \
	wget \
	git

# could be set to -u <github_user>:<github_pass/github_token>
ARG EXTRA_PARM=""

RUN \
	curl -LJO $(curl $EXTRA_PARM -s https://api.github.com/repos/INTI-CMNB/InteractiveHtmlBom/releases/latest | jq -j '.assets[0].browser_download_url') && \
	curl -LJO $(curl $EXTRA_PARM -s https://api.github.com/repos/INTI-CMNB/KiAuto/releases/latest | jq -j '.assets[0].browser_download_url') && \
	curl -LJO $(curl $EXTRA_PARM -s https://api.github.com/repos/INTI-CMNB/KiBoM/releases/latest | jq -j '.assets[0].browser_download_url') && \
	curl -LJO $(curl $EXTRA_PARM -s https://api.github.com/repos/INTI-CMNB/KiBot/releases/latest | jq -j '.assets[0].browser_download_url') && \
	curl $EXTRA_PARM -s https://api.github.com/repos/INTI-CMNB/PcbDraw/releases/latest | jq -j '.assets | map(.browser_download_url) | join(" ")' | xargs -n1 curl -LJO && \
	apt -yqq install --no-install-recommends ./*.deb && rm *.deb
