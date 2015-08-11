FROM rocker/r-base

# MAINTAINER "MS"

RUN apt-get update \
&& apt-get install -t unstable -y --no-install-recommends \
    apt-utils \
    gdebi-core \
    sudo \
    ca-certificates \
    file \
    nano \
    git \
    psmisc \
    supervisor \
    dialog \
    ghostscript \
    imagemagick \
    lmodern \
    texlive-fonts-recommended \
    texlive-humanities \
    texlive-latex-extra \
    texinfo \
&& apt-get clean

# install required libs and dev
RUN apt-get install -t unstable -y --no-install-recommends \
    libssl-dev \
    libcurl4-gnutls-dev \
    libapparmor1 \
    libedit2 \
    libsqlite3-dev \
    libspatialite-dev \
    libxdmcp-dev \
    libx11-dev \
    libxcb1-dev \
    libpq-dev \
    krb5-multidev \
    mesa-common-dev \
    libglu1-mesa-dev \
    libglpk-dev \
    libv8-dev \
    libcairo2-dev \
    libglib2.0-dev \
    libfontconfig1-dev \
    libfreetype6-dev \
    libxt-dev \
    openssh-server \
    openssh-client \
    lsb-release \
    dbus \
    libboost-all-dev \
    proj-bin \
    libproj-dev \
    libhiredis-dev \
    libpoppler-glib-dev \
    libpoppler-glib-dev \
    libhdf5-dev \
    libhdf5-serial-dev \
    default-jdk \
    openjdk-7-jdk \
    default-jre \
    default-jre-headless \
    openjdk-7-jre \
    libgnome-2-0 \
    libgnomevfs2-0 \
    libxml2 \
    libxml2-dev \
&& apt-get clean

# Download and install libssl 0.9.8
RUN wget -q --no-check-certificate http://ftp.us.debian.org/debian/pool/main/o/openssl/libssl0.9.8_0.9.8o-4squeeze14_amd64.deb && \
    gdebi --n --q libssl0.9.8_0.9.8o-4squeeze14_amd64.deb && \
    rm -f libssl0.9.8_0.9.8o-4squeeze14_amd64.deb

# Download and install shiny server
RUN wget -q --no-check-certificate http://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/VERSION -O "version.txt" && \
    VERSION=$(cat version.txt) && \
    wget -q --no-check-certificate http://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/shiny-server-$VERSION-amd64.deb -O ss-latest.deb && \
    gdebi --n --q ss-latest.deb && \
    rm -f version.txt ss-latest.deb

# Download and install rstudio server
RUN wget -q --no-check-certificate http://s3.amazonaws.com/rstudio-server/current.ver && \
    VERSION=$(cat current.ver) && \
    wget -q --no-check-certificate http://download2.rstudio.org/rstudio-server-$VERSION-amd64.deb && \
    gdebi --n --q rstudio-server-$VERSION-amd64.deb && \
    rm rstudio-server-*-amd64.deb && \
    ln -s /usr/lib/rstudio-server/bin/pandoc/pandoc /usr/local/bin && \
    ln -s /usr/lib/rstudio-server/bin/pandoc/pandoc-citeproc /usr/local/bin && \
    apt-get clean

RUN usermod -l rstudio docker \
  && usermod -m -d /home/rstudio rstudio \
  && groupmod -n rstudio docker \
  && echo "rstudio:rstudio" | chpasswd

# install required tools
RUN apt-get install -t unstable -y --no-install-recommends \
    qrencode \
    zbar-tools \
    exiv2 \
    libimage-exiftool-perl \
    exifprobe \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/

# fix for "cannot find -lgfortran" error
RUN ln -s /usr/lib/x86_64-linux-gnu/libgfortran.so.3 /usr/lib/libgfortran.so

# install R packages (CRAN)
RUN install2.r --error \
    devtools \
    Formula \
    inline \
    htmlwidgets \
    shiny \
    shinyjs \
    shinydashboard \
    shinythemes \
    shinyBS \
    shinyTree \
    DT \
    dplyr \
    ramify \
    ggplot2 \
    dygraphs \
    leaflet \
    DiagrammeR \
    metricsgraphics \
    d3heatmap \
    scatterD3 \
    circlize \
    httr \
    lubridate \
    knitr \
    rjson \
    jsonlite \
    tidyjson \
    packrat \
    reshape2 \
    rmarkdown \
    rvest \
    readr \
    testthat \
    tidyr \
    car \
    caret \
    e1071 \
    hts \
    rredis \
    bizdays \
    C50 \
    changepoint \
    networkD3 \
    data.table \
    data.tree \
    ggmap \
    datamart \
    h5 \
    ftsa \
    descr \
    ggthemes \
    gistr \
    git2r \
    Hmisc \
    igraph \
    Matrix \
    network \
    lattice \
    latticeExtra \
    spatstat \
    TSdist \
    markdown \
    mclust \
    NbClust \
    party \
    partykit \
    rpart \
    raster \
    slackr \
    searchable \
    zoo \
    waffle \
    uuid \
    causaleffect \
    uniqtag \
    lessR \
    urltools \
    faoutlier \
    regexr \
    ISOcodes \
    daff \
    gplots \
    pROC \
    ROCR \
    riceware \
    dummy \
    infuser \
    threejs \
    ecp \
    clustertend \
    CausalFX \
    lavaan \
    stream \
    TSMining \
    treemap \
    NbClust \
    MTS \
    fpc \
    TSP \
    ptw \
    arules \
    arulesViz \
    geosphere \
    geostatsp \
    VIFCP \
    iptools \
    filehash \
    corrgram \
    tseriesEntropy \
    rgdal \
    RcppRedis \
    kknn \
    vcd \
    lctools \
    googleVis \
    Rpoppler \
    proxy \
    whoami \
    bcp \
    dbmss \
    dbscan \
    visNetwork \
    gamlss \
    glmgraph \
    lessR \
    fasttime \
    gmodels \
    statmod \
    dendextend \
    xgboost \
    iotools \
    ivmodel \
    partools \
&& apt-get clean 

RUN install2.r --error -r http://R-Forge.R-project.org jobqueue \
&& apt-get clean 
    
RUN Rscript -e 'source("http://bioconductor.org/biocLite.R"); biocLite("BiocInstaller")' \
&& install2.r --error \
    base64enc \
    Cairo \
    codetools \
    data.table \
    downloader \
    gridExtra \
    gtable \
    hexbin \
    jpeg \
    MASS \
    PKI \
    png \
    microbenchmark \
    mgcv \
    maps \
    maptools \
    mapmisc \
    mapproj \
    mapdata \
    multcomp \
    nlme \
    Rcpp \
    RCurl \
    rJava \
    RPostgreSQL \
    testit \
    XML \
    dtw \
    dtwclust \
    forecTheta \
    ggtern \
    ReporteRs \
&& apt-get clean 

# install R packages (GitHub)
RUN installGithub.r \
    hadley/lineprof \
    rstudio/rticles \
    jimhester/covr \
    google/CausalImpact \
    twitter/BreakoutDetection \
    twitter/AnomalyDetection \
    hrbrmstr/streamgraph \
    htmlwidgets/sparkline \
    trestletech/shinyAce \
    ropensci/plotly \
    hrbrmstr/shodan \
&& apt-get clean \
&& rm -rf /tmp/downloaded_packages/ /tmp/*.rds \
&& rm -rf /var/lib/apt/lists/

EXPOSE 3838

CMD ["shiny-server"]
