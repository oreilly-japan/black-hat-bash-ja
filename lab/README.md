# 注意事項
* この検証環境は [Kali Linux 2023.4](https://old.kali.org/kali-images/kali-2023.4/kali-linux-2023.4-installer-amd64.iso) でテストされました
* Burpsuiteが利用できない場合は、Kaliで `sudo apt-get install burpsuite -y` を実行してください
* macOSのアーキテクチャの非互換性により検証環境でRustScanが動作しない場合は、`brew install rustscan` でRustScanをインストールできます

# 検証環境の構成図
<p>
  <img src="https://github.com/dolevf/Black-Hat-Bash/blob/master/lab/lab-network-diagram.png?raw=true" width="600px" alt="BHB"/>
</p>

# 検証環境マシンのIPアドレス
| 名前          | 公開ネットワーク内IP | 架空の会社内ネットワークでのIP | FQDN
|--------------| ------- | ------- | ------- | 
| p-web-01     | 172.16.10.10  |  | p-web-01.acme-infinity-servers.com |
| p-ftp-01     | 172.16.10.11  | | p-ftp-01.acme-infinity-servers.com  |
| p-web-02     | 172.16.10.12  | 10.1.0.11 | p-web-02.acme-infinity-servers.com  |
| p-jumpbox-01 | 172.16.10.13 | 10.1.0.12 | p-jumpbox-01.acme-infinity-servers.com |
| c-backup-01  | | 10.1.0.13 | c-backup-01.acme-infinity-servers.com |
| c-redis-01   | | 10.1.0.14 | c-redis-01.acme-infinity-servers.com |
| c-db-01      | | 10.1.0.15 | c-db-01.acme-infinity-servers.com |
| c-db-02      | | 10.1.0.16 | c-db-02.acme-infinity-servers.com |


# 検証環境のインストール

**注意**: この検証環境の手順は、Kali Linuxでテストされています。

## Dockerのインストール

**dockerのaptソースを追加**

`printf '%s\n' "deb https://download.docker.com/linux/debian bullseye stable" | sudo tee /etc/apt/sources.list.d/docker-ce.list`

**次に、gpgキーをダウンロードしてインポート**

`curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/docker-ce-archive-keyring.gpg`

**aptリポジトリを更新**

`sudo apt update -y`

**DockerとDocker Composeをインストール**

`sudo apt install docker-ce docker-ce-cli containerd.io -y`

**Dockerサービスを起動**

`sudo service docker start`

## 検証環境の起動
このリポジトリのlabフォルダに移動して、以下を実行してください

`sudo make deploy`

## 検証環境のテスト
`sudo make test`

## 検証環境のシャットダウン
`sudo make teardown`

## 検証環境の再構築
`sudo make rebuild`

## 検証環境の削除
`sudo make clean`

