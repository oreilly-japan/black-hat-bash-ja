FROM wordpress:6.4

# メタデータ
LABEL name="p-web-02"
LABEL company="ACME Infinity Servers"

# 変数
ENV WORDPRESS_DB_HOST="c-db-02"
ENV WORDPRESS_DB_USER="wordpress"
ENV WORDPRESS_DB_PASSWORD="wordpress"
ENV WORDPRESS_DB_NAME="wordpress"

# 必要なパッケージのインストール
RUN apt-get update -y
RUN apt-get install -y \ 
                    net-tools \
                    socat \
                    iputils-ping \
                    iproute2 \ 
                    cron \
                    lshw \
                    at 

# 検証環境にファイルをコピー
ADD files/site /var/www/html

# 後処理
RUN chown www-data:www-data -R /var/www/html/
