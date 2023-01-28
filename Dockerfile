FROM archlinux:latest

RUN pacman -Syyu --noconfirm --needed git base-devel bc cpio github-cli asp shadow  bc libelf pahole cpio perl tar xz gettext xmlto python-sphinx python-sphinx_rtd_theme graphviz imagemagick texlive-latexextra git

RUN useradd -m -G wheel builder
RUN echo "%wheel ALL=(ALL:ALL) NOPASSWD:ALL" >/etc/sudoers.d/00-sudo-nopasswd

RUN mkdir /data
VOLUME /data
RUN mkdir /data/linux
RUN chown -R builder:builder /data/linux

USER builder

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
