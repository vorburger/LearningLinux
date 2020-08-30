FROM fedora-dev

RUN git clone --branch=v5.7.8 --depth 1 git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git

RUN cd linux-stable  && \
    git checkout -b v5.7.8
