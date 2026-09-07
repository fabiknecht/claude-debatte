# claude-code-skills

Zwei Commands für Claude Code, die eine **fremde Stimme** dazuholen: die Codex
CLI von OpenAI und die Antigravity CLI von Google. Beide dürfen nur lesen.

| | |
|---|---|
| **`/debatte`** | Drei Modelle streiten in drei Runden über eine Frage am Bestand. Jedes antwortet **blind**, dann greifen sie sich gegenseitig an, am Ende steht ein Urteil in vier Blöcken |
| **`/kritik`** | Eine Runde fremde Kritik an einem Artefakt gegen eine geschriebene Spezifikation. Kein Kreuzverhör — der Wert liegt in der unabhängigen Lesung |

Der Nutzen ist **Widerspruch, nicht Rechenleistung.** Wer zuerst die anderen
liest, argumentiert nicht mehr unabhängig, sondern stimmt zu. Deshalb schreibt
jede Stimme ihre These, bevor sie die anderen sieht.

## Installieren

**1 · Codex CLI** (die zweite Stimme)

```
curl -fsSL https://chatgpt.com/codex/install.sh | sh
```

Danach einmal `codex` in einem Projektordner starten und **Sign in with
ChatGPT** wählen. Codex ist in *allen* ChatGPT-Plänen enthalten — „Free, Go,
Plus, Pro, Business, Edu, or Enterprise". Die Pläne unterscheiden sich im
Kontingent, nicht im Zugang.

**2 · Antigravity CLI** (die dritte Stimme)

```
curl -fsSL https://antigravity.google/cli/install.sh | bash
```

Landet unter `~/.local/bin/agy`. Ohne Google AI Pro oder Ultra gilt
„Meaningful quota, refreshed weekly".

**3 · Die Leseschranke für agy**

`frage-agy` trägt **selbst keine Sperre**. Es verlässt sich darauf, dass agy
im Headless-Betrieb alles ablehnt, was nicht ausdrücklich erlaubt ist —
`beispiele/antigravity-settings.json` *ist* die Sperre:

```
cp beispiele/antigravity-settings.json ~/.gemini/antigravity-cli/settings.json
```

Hast du dort schon eine Datei, füge `"deny": ["write_file(*)"]` und die
`allow`-Liste von Hand ein, statt sie zu überschreiben. Bei Codex macht das
der Wrapper selbst, über `--sandbox read-only`.

**4 · Commands und Wrapper verlinken**

```
./install.sh
```

Legt Symlinks von `~/.claude/…` hierher — `git pull` aktualisiert damit auch
die installierte Fassung. `./install.sh --probe` zeigt nur, was passieren
würde. Danach in einer neuen Shell:

```
command -v frage-codex >/dev/null && codex login status
command -v frage-agy   >/dev/null && echo "agy da"
```

⚠ **Fehlt `~/.claude/bin` auf dem Suchpfad, findet `/debatte` die beiden
anderen Stimmen nicht — und läuft trotzdem, mit einer Stimme.** Das ist der
häufigste stille Fehler. `install.sh` sagt dir, ob die Zeile fehlt.

## Was du wissen solltest, bevor du es benutzt

> **Mit zwei Stimmen funktioniert das Verfahren, mit einer nicht.** Fällt Codex
> oder agy aus — leeres Kontingent, nicht angemeldet, Suchpfad —, läuft
> `/debatte` weiter und sagt in **einer Zeile**, wer fehlt. Das ist Absicht.
> Aber wenn beide fehlen, bleibt Claude übrig, der sich selbst kritisiert. Das
> ist etwas anderes als eine Debatte, und es liest sich genauso.

**Beide Commands lesen Dateien, sie nehmen keine Anhänge.** Starte Claude Code
in dem Ordner, in dem dein Material liegt, und nenne die Pfade in der Frage.
Die anderen Stimmen bekommen nur die **Pfade**, nie deinen Text im Zitat — sie
lesen mit eigenen Augen. Kommen sie zu einem anderen Befund als Claude, ist
genau das das Ergebnis.

**Nichts wird geschrieben.** `/debatte` legt nur im Scratchpad ab, `/kritik`
nur seine eigene Kritik-Ablage. Das Artefakt bleibt unberührt. Was daraus
folgt, beauftragst du danach.

## Was `/debatte` im Marketing taugt

Vier Fälle, die sich gelohnt haben. Die Dateien werden **mitgegeben**, nicht
beschrieben:

| Fall | Aufruf |
|---|---|
| **Anzeigentext** | `/debatte Welcher der Anzeigentexte in ads/ verspricht etwas, das angebot.md nicht deckt? Nenne je Text die Stelle, nicht den Eindruck.` |
| **Landingpage** | `/debatte Wo bricht die Landingpage in landing/ das Versprechen aus ads/? Belegstelle auf beiden Seiten, sonst gilt es nicht.` |
| **Angebot** | `/debatte Kann ein Interessent nach angebot.md in einem Satz sagen, was er bekommt und was es kostet? Wo bleibt es vage?` |
| **Hook** | `/debatte Welcher Hook in hooks.md trägt die ersten zwei Sekunden und welcher behauptet nur? Beleg aus skript.md, keine Stilnoten.` |

Beim **Anzeigentext** entsteht der Streit am Angebot, nicht am Text — ohne
`angebot.md` bewerten die drei Sprache und werden sich einig, weil guter Stil
unstrittig ist. Beim **Angebot** ist Einigkeit die schlechte Nachricht: finden
alle drei dieselbe vage Stelle, ist sie wirklich vage.

## Stellschrauben

| Variable | Standard | wirkt auf |
|---|---|---|
| `CODEX_MODEL` | Codex-Standard | `codex exec --model` |
| `CODEX_TIMEOUT` | `300` Sekunden, danach Exit 124 | eigene Uhr im Wrapper — `agy` bringt fünf Minuten mit, `codex` nicht |
| `AGY_MODEL` | `gemini-3.1-pro-high` | `agy --model` |
| `AGY_EFFORT` | ungesetzt | `agy --effort` |

## Ein Hinweis zu `/kritik`

Das ist die Fassung, die bei mir läuft, samt der fünf Prüffragen für ein
Video-Storyboard und der Pfade meiner eigenen Pipeline. **Das Muster ist
Frage + Belegstelle** — für dein Artefakt formulierst du die Fragen aus deiner
eigenen Spezifikation. Ich veröffentliche lieber die laufende Fassung als eine
allgemeine, die niemand je ausgeführt hat.

## Herkunft

Beides eigener Bestand, geschrieben für meine Video-Pipeline. Nichts davon ist
eine Weiterveröffentlichung fremder Skills. Entstanden neben
[@fabiknecht](https://www.instagram.com/fabiknecht) — Video 004 zeigt
`/debatte` im Einsatz.

MIT, siehe `LICENSE`.
