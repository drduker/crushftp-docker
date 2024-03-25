VERSION 0.7
FROM cgr.dev/chainguard/jre:latest-dev
# WORKDIR /crushftp-docker

build-all:
  # BUILD --platform=linux/amd64 --platform=linux/arm/v7 +build-local-image
  BUILD +download
  BUILD +local
  BUILD +dev
  BUILD +prd

local:
  BUILD --platform=linux/amd64 --platform=linux/arm64 +build-local-image

dev:
  BUILD --platform=linux/amd64 --platform=linux/arm64 +build-dev-11
# --platform=linux/amd64 --platform=linux/arm/v7

prd:
  BUILD --platform=linux/amd64 --platform=linux/arm64 +build-11 --VERSION=$(wget -qO- https://www.crushftp.com/version11_build.html | head -n 1 | awk '{print $2}' | grep -v selected) --RFC_DATE_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
  # BUILD --platform=linux/amd64 --platform=linux/arm/v7 +build-11-arm

download:
  FROM cgr.dev/chainguard/jre:latest-dev
  ARG VERSION=$(wget -qO- https://www.crushftp.com/version11_build.html | head -n 1 | awk '{print $2}' | grep -v selected)
  # ARG VERSION=beta # Copy the script that checks for the latest version
  COPY download_crushftp.sh /tmp/download_crushftp.sh
  # Copy folder into build context
  COPY . ./
  # Run the script to check if the zip file is the latest version
  RUN /tmp/download_crushftp.sh
  WORKDIR "/"
  SAVE ARTIFACT ./tmp/CrushFTP11
  SAVE ARTIFACT ./tmp/${VERSION}.zip AS LOCAL ./${VERSION}.zip

build-local-image:
  FROM cgr.dev/chainguard/jre:latest-dev
  ARG RFC_DATE_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
  ARG VERSION=$(wget -qO- https://www.crushftp.com/version11_build.html | head -n 1 | awk '{print $2}' | grep -v selected)
  ENV DATE_TIME $RFC_DATE_TIME
  # Add labels
  LABEL org.opencontainers.image.vendor="CrushFTP, LLC"
  LABEL org.opencontainers.image.version=$VERSION
  LABEL org.opencontainers.image.description="Image for CrushFTP Server"
  LABEL org.opencontainers.image.created=$DATE_TIME
  LABEL org.opencontainers.image.os="wolfi"
  LABEL org.opencontainers.image.base.name="cgr.dev/chainguard/jre"
  LABEL org.opencontainers.image.title="CrushFTP"
  # RUN export VERSION=$(java -jar CrushFTP11/CrushFTP.jar -version)
  COPY (+download/./CrushFTP11) /app
  COPY --chown=java:java --chmod 0755 entrypoint.sh /entrypoint.sh
  # USER java # 65532
  # WORKDIR /app
  ENTRYPOINT ["sh", "/entrypoint.sh"]
  SAVE IMAGE --push crushftp/crushftp11:local-dev

build-dev-11:
  FROM cgr.dev/chainguard/jre:latest-dev
  # Pull datetime from build-arg for use in OCI labels
  ARG RFC_DATE_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
  # ENV VERSION $VERSION
  ARG VERSION=$(wget -qO- https://www.crushftp.com/version11_build.html | head -n 1 | awk '{print $2}' | grep -v selected)
  ENV DATE_TIME $RFC_DATE_TIME
  # Add some OCI labels
  LABEL org.opencontainers.image.vendor="CrushFTP, LLC"
  LABEL org.opencontainers.image.title="CrushFTP"
  LABEL org.opencontainers.image.version=$VERSION
  LABEL org.opencontainers.image.description="Image for CrushFTP Server"
  LABEL org.opencontainers.image.created=$DATE_TIME
  LABEL org.opencontainers.image.os="wolfi"
  LABEL org.opencontainers.image.base.name="cgr.dev/chainguard/jre"
  COPY --chown=java:java (+download/./CrushFTP11) /app
  COPY --chown=java:java --chmod 0755 entrypoint.sh /entrypoint.sh
  # USER java # 65532
  # WORKDIR /app
  # VOLUME [ "/app/CrushFTP" ]
  ENTRYPOINT ["sh", "/entrypoint.sh"]
  SAVE IMAGE --push crushftp/crushftp11:latest-dev crushftp/crushftp11:$VERSION-dev

build-11:
  FROM cgr.dev/chainguard/jre:latest
  # Pull datetime from build-arg for use in OCI labels
  ARG RFC_DATE_TIME
  # ENV VERSION $VERSION
  ARG VERSION
  ENV DATE_TIME $RFC_DATE_TIME
  # Add some OCI labels
  LABEL org.opencontainers.image.vendor="CrushFTP, LLC"
  LABEL org.opencontainers.image.title="CrushFTP"
  LABEL org.opencontainers.image.version=$VERSION
  LABEL org.opencontainers.image.description="Image for CrushFTP Server"
  LABEL org.opencontainers.image.created=$DATE_TIME
  LABEL org.opencontainers.image.os="wolfi"
  LABEL org.opencontainers.image.base.name="cgr.dev/chainguard/jre"
  COPY --chown=java:java (+download/./CrushFTP11) /app
  # USER java # 65532
  # WORKDIR /app
  # VOLUME [ "/app/CrushFTP" ]
  ENTRYPOINT ["java", "-Ddir=/app", "-Xmx512M", "-jar", "plugins/lib/CrushFTPJarProxy.jar", "-ad", "crushadmin", "password"]
  SAVE IMAGE --push crushftp/crushftp11:latest crushftp/crushftp11:$VERSION


run-dev:
  LOCALLY
  WITH DOCKER --compose docker-compose-dev.yml
    RUN docker compose up 
  END

run:
  LOCALLY
  WITH DOCKER --compose docker-compose.yml
    RUN docker compose up 
  END
