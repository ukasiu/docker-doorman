FROM pataquets/nodejs

RUN \
  echo "deb http://ppa.launchpad.net/git-core/ppa/ubuntu $(lsb_release -cs) main" \
    | tee /etc/apt/sources.list.d/git.list && \
  DEBIAN_FRONTEND=noniteractive \
    apt-key adv --keyserver hkp://hkps.pool.sks-keyservers.net --recv-keys E1DF1F24 \
  && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
    apt-get -y --no-install-recommends install git \
  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/ \
  && \
  git clone --single-branch --branch master https://github.com/ukasiu/doorman.git && \
  cd /doorman && \
  npm install && \
  mv conf.environment.js conf.js

WORKDIR /doorman

ENTRYPOINT [ "npm", "start" ]
