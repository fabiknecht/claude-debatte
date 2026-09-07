#!/bin/bash
# Legt Symlinks von ~/.claude auf die Dateien in diesem Ordner.
# Symlinks statt Kopien: ein `git pull` aktualisiert damit auch das,
# was Claude Code wirklich laedt. Aufruf: ./install.sh [--probe]
set -u
HIER="$(cd "$(dirname "$0")" && pwd)"
ZIEL="$HOME/.claude"
SICHERUNG="$ZIEL/_vor-claude-code-skills-$(date +%Y-%m-%d)"
PROBE=0; [[ "${1:-}" == "--probe" ]] && PROBE=1
POSTEN="commands/debatte.md commands/kritik.md bin/frage-codex bin/frage-agy"

for p in $POSTEN; do
  quelle="$HIER/$p"; ziel="$ZIEL/$p"
  [[ -e "$quelle" ]] || { echo "FEHLT im Repo: $p"; continue; }
  if [[ -L "$ziel" ]]; then
    if [[ "$(readlink "$ziel")" == "$quelle" ]]; then echo "ok        $p"; continue; fi
    echo "link neu  $p (zeigte auf $(readlink "$ziel"))"
    (( PROBE )) || rm "$ziel"
  elif [[ -e "$ziel" ]]; then
    echo "sichern   $p -> $SICHERUNG/$p"
    (( PROBE )) || { mkdir -p "$SICHERUNG/$(dirname "$p")"; mv "$ziel" "$SICHERUNG/$p"; }
  else
    echo "neu       $p"
  fi
  (( PROBE )) || { mkdir -p "$(dirname "$ziel")"; ln -s "$quelle" "$ziel"; }
done

chmod +x "$HIER/bin/frage-codex" "$HIER/bin/frage-agy" 2>/dev/null

# Der haeufigste stille Fehler: ohne diese Zeile findet /debatte die beiden
# anderen Stimmen nicht - und laeuft trotzdem, mit einer Stimme.
echo
case ":$PATH:" in
  *":$ZIEL/bin:"*) echo "PATH      ok, $ZIEL/bin ist drin" ;;
  *) echo "PATH      FEHLT. Diese Zeile in ~/.zshrc (oder ~/.bashrc), dann neue Shell:"
     echo '            export PATH="$HOME/.claude/bin:$PATH"' ;;
esac

if [[ ! -f "$HOME/.gemini/antigravity-cli/settings.json" ]]; then
  echo "agy       Leseschranke fehlt. Ohne sie darf das Modell schreiben:"
  echo "            cp $HIER/beispiele/antigravity-settings.json \\"
  echo "               ~/.gemini/antigravity-cli/settings.json"
fi

(( PROBE )) && echo "(Probe - nichts geaendert)"
exit 0
