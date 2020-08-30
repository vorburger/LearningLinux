FROM fedora-dev

ADD https://buildroot.org/downloads/buildroot-2020.08-rc3.tar.gz .

RUN tar xvzf buildroot*.tar.gz

RUN cd buildroot*/; ls -al
