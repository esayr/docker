FROM docker.v909.com/cn-ubuntu:14.04

MAINTAINER Easy Rong <phpvcn@php.net>

ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No
ENV LANG en_US.UTF-8

# Surpress Upstart errors/warning
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:nginx/stable && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends supervisor nginx php5-fpm php5-mcrypt php5-gd php5-mysql php5-curl php5-redis php5-mongo && \
    apt-get remove --purge -y software-properties-common && \
    apt-get autoremove -y && \
    apt-get clean && \
    apt-get autoclean && \
    rm -fr /var/lib/apt/lists/* && \
    rm -rf /usr/share/man/?? && \
    rm -rf /usr/share/man/??_*

# tweak nginx config
RUN sed -i -e"s/worker_processes  1/worker_processes 4/" /etc/nginx/nginx.conf && \
    sed -i -e"s/keepalive_timeout\s*65/keepalive_timeout 2/" /etc/nginx/nginx.conf && \
    sed -i -e"s/keepalive_timeout 2/keepalive_timeout 2;\n\tclient_max_body_size 100m/" /etc/nginx/nginx.conf && \
    echo "\ndaemon off;" >> /etc/nginx/nginx.conf

# tweak php-fpm config
RUN sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php5/fpm/php.ini && \
    sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 100M/g" /etc/php5/fpm/php.ini && \
    sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 100M/g" /etc/php5/fpm/php.ini && \
    sed -i -e "s/session.gc_probability\s*=\s*0/session.gc_probability = 1/g" /etc/php5/fpm/php.ini && \
    sed -i -e "s/;short_open_tag\s*=\s*Off/short_open_tag = On/g" /etc/php5/fpm/php-fpm.conf && \
    sed -i -e "s/;catch_workers_output\s*=\s*yes/catch_workers_output = yes/g" /etc/php5/fpm/pool.d/www.conf && \
    sed -i -e "s/pm.max_children = 5/pm.max_children = 9/g" /etc/php5/fpm/pool.d/www.conf && \
    sed -i -e "s/pm.start_servers = 2/pm.start_servers = 3/g" /etc/php5/fpm/pool.d/www.conf && \
    sed -i -e "s/pm.min_spare_servers = 1/pm.min_spare_servers = 2/g" /etc/php5/fpm/pool.d/www.conf && \
    sed -i -e "s/pm.max_spare_servers = 3/pm.max_spare_servers = 4/g" /etc/php5/fpm/pool.d/www.conf && \
    sed -i -e "s/pm.max_requests = 500/pm.max_requests = 200/g" /etc/php5/fpm/pool.d/www.conf


# fix ownership of sock file for php-fpm
RUN sed -i -e "s/;listen.mode = 0660/listen.mode = 0750/g" /etc/php5/fpm/pool.d/www.conf 
#&& \ find /etc/php5/cli/conf.d/ -name "*.ini" -exec sed -i -re 's/^(\s*)#(.*)/\1;\2/g' {} \;


# nginx site conf
RUN rm -fr /etc/nginx/conf.d/* && \
    rm -fr /etc/nginx/sites-available/default && \
    mkdir -p /etc/nginx/ssl/
ADD ./conf/nginx-default.conf /etc/nginx/sites-available/default.conf
RUN ln -s /etc/nginx/sites-available/* /etc/nginx/sites-enabled/

# Supervisor Config
ADD ./supervisord.conf /etc/supervisord.conf

# Start Supervisord
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh

# Setup Volume
VOLUME ["/var/www", "/etc/nginx/sites-enabled"]

# add test PHP file
ADD ./index.php /var/www/index.php
RUN chown -Rf www-data.www-data /var/www/

EXPOSE 80 443

CMD ["/bin/bash", "/start.sh"]