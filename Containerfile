ARG FEDORA_VERSION=37

# See https://pagure.io/releng/issue/11047 for final location
FROM ghcr.io/cgwalters/fedora-silverblue:${FEDORA_VERSION}

COPY etc /etc

RUN sed -i 's/#AutomaticUpdatePolicy.*/AutomaticUpdatePolicy=stage/' /etc/rpm-ostreed.conf && \
    systemctl enable rpm-ostreed-automatic.timer && \
    systemctl enable flatpak-automatic.timer && \
    rm -rf /var/* && \
    ostree container commit

RUN rpm-ostree override remove \
      firefox \
      firefox-langpacks \
      toolbox && \
    rpm-ostree install \
      gnome-tweaks \
      distrobox && \
    rm -rf /var/* && \
    ostree container commit

RUN rpm-ostree install \
      https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
      https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && \
    rpm-ostree install \
      rpmfusion-nonfree-release  \
      rpmfusion-free-release  \
      --uninstall=rpmfusion-free-release-$(rpm -E %fedora)-1.noarch  \
      --uninstall=rpmfusion-nonfree-release-$(rpm -E %fedora)-1.noarch && \
    rm -rf /var/* && \
    ostree container commit

RUN rpm-ostree cleanup -m && \
    rm -rf /var/* && \
    ostree container commit

#FROM base AS nvidia
#
#RUN rpm-ostree install \
#      akmod-nvidia \
#      xorg-x11-drv-nvidia \
#      xorg-x11-drv-nvidia-cuda && \
#    rm -rf /var/* && \
#    ostree container commit
