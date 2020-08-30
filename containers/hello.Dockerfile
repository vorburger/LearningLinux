FROM fedora-dev AS hello-dev
ADD hello.c .

RUN gcc hello.c -o hello
RUN ./hello

RUN gcc hello.c -static -o hello-static
RUN ./hello-static


FROM scratch
COPY --from=hello-dev /home/tux/hello-static /init
RUN ["/init"]
ENTRYPOINT ["/init"]
