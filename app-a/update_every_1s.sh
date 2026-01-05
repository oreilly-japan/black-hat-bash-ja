#!/usr/bin/env bash
set -u

# 対象ファイルを必要に応じて並べる
FILES=("uploads/file1.txt" "uploads/file2.txt" "uploads/file3.txt")

# Clue候補（必要なら好きに増減可能）
CLUES_A=("ALPHA" "BRAVO" "CHARLIE" "DELTA")
CLUES_B=("get" "put" "option" "head")
CLUES_C=("X" "Y" "Z" "W")

update_one() {
  file="$1"
  [ -f "$file" ] || : > "$file"

  # 先頭行のREVを取得（無ければ0）
  rev="$(sed -n '1s/.*REV \([0-9][0-9]*\).*/\1/p' "$file")"
  [ -n "$rev" ] || rev=0
  newrev=$((rev+1))

  ts="$(date '+%Y-%m-%d %H:%M:%S')"

  # ヘッダーがあれば書き換え、無ければ追加
  if sed -n '1{/^\[.*REV [0-9][0-9]*.*last seen /p}' "$file" >/dev/null; then
    sed -i -E "1s/REV [0-9]+/REV $newrev/;1s/last seen[^]]*/last seen $ts/" "$file"
  else
    sed -i "1i [Auto – REV $newrev | last seen $ts]" "$file"
  fi

  # ファイルごとに異なるClueをセット
  case "$(basename "$file")" in
    file1.txt)
      clue="${CLUES_C[$((newrev % ${#CLUES_C[@]}))]}"
      sed -i -E "/^Clue \[C\]:/cClue [C]: $clue" "$file" || echo "Clue [C]: $clue" >> "$file"
      ;;
    file2.txt)
      clue="${CLUES_B[$((newrev % ${#CLUES_B[@]}))]}"
      sed -i -E "/^Clue \[B\]:/cClue [B]: $clue" "$file" || echo "Clue [B]: $clue" >> "$file"
      ;;
    file3.txt)
      clue="${CLUES_A[$((newrev % ${#CLUES_A[@]}))]}"
      sed -i -E "/^Clue \[A\]:/cClue [A]: $clue" "$file" || echo "Clue [A]: $clue" >> "$file"
      ;;
  esac

  # 必ずメッセージが入るように（重複は避ける）
  grep -q 'Please verify again.' "$file" || echo "Please verify again." >> "$file"
  grep -q 'Then return here.'   "$file" || echo "Then return here."   >> "$file"
}

# 1秒おきに更新
while :; do
  for f in "${FILES[@]}"; do update_one "$f"; done
  sleep 1
done