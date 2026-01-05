FROM redis:5.0.6

# メタデータ
LABEL name="c-redis-01"
LABEL company="ACME Infinity Servers"

# 必要なパッケージのインストール
RUN echo "deb http://archive.debian.org/debian buster main" > /etc/apt/sources.list && \
    apt-get update -y --fix-missing
RUN apt-get install -y openssh-server

# 検証環境にファイルをコピー
COPY --chown=root:root files/redis.conf /etc/redis/redis.conf

# 後処理
RUN mkdir /root/.ssh/
RUN chmod 700 /root/.ssh

RUN touch /root/.ssh/authorized_keys
RUN chmod 644 /root/.ssh/authorized_keys

# エントリーポイント
ENTRYPOINT service ssh restart \
           && \
           redis-server /etc/redis/redis.conf