FROM rocker/shiny:4.4.1

LABEL maintainer="ssnn"

RUN export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get install -y --fix-missing \
    gsfonts \
    imagemagick \
    libcurl4-openssl-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libglpk-dev \
    libgmp3-dev \
    libicu-dev \
    libmagick++-dev \
    libpng-dev \
    libssl-dev \
    libxml2-dev \
    make \
    pandoc \
    texlive-latex-base \
    texlive-fonts-recommended \
    texlive-fonts-extra \
    texlive-latex-extra \    
    xdg-utils \
    zlib1g-dev

ARG R_DEPS="c('devtools', \
              'BiocManager')"
ARG BIOC_DEPS="c('Biostrings', \
                'GenomicAlignments', \
                'IRanges')"
RUN Rscript -e "install.packages(${R_DEPS}, dependencies=TRUE, clean=TRUE);lapply(${R_DEPS}, library, character.only = TRUE)"
RUN Rscript -e "BiocManager::install(${BIOC_DEPS});lapply(${BIOC_DEPS}, library, character.only = TRUE)"
RUN Rscript -e "devtools::install_github('airr-community/rep-cred', ref='master', dependencies=TRUE);library(repcred)"
RUN Rscript -e "repcred<-system.file('repcred.R', package='repcred');file.copy(repcred,'/usr/local/bin/repcred')" \
    && chmod +x /usr/local/bin/repcred
WORKDIR /home
SHELL ["/bin/bash", "-c"]
ENTRYPOINT Rscript -e "repcred::repcredWeb(launch.browser = F)"
