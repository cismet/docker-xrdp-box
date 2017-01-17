FROM ubuntu:xenial
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y 
RUN apt-get install -y software-properties-common
RUN apt-add-repository -y ppa:ubuntu-mate-dev/xenial-mate
RUN apt-get update -y
RUN apt full-upgrade -y
RUN apt-get dist-upgrade -y
RUN apt-get install -y mate-core
RUN apt-get install -y mate-desktop-environment
RUN apt-get install -y mate-notification-daemon
#RUN apt-get install -y gconf-service libnspr4 libnss3 fonts-liberation
#RUN apt-get install -y libappindicator1 libcurl3 fonts-wqy-microhei
#RUN apt-get install -y firefox

RUN apt-get install -y supervisor
RUN apt-get install -y xrdp

ADD xrdp.conf /etc/supervisor/conf.d/xrdp.conf


EXPOSE 3389

# Allow all users to connect via RDP.
RUN sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini && \
    sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini
RUN xrdp-keygen xrdp auto
RUN apt-get install -y vim

# Install Java.
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  apt-get update -y && \
  apt-get install -y software-properties-common && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/cache/oracle-jdk8-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle


RUN apt-get install -y caja-dropbox


RUN apt-get autoclean && apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

COPY gsettings.sh /gsettings.sh
COPY autostart.desktop /etc/xdg/autostart/autostart.desktop
RUN chmod +x /gsettings.sh

#COPY caja-dropbox.desktop /etc/xdg/autostart/caja-dropbox.desktop


CMD ["/usr/bin/supervisord", "-n"]

# Set the locale
RUN locale-gen de_DE.UTF-8
ENV LANG de_DE.UTF-8
ENV LANGUAGE de_DE:de
ENV LC_ALL de_DE.UTF-8
RUN update-locale LANG=de_DE.UTF-8
RUN ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime && dpkg-reconfigure -f noninteractive tzdata
COPY cismet.png /cismet.png
