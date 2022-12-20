FROM lscr.io/linuxserver/webtop:ubuntu-xfce


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
