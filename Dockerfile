FROM ubuntu:20.04

MAINTAINER piton223@yandex.ru


ARG UMDS_PACKAGE=VMware-UMDS-7.0.3.00200-9361122.tar.gz
ADD $UMDS_PACKAGE /tmp/

RUN apt update && apt -y install curl perl-base psmisc nginx supervisor

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log


RUN echo "/usr/local/vmware-umds" >> /tmp/answer && \
    echo "yes" >> /tmp/answer && \
    echo "no" >> /tmp/answer && \
    echo "/usr/share/nginx/html/umds" >> /tmp/answer && \
    cat /tmp/answer | /tmp/vmware-umds-distrib/vmware-install.pl EULA_AGREED=yes && \
    ln -s /usr/local/vmware-umds/bin/vmware-umds /usr/bin/vmware-umds

RUN vmware-umds -N -S && \
    vmware-umds -S --add-url http://vibsdepot.hpe.com/index-drv.xml --url-type HOST && \
    vmware-umds -S -e embeddedEsx-7.0.3

ADD ./supervisord/supervisord.conf /app/supervisord.conf

RUN chmod 777 /app/supervisord.conf
ENTRYPOINT ["supervisord", "-c", "/app/supervisord.conf"]
