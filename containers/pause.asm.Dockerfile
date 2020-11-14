FROM fedora-dev AS pause.asm-dev
ADD src/pause.asm .

RUN nasm -f elf64 pause.asm && \
    ld -s -o pause pause.o


FROM scratch
COPY --from=pause.asm-dev /home/tux/pause /pause
ENTRYPOINT ["/pause"]
