# Stage 1. Grab TZ data
FROM registry.access.redhat.com/ubi8/ubi-minimal as tzdataUpdate

USER root
RUN microdnf update \
 && microdnf reinstall tzdata -y \
 && microdnf clean all

# Stage 2. Use TZ data from stage above here and build UBI Java Runtime image
FROM registry.access.redhat.com/ubi8/openjdk-11-runtime

WORKDIR /
COPY --from=tzdataUpdate /usr/share/zoneinfo/Pacific/Auckland usr/share/zoneinfo/Pacific/Auckland
COPY --from=tzdataUpdate /usr/share/zoneinfo/UTC usr/share/zoneinfo/UTC
VOLUME /tmp
