FROM mariadb:10.6.4-focal

# メタデータ
LABEL name="c-db-02"
LABEL company="ACME Infinity Servers"

ENV MYSQL_ROOT_PASSWORD="root"
ENV MYSQL_DATABASE="wordpress"
ENV MYSQL_USER="wordpress"
ENV MYSQL_PASSWORD="wordpress"

# エントリーポイント
CMD ["--default-authentication-plugin=mysql_native_password"]