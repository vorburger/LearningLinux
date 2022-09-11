FROM kernel-src

RUN cd linux-stable  && \
    make tinyconfig ARCH=um  && \
    time make -j $(nproc) linux ARCH=um
