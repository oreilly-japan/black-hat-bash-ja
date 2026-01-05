FROM ubuntu:24.04

# メタデータ
LABEL name="c-db-01"
LABEL company="ACME Infinity Servers"

# 変数
ENV DEBIAN_FRONTEND=noninteractive
ARG DB_ADMINER_FILE="/var/www/html/database.sql"
ARG DB_CUSTOMERS_FILE="/var/tmp/customers.sql"

# 必要なパッケージのインストール
RUN apt-get update -y --fix-missing
RUN apt-get install -y \
    cron \
    mariadb-server \
    apache2 \
    php \
    php-mysql \
    lshw \
    at 

# 後処理
COPY files/adminer-4.8.1.php /var/www/html/adminer.php
COPY files/database.sql $DB_ADMINER_FILE
COPY files/customers.sql $DB_CUSTOMERS_FILE

RUN mkdir /var/www/html/uploads 
RUN chmod 777 /var/www/html/uploads

RUN service mariadb restart \
    && \
    cat "$DB_ADMINER_FILE" | mysql -u root \
    && \
    cat "$DB_CUSTOMERS_FILE" | mysql -u root && rm "$DB_CUSTOMERS_FILE"
    
# エントリーポイント
ENTRYPOINT service mariadb restart \
    && \
    /usr/sbin/apache2ctl -D FOREGROUND