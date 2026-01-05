import subprocess

# 基本的なPythonのWebシェルチェッカー
result = subprocess.check_output('id', shell=True)

print(result.decode('utf-8'))
