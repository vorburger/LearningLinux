FROM busybox:1.32

ADD https://git.busybox.net/busybox/plain/examples/udhcp/simple.script /usr/share/udhcpc/default.script
RUN chmod +x /usr/share/udhcpc/default.script

ADD busybox-init /init
