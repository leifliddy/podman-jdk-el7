FROM registry.centos.org/centos:7

ENV openjdk_srpm java-17-openjdk-17.0.4.1.1-2.el7.src.rpm

COPY files/bashrc /root/.bashrc
COPY files/devtoolset-8.sh /etc/profile.d/
COPY files/adoptium.repo /etc/yum.repos.d/
COPY files/rpmmacros /root/.rpmmacros
COPY files/$openjdk_srpm /root

RUN yum update -y &&\
    yum install -y centos-release-scl &&\
    yum install -y alsa-lib-devel autoconf automake cups-devel desktop-file-utils elfutils-devel fontconfig-devel freetype-devel gcc gcc-c++ gdb giflib-devel harfbuzz-devel lcms2-devel libX11-devel libXi-devel libXinerama-devel libXrandr-devel libXrender-devel libXt-devel libXtst-devel libjpeg-turbo-devel libpng-devel libxslt make nss-devel pkgconfig systemtap-sdt-devel tzdata-java xorg-x11-proto-devel zip javapackages-tools dnf dnf-plugins-core vim-enhanced yum-utils devtoolset-8-gcc-c++ wget rpm-build bash-completion temurin-17-jdk &&\
    ln -sr /usr/lib/jvm/temurin-17-jdk /usr/lib/jvm/java-17-openjdk &&\
    yum-builddep -y /root/$openjdk_srpm &&\
    find /root/ -type f | egrep 'anaconda-ks.cfg|anaconda-post-nochroot.log|anaconda-post.log|original-ks.cfg' | xargs rm -f &&\
    echo 'scl enable devtoolset-8 bash' >> /root/.bash_profile &&\
    echo 'defaultyes=True' >> /etc/dnf/dnf.conf &&\
    mkdir -p /root/.bashrc.d

COPY files/bashrc-rpmbuild /root/.bashrc.d/rpmbuild

# set login directory
WORKDIR /root

CMD ["/bin/bash"]
