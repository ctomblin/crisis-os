# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /

# Base Image
FROM quay.io/fedora/fedora-silverblue:latest

RUN dnf5 -y copr enable bieszczaders/kernel-cachyos && \
	rpm-ostree override remove kernel  kernel-core kernel-modules kernel-modules-core kernel-modules-extra  --install kernel-cachyos && \
	dnf5 -y copr disable bieszczaders/kernel-cachyos


### MODIFICATIONS
## the following RUN directive does all the things required to run "build.sh"
RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build.sh && \
    dnf5 -y autoremove && \
    dnf5 clean all && \
    ostree container commit
    
### LINTING
## Verify final image and contents are correct.
RUN bootc container lint