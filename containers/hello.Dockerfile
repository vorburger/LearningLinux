# TODO refactor and put Dev Tools into container separate from kernel-dev
FROM kernel-dev AS hello-dev

ADD hello.c .

RUN gcc hello.c -o hello
RUN ./hello

RUN gcc hello.c -static -o hello-static
RUN ./hello-static

FROM scratch
COPY --from=hello-dev /home/tux/hello-static .
RUN ["./hello-static"]
ENTRYPOINT ["./hello-static"]
