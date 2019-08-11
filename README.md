# HydrusWeb

HydrusWeb is a simple webfrontend for the Hydrus API.
Call up the website, enter your URL and API-Key that will be saved locally in your browser and now you can browse your file.
See [HydrusWeb](https://github.com/floogulinc/hydrus-web) for more info.

This container employs [nweb](https://www.ibm.com/developerworks/systems/library/es-nweb/index.html) with a few changes and prebuilt HydrusWeb for smallest container size.

The webserver runs on Port `80` and has no HTTP/S features. It's up to your reverse proxy be it nginx, apache or traefik to do the encryption.

Drop it in the shell `docker run --name hydrus-web --restart always -p 80:8080 legsplits/hydrus-web:latest` or use compose:
```
  hydrus-web:
    image: legsplits/hydrus-web:latest
    container_name: hydrus-web
    restart: always
    ports:
      - 8080:80
```
