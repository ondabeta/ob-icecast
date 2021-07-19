FROM stephanel/icecast-kh

COPY --from=hairyhenderson/gomplate:v3.8.0-slim /gomplate /bin/gomplate

COPY start.sh /start.sh
COPY entrypoint.sh /entrypoint.sh

COPY status-json.xsl /usr/share/icecast/web/status-json.xsl
COPY icecast.xml /etc/icecast.xml.base

ENTRYPOINT ["/entrypoint.sh"]
