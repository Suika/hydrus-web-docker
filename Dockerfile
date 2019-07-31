FROM alpine as nweb
RUN apk add gcc libc-dev
ADD /nweb24.c /nweb24.c
RUN cc -O2 nweb24.c -o nweb

FROM woahbase/alpine-ng as ngbuild
ADD https://api.github.com/repos/floogulinc/hydrus-web/git/refs/heads/master /version.json
RUN git clone https://github.com/floogulinc/hydrus-web /tmp/hydrus-web
WORKDIR /tmp/hydrus-web
RUN npm install --no-interactive
RUN ng build --prod

FROM alpine
COPY --from=nweb /nweb /sbin/nweb
COPY --from=ngbuild /tmp/hydrus-web/dist/hydrus-web /hydrus-web
HEALTHCHECK --interval=10s --timeout=5s --retries=3 \
  CMD wget --quiet --tries=1 --no-check-certificate --spider \
  http://localhost:80 || exit 1
CMD ["nweb", "80", "/hydrus-web"]
