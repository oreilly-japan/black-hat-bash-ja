#!/usr/bin/env bash
set -euo pipefail

# インストールする Python のバージョン
PYVER="3.11.9"

# Python 3.11 のインストール先（/opt 以下に置くことでシステム python を汚さない）
PREFIX="/opt/python3.11"

# pwncat 用の仮想環境パス
VENV_PATH="$HOME/.venv/pwncat-py311"

# Python のソースコードを置くディレクトリ
SRC_DIR="/usr/src"

# ------------------------------------------------------------
#  必要パッケージのインストール（Python ビルドに必要なもの）
# ------------------------------------------------------------
sudo apt update
sudo apt install -y \
  build-essential \
  libssl-dev \
  zlib1g-dev \
  libncurses5-dev \
  libncursesw5-dev \
  libreadline-dev \
  libsqlite3-dev \
  libgdbm-dev \
  libdb5.3-dev \
  libbz2-dev \
  libexpat1-dev \
  liblzma-dev \
  libffi-dev \
  uuid-dev \
  libnss3-dev \
  tk-dev \
  wget

# ------------------------------------------------------------
#  Python 3.11 のソースコードを取得
# ------------------------------------------------------------
cd "$SRC_DIR"

if [ ! -d "Python-$PYVER" ]; then
  sudo wget "https://www.python.org/ftp/python/$PYVER/Python-$PYVER.tgz"
  sudo tar xzf "Python-$PYVER.tgz"
fi

cd "Python-$PYVER"

# 過去のビルドファイルがあれば削除
sudo make distclean || true

# ------------------------------------------------------------
#  Python 3.11 を OpenSSL 有効で configure
#  （ssl モジュールが無いエラーを防ぐ）
# ------------------------------------------------------------
sudo ./configure \
  --enable-optimizations \
  --with-ensurepip=install \
  --with-openssl=/usr \
  --prefix="$PREFIX"

# Python 3.11 をビルド（CPUコア数を利用）
sudo make -j"$(nproc)"

# "altinstall" により python3 の既存バージョンを上書きしない
sudo make altinstall

# ------------------------------------------------------------
#  ssl モジュールが正しくビルドされているか確認
# ------------------------------------------------------------
"$PREFIX/bin/python3.11" - << 'EOF'
import ssl
print("SSL OK:", ssl.OPENSSL_VERSION)
EOF

# ------------------------------------------------------------
#  古い仮想環境があれば削除して新しいものを作成
# ------------------------------------------------------------
rm -rf "$VENV_PATH"

# Python 3.11 で venv を作成
"$PREFIX/bin/python3.11" -m venv "$VENV_PATH"

# 仮想環境を有効化
# shellcheck disable=SC1090
source "$VENV_PATH/bin/activate"

# pip を最新化
pip install --upgrade pip

# ------------------------------------------------------------
#  pwncat-cs のインストール
# ------------------------------------------------------------
pip install pwncat-cs

# ------------------------------------------------------------
#  pwncat 起動時に発生する ZODB/ZEO の依存エラー対策
#  （zope.interface / zodburi / ZEO / ZODB の再インストール）
# ------------------------------------------------------------
pip install --force-reinstall --no-deps \
  zope.interface \
  ZEO \
  ZODB \
  zodburi

# 仮想環境を終了
deactivate || true
