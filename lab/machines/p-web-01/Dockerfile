FROM lab_base

# メタデータ
LABEL name="p-web-01"
LABEL company="ACME Infinity Servers"

# 変数
ENV FLASK_ENV=development

# 必要なパッケージのインストール
RUN apt-get update -y --fix-missing
RUN apt-get install software-properties-common -y
RUN add-apt-repository universe
RUN apt-get update -y
RUN apt-get install -y \
                    python3 \
                    python3-pip \
                    iptables \
                    gnupg \
                    python3-flask

# 検証環境にファイルをコピー
WORKDIR /app

COPY files/site/static static
COPY files/site/app.py .
COPY files/site/index.html .
COPY files/site/upload.html . 

# 後処理
RUN mkdir files 
RUN mkdir uploads
COPY files/acme-hyper-branding-5.csv files/acme-hyper-branding-5.csv

# PGP鍵の作成
RUN gpg --batch --quick-generate-key --passphrase '' arodriguez@acme-infinity-servers.com

ENTRYPOINT [ "python3", "-m" , "flask", "run", "--host=0.0.0.0", "--port=8081", "--debug"]