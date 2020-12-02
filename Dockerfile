FROM ubuntu:20.04
MAINTAINER Dominik Laton <dominik.laton@web.de>

RUN apt-get update && apt-get -yqq install software-properties-common

RUN add-apt-repository --yes ppa:kicad/kicad-5.1-releases && \
	apt-get -yqq --no-install-recommends install kicad kicad-libraries kicad-packages3d kicad-symbols kicad-templates kicad-footprints

RUN apt-get -yqq install \
	python3 \
	python3-yaml \
	python3-wxgtk4.0 \
	python3-xlsxwriter \
	python3-pip \
	curl \
	wget \
	git



RUN mkdir -p /tmp/debs && cd /tmp/debs && \
	curl -s https://api.github.com/repos/INTI-CMNB/KiAuto/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -i - && \
	curl -s https://api.github.com/repos/INTI-CMNB/KiBoM/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -i - && \
	curl -s https://api.github.com/repos/INTI-CMNB/InteractiveHtmlBom/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -i - && \
	curl -s https://api.github.com/repos/INTI-CMNB/PcbDraw/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -i - && \
	curl -s https://api.github.com/repos/INTI-CMNB/KiBot/releases/latest | grep "browser_download_url.*deb" | cut -d : -f 2,3 | tr -d \" | wget -i - && \
	apt -yqq install --no-install-recommends ./*.deb && \
	cd $HOME && rm -rf /tmp/debs
