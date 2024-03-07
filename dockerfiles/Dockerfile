FROM cgr.dev/chainguard/jre:latest-dev

RUN wget -O /tmp/CrushFTP11.zip https://www.crushftp.com/early11/CrushFTP11.zip
# COPY ./CrushFTP11.zip /tmp/CrushFTP11.zip
RUN cd /tmp \
    && unzip CrushFTP11.zip \
    && rm /tmp/CrushFTP11/crushftp_init.sh \
    && rm /tmp/CrushFTP11/*.exe \
    && rm /tmp/CrushFTP11/CrushFTP.command \
    && rm /tmp/CrushFTP11/install_readme_macos.txt \
    && rm /tmp/CrushFTP11/install_readme_windows.txt \
    && rm /tmp/CrushFTP11/install_readme_linux.txt \
    && rm -rf /tmp/CrushFTP11/OSX_scripts


FROM cgr.dev/chainguard/jre:latest
# Pull datetime from build-arg for use in OCI labels
ARG RFC_DATE_TIME
ARG VERSION
ENV VERSION $VERSION
ENV DATE_TIME $RFC_DATE_TIME
# RUN export VERSION=$(java -jar CrushFTP11/CrushFTP.jar -version)
# Add some OCI labels
LABEL org.opencontainers.image.vendor="CrushFTP, LLC"
LABEL org.opencontainers.image.title="CrushFTP11"
LABEL org.opencontainers.image.version=$VERSION
LABEL org.opencontainers.image.description="Image for CrushFTP11 Server"
LABEL org.opencontainers.image.created=$DATE_TIME
LABEL org.opencontainers.image.os="wolfi"
LABEL org.opencontainers.image.base.name="cgr.dev/chainguard/jre"

COPY --from=0 --chown=java:java /tmp/CrushFTP11/ /app

# Default exposed ports
EXPOSE 8080
EXPOSE 443
EXPOSE 9090

# USER java # 65532
WORKDIR /app

ENTRYPOINT ["java", "-Ddir=/app", "-Xmx512M", "-jar", "plugins/lib/CrushFTPJarProxy.jar", "-ad", "crushadmin", "password" ]
