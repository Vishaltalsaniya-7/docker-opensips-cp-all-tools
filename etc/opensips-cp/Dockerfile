FROM debian:bullseye
LABEL maintainer=vishaltalsaniya991@gmail.com

USER root
ENV DEBIAN_FRONTEND=noninteractive

ARG OPENSIPS_CP_VERSION="8.3.1"

# Install all dependencies in a single layer to reduce image size
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    # Web server and PHP
    apache2 \
    libapache2-mod-php \
    php7.4 \
    php7.4-mysql \
    php7.4-gd \
    php7.4-curl \
    php7.4-cli \
    php-pear \
    php-apcu \
    # Database clients
    default-mysql-client \
    default-libmysqlclient-dev \
    # Utilities
    git \
    cron \
    vim \
    nano \
    net-tools \
    sngrep \
    iproute2 \
    iputils-ping \
    telnet \
    netcat-traditional \
    tcpdump \
    strace \
    lsof \
    gettext-base \
    build-essential \
    curl \
    # Python (if needed)
    python3 \
    python3-pip \
    python3-dev \
    python3-setuptools \
    python3-wheel && \
    # Install PEAR packages
    pear channel-update pear.php.net && \
    pear install MDB2 MDB2_Driver_mysqli && \
    # Cleanup
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Clone OpenSIPS Control Panel
WORKDIR /var/www/html/
RUN git clone --single-branch -b ${OPENSIPS_CP_VERSION} \
    https://github.com/OpenSIPS/opensips-cp.git && \
    chown -R www-data:www-data /var/www/html/opensips-cp/ && \
    git config --global --add safe.directory /var/www/html/opensips-cp

# Configure Apache
COPY opensips-cp.conf /etc/apache2/sites-available/opensips-cp.conf
RUN a2ensite opensips-cp.conf && \
    a2dissite 000-default.conf && \
    a2enmod rewrite

# Setup cron for statistics monitoring
WORKDIR /var/www/html/opensips-cp
RUN sed -i "s/root/www-data/g" \
    /var/www/html/opensips-cp/config/tools/system/smonitor/opensips_stats_cron && \
    cp /var/www/html/opensips-cp/config/tools/system/smonitor/opensips_stats_cron \
    /etc/cron.d/opensips_stats_cron && \
    chmod 0644 /etc/cron.d/opensips_stats_cron

# Copy configuration files
ONBUILD COPY image/modules.inc.php /var/www/html/opensips-cp/config/

# Copy and setup entrypoint
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost/cp/ || exit 1

EXPOSE 80

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["apache2"]












# FROM debian:bullseye
# LABEL maintainer=vishaltalsaniya991@gmail.com

# USER root
# ENV DEBIAN_FRONTEND=noninteractive

# # ARG OPENSIPS_CP_VERSION="8.2.4"
# ARG OPENSIPS_CP_VERSION="8.3.0"

# # Install all dependencies in a single layer to reduce image size
# RUN apt-get update -qq && \
#     apt-get install -y --no-install-recommends \
#     # Web server and PHP
#     apache2 \
#     libapache2-mod-php \
#     php7.4 \
#     php7.4-mysql \
#     php7.4-gd \
#     php7.4-curl \
#     php7.4-cli \
#     php-pear \
#     php-apcu \
#     # Database clients
#     default-mysql-client \
#     default-libmysqlclient-dev \
#     # Utilities
#     git \
#     cron \
#     vim \
#     nano \
#     net-tools \
#     sngrep \
#     iproute2 \
#     iputils-ping \
#     telnet \
#     netcat-traditional \
#     tcpdump \
#     strace \
#     lsof \
#     gettext-base \
#     build-essential \
#     # Python (if needed)
#     python3 \
#     python3-pip \
#     python3-dev \
#     python3-setuptools \
#     python3-wheel && \
#     # Install PEAR packages
#     pear channel-update pear.php.net && \
#     pear install MDB2 MDB2_Driver_mysqli && \
#     # Cleanup
#     apt-get clean && \
#     rm -rf /var/lib/apt/lists/*

# # Clone OpenSIPS Control Panel
# WORKDIR /var/www/html/
# RUN git clone --single-branch -b ${OPENSIPS_CP_VERSION} \
#     https://github.com/OpenSIPS/opensips-cp.git && \
#     chown -R www-data:www-data /var/www/html/opensips-cp/ && \
#     git config --global --add safe.directory /var/www/html/opensips-cp

