FROM cgr.dev/chainguard/jre:latest-dev

# RUN wget -O /tmp/CrushFTP.zip https://www.crushftp.com/early10/CrushFTP10.zip
COPY ../CrushFTP10.zip /tmp/CrushFTP.zip
RUN cd /tmp \
    && unzip CrushFTP.zip \
    && rm /tmp/CrushFTP10/crushftp_init.sh \
    && rm /tmp/CrushFTP10/*.exe \
    && rm /tmp/CrushFTP10/CrushFTP.command \
    && rm /tmp/CrushFTP10/install_readme_macos.txt \
    && rm /tmp/CrushFTP10/install_readme_windows.txt \
    && rm /tmp/CrushFTP10/install_readme_linux.txt \
    && rm -rf /tmp/CrushFTP10/OSX_scripts


FROM cgr.dev/chainguard/jre:latest-dev
# Pull datetime from build-arg for use in OCI labels
ARG RFC_DATE_TIME
ARG VERSION
ENV VERSION $VERSION
ENV DATE_TIME $RFC_DATE_TIME
# RUN export VERSION=$(java -jar CrushFTP10/CrushFTP.jar -version)

# Add some OCI labels
LABEL org.opencontainers.image.vendor="CrushFTP, LLC"
LABEL org.opencontainers.image.title="CrushFTP"
LABEL org.opencontainers.image.version=$VERSION
LABEL org.opencontainers.image.description="Image for CrushFTP Server"
LABEL org.opencontainers.image.created=$DATE_TIME
LABEL org.opencontainers.image.os="wolfi"
LABEL org.opencontainers.image.base.name="cgr.dev/chainguard/jre"

COPY --from=0 --chown=java:java /app /app
COPY --from=0 --chown=java:java /tmp/CrushFTP10/ /app/CrushFTP10
COPY --chown=java:java --chmod=+x entrypoint.sh /entrypoint.sh
# # WITHOUT BUILD KIT:
# COPY --chown=java:java entrypoint.sh /entrypoint.sh

# USER java # 65532
WORKDIR /

# VOLUME [ "/app/CrushFTP" ]

ENTRYPOINT ["sh", "/entrypoint.sh"]