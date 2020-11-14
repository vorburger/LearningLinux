FROM fedora-dev AS hello.asm-dev
ADD src/hello.asm .

RUN nasm -f elf64 hello.asm && \
    ld -s -o hello hello.o


FROM scratch
COPY --from=hello.asm-dev /home/tux/hello /hello
RUN ["/hello"]
ENTRYPOINT ["/hello"]
