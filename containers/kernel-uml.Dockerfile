FROM kernel-dev

RUN cd linux-stable  && \
    make tinyconfig ARCH=um  && \
    time make -j $(nproc) linux ARCH=um
