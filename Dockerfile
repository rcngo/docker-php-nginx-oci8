FROM eliasaraujo/hpe-ol7.4-oracle12.2:1.0


# Variables
ENV nginx_conf /etc/nginx/nginx.conf
ENV php_conf /etc/php.ini
ENV fpm_conf /etc/php-fpm.conf
ENV fpm_pool /etc/php-fpm.d/www.conf

# Install repositories
RUN yum -y localinstall --setopt=tsflags=nodocs https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum -y localinstall --setopt=tsflags=nodocs https://mirror.webtatic.com/yum/el7/webtatic-release.rpm && \
    yum -y install --setopt=tsflags=nodocs php71w-cli php71w-fpm php71w-ldap php71w-opcache php71w-soap \
    php71w-pear php71w-devel \
    php71w-gd php71w-mbstring php71w-odbc php71w-xml \
    gcc make libaio \
    nginx supervisor && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    echo 'instantclient,/u01/app/oracle/product/12.2.0/client_1' | pecl install oci8 && \
    sed -i -e "860i\extension=oci8.so" ${php_conf} && \
    sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" ${php_conf} && \
    sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 100M/g" ${php_conf} && \
    sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 100M/g" ${php_conf} && \
    sed -i -e "s/variables_order = \"GPCS\"/variables_order = \"EGPCS\"/g" ${php_conf} && \
    sed -i -e "s/daemonize\s*=\s*yes/daemonize = no/g" ${fpm_conf} && \
    sed -i -e "s/listen = 127.0.0.1:9000/listen = \/run\/php-fpm\/php-fpm.sock/g" ${fpm_pool} && \
    sed -i -e "s/;listen.owner = nobody/listen.owner = nginx/g" ${fpm_pool} && \
    sed -i -e "s/;listen.group = nobody/listen.group = nginx/g" ${fpm_pool} && \
    sed -i -e "s/user = apache/user = nginx/g" ${fpm_pool} && \
    sed -i -e "s/group = apache/group = nginx/g" ${fpm_pool} && \
    sed -i -e '5i\daemon off;' ${nginx_conf} && \
    sed -i -e "s/listen       80 default_server;/listen       80;/g" ${nginx_conf} && \
    rm -f /etc/supervisord.conf && \
    sed -i '2i\clean_requirements_on_remove=1' /etc/yum.conf && \
    yum -y autoremove gcc php71w-devel php71w-pear && \
    yum clean all && \
    rm -rf /var/cache/yum

# Copy nginx files
ADD infra/conf/supervisord.conf /etc/supervisord.conf


CMD ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
