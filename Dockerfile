FROM lscr.io/linuxserver/webtop:ubuntu-xfce

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y pspp \
    && apt-get install -y git \
    && apt-get install -y wget

RUN wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | gpg --dearmor -o /usr/share/keyrings/r-project.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/r-project.gpg] https://cloud.r-project.org/bin/linux/ubuntu jammy-cran40/" | tee -a /etc/apt/sources.list.d/r-project.list \
    && apt-get update \
    && apt-get install r-base -y \
		&& apt-get install -y libreoffice \
		&& apt-get autoremove \
    && apt-get clean all \
		&& apt-get purge \
		&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors_amd64.deb \
	&& apt-get update \
	&& apt-get install -y ./onlyoffice-desktopeditors_amd64.deb

RUN apt-get update \
		&& apt-get upgrade -y \
		&& echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections \
		&& apt-get install -y ttf-mscorefonts-installer \
		&& apt-get clean all \
		&& apt-get purge \
		&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get update \
&& apt-get upgrade -y \
&& apt-get install -y libgit2-dev build-essential libcurl4-gnutls-dev libxml2-dev  \
&& apt-get install -y libssl-dev libfontconfig1-dev freetype2-doc libharfbuzz-dev libfribidi-dev libfreetype6-dev libpng-dev libtiff5-dev libjpeg-dev \
&& apt-get clean all && \
apt-get purge && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#https://stackoverflow.com/questions/65433724/configuration-failed-to-find-libgit2-library
#https://github.com/r-lib/devtools/issues/2131
 

#RUN Rscript -e "install.packages(c('tidyverse', 'sjlabelled', 'haven', 'magrittr', 'dplyr', 'psych', 'knitr', 'ggthemes'), repos='https://cran.wu.ac.at/');"
RUN R -e "install.packages('devtools', dependencies=TRUE, repos='https://cran.wu.ac.at/');   if (!library(devtools, logical.return=T)) quit(status=10)"
RUN R -e "install.packages('tidyverse', dependencies=TRUE, repos='https://cran.wu.ac.at/');   if (!library(tidyverse, logical.return=T)) quit(status=10)"
RUN R -e "install.packages('sjlabelled', dependencies=TRUE, repos='https://cran.wu.ac.at/');   if (!library(sjlabelled, logical.return=T)) quit(status=10)"
RUN R -e "install.packages('haven', dependencies=TRUE, repos='https://cran.wu.ac.at/');   if (!library(haven, logical.return=T)) quit(status=10)"
RUN R -e "install.packages('magrittr', dependencies=TRUE, repos='https://cran.wu.ac.at/');   if (!library(magrittr, logical.return=T)) quit(status=10)"
RUN R -e "install.packages('dplyr', dependencies=TRUE, repos='https://cran.wu.ac.at/');   if (!library(dplyr, logical.return=T)) quit(status=10)"
RUN R -e "install.packages('psych', dependencies=TRUE, repos='https://cran.wu.ac.at/');   if (!library(psych, logical.return=T)) quit(status=10)"
RUN R -e "install.packages('knitr', dependencies=TRUE, repos='https://cran.wu.ac.at/');   if (!library(knitr, logical.return=T)) quit(status=10)"
RUN R -e "install.packages('ggthemes', dependencies=TRUE, repos='https://cran.wu.ac.at/');   if (!library(ggthemes, logical.return=T)) quit(status=10)"
RUN R -e "devtools::install_github('LukasKraiger/frame')"
#https://stackoverflow.com/questions/45289764/install-r-packages-using-docker-file
