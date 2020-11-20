FROM ubuntu:20.04
MAINTAINER Dominik Laton <dominik.laton@web.de>

RUN apt-get update && apt-get -yqq install software-properties-common

RUN add-apt-repository --yes ppa:kicad/kicad-5.1-releases && \
	apt-get -yqq --no-install-recommends install kicad kicad-libraries

RUN apt-get -yqq install \
	python3 \
	python3-yaml \
	python3-wxgtk4.0 \
	python3-xlsxwriter \
	python3-pip \
	curl \
	wget \
	git

# FIXME: why does this not work?
#RUN pip3 install kiauto
#RUN pip3 install kibom
#RUN pip3 install pcbdraw
#RUN pip3 install --no-compile kibot

#RUN mkdir -p $HOME/.kicad_plugins && \
#	cd $HOME/.kicad_plugins && \
#	git clone https://github.com/openscopeproject/InteractiveHtmlBom.git && \
#	cd InteractiveHtmlBom && \
#	git fetch --tags && git checkout $(git describe --tags `git rev-list --tags --max-count=1`)

RUN mkdir -p /tmp/debs && cd /tmp/debs && \
	curl -s https://api.github.com/repos/INTI-CMNB/KiAuto/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -i - && \
	curl -s https://api.github.com/repos/INTI-CMNB/KiBoM/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -i - && \
	curl -s https://api.github.com/repos/INTI-CMNB/InteractiveHtmlBom/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -i - && \
	curl -s https://api.github.com/repos/INTI-CMNB/PcbDraw/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -i - && \
	curl -s https://api.github.com/repos/INTI-CMNB/KiBot/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -i - && \
	apt -yqq install --no-install-recommends ./*.deb && \
	cd $HOME && rm -rf /tmp/debs
