# appchoo application chooser
# run image with
# echo -e "/path/to/image1.jpg output_this_string_if_image1_has_been_clicked\n/path/to/image2.png output_this_string_if_image2_has_been_clicked\n" | \
#     sudo docker run --rm -i -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix repo/image

FROM alpine:3.1

MAINTAINER Christian Stussak <stussak@mfo.de>

RUN apk update
RUN apk add xauth sdl sdl_image libpng jpeg

RUN apk add curl make gcc linux-headers libgcc sdl-dev sdl_image-dev musl-dev && \
    curl -SL https://github.com/porst17/appchoo/archive/master.tar.gz | tar -xz && \
    cd appchoo-master && \
    make && \
    cp appchoo /usr/local/bin/ && \ 
    rm -rf /appchoo-master && \
    apk del --purge curl make gcc linux-headers libgcc sdl-dev sdl_image-dev musl-dev

ENTRYPOINT [ "/usr/local/bin/appchoo" ]
