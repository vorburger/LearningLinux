FROM kernel-dev

RUN cd linux-stable  && \
    make x86_64_defconfig  && \
    make kvmconfig  && \
    time make -j $(nproc)

# make tinyconfig does not boot under qemu