# # Configure Apache
# COPY opensips-cp.conf /etc/apache2/sites-available/opensips-cp.conf
# RUN a2ensite opensips-cp.conf && \
#     a2dissite 000-default.conf && \
#     a2enmod rewrite

# # Setup cron for statistics monitoring
# WORKDIR /var/www/html/opensips-cp
# RUN sed -i "s/root/www-data/g" \
#     /var/www/html/opensips-cp/config/tools/system/smonitor/opensips_stats_cron && \
#     cp /var/www/html/opensips-cp/config/tools/system/smonitor/opensips_stats_cron \
#     /etc/cron.d/opensips_stats_cron && \
#     chmod 0644 /etc/cron.d/opensips_stats_cron

# # Copy configuration files
# ONBUILD COPY image/modules.inc.php /var/www/html/opensips-cp/config/

# # Copy and setup entrypoint
# COPY docker-entrypoint.sh /docker-entrypoint.sh
# RUN chmod +x /docker-entrypoint.sh

# # Health check
# HEALTHCHECK --interval=30s --timeout=3s --start-period=10s --retries=3 \
#     CMD curl -f http://localhost/cp/ || exit 1

# EXPOSE 80

# ENTRYPOINT ["/docker-entrypoint.sh"]
# CMD ["apache2"]

# # FROM debian:bullseye
# # LABEL maintainer=vishaltalsaniya991@gmail.com

# # USER root

# # ENV DEBIAN_FRONTEND=noninteractive

# # ARG OPENSIPS_CP_VERSION="8.2.4"

# # RUN apt-get -y update -qq && apt-get -y install git cron &&\
# #     apt-get -y install apache2 libapache2-mod-php php-curl &&\
# #     apt-get install -y default-mysql-client

# # RUN apt-get update && apt-get install -y --no-install-recommends \
# #     vim \
# #     nano \
# #     net-tools \
# #     sngrep \
# #     default-mysql-client \
# #     default-libmysqlclient-dev \
# #     build-essential \
# #     iproute2 \
# #     iputils-ping \
# #     telnet \
# #     git \
# #     python3 python3-pip python3-dev \
# #     python3-setuptools python3-wheel \
# #     netcat-traditional \
# #     tcpdump \
# #     strace \
# #     lsof \
# #     gettext-base \
# #  && apt-get clean \
# #  && rm -rf /var/lib/apt/lists/*

# # COPY opensips-cp.conf /etc/apache2/sites-available/
# # # COPY etc/opensips-cp/opensips-cp.conf /etc/apache2/sites-available/

# # WORKDIR /var/www/html/

# # RUN git clone --single-branch -b ${OPENSIPS_CP_VERSION} https://github.com/OpenSIPS/opensips-cp.git &&\
# #     chown -R www-data:www-data /var/www/html/opensips-cp/ &&\
# #     git config --global --add safe.directory /var/www/html/opensips-cp &&\
# #      apt-get update && apt-get install -y \
# #     php7.4 php7.4-mysql php7.4-gd php-pear php7.4-cli php-apcu &&\
# #     # apt-get -y install php php-mysql php-gd php-pear php-cli php-apcu &&\
# #     pear channel-update pear.php.net && \
# #     pear install MDB2 && \
# #     pear install MDB2_Driver_mysqli &&\
# #     a2ensite opensips-cp.conf &&\
# #     a2dissite 000-default.conf &&\
# #     a2enmod rewrite &&\
# #     rm -rf /var/lib/apt/lists/*

# # # Copy entrypoint script
# # COPY docker-entrypoint.sh /docker-entrypoint.sh
# # RUN chmod +x /docker-entrypoint.sh
# # WORKDIR /var/www/html/opensips-cp

# # ONBUILD COPY image/modules.inc.php /var/www/html/opensips-cp/config/

# # RUN sed -i "s/root/www-data/g" /var/www/html/opensips-cp/config/tools/system/smonitor/opensips_stats_cron &&\
# #     cp /var/www/html/opensips-cp/config/tools/system/smonitor/opensips_stats_cron /etc/cron.d/

# # # EXPOSE 80

# # ENTRYPOINT ["/docker-entrypoint.sh"]


# # # OPENSIPS_CP_VERSION=