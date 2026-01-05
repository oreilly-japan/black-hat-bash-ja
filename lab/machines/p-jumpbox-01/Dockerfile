FROM lab_base

# メタデータ
LABEL name="p-jumpbox-01"
LABEL company="ACME Infinity Servers"

# 必要なパッケージのインストール
RUN apt-get update -y --fix-missing
RUN apt-get install -y openssh-server elinks chkrootkit

# backupユーザーのログインを有効化
RUN echo 'backup:backup' | chpasswd
RUN chsh -s /bin/bash backup

# SSHの設定
COPY files/sshd_config /etc/ssh/sshd_config
RUN chown backup:backup /var/backups

# elinksにSetUIDビットを設定
RUN chmod u+s /usr/bin/elinks

# backupユーザーにsudoアクセス権を付
COPY files/backup-user-sudo-config /etc/sudoers.d/backup-user-sudo-config

# jmartinezユーザーにsudoアクセス権を付
COPY files/jmartinez-user-sudo-config /etc/sudoers.d/jmartinez-user-sudo-config

# データとスクリプト用のディレクトリを作成
RUN mkdir scripts
RUN mkdir -p /data/backup
RUN chmod 757 /data

# スクリプトをコピー
COPY files/backup_data.sh /scripts/backup_data.sh
RUN chmod u+x /scripts/backup_data.sh

# cronを設定
RUN echo '*/5 * * * * root bash /scripts/backup_data.sh' >> /etc/crontab

# エントリーポイント
ENTRYPOINT service ssh restart \
    && \
    service cron restart \
    && \
    tail -f /dev/null

