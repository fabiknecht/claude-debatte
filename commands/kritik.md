---
description: Eine Runde fremde Kritik (Codex) an einem Artefakt, dann eigenes Urteil
argument-hint: <Artefakt> gegen <Spezifikation> — <Prüffragen>
---

Hole eine Kritik ein zu: **$ARGUMENTS**

Beteiligt sind zwei Stimmen: du selbst und die Codex CLI (`frage-codex`,
Standardmodell `gpt-6-astra`). Der Wrapper darf **nur lesen**. Du bist der
Einzige, der Dateien anfasst — und in diesem Befehl nur die Ablage der
Kritik selbst, nie das Artefakt. Was aus der Kritik folgt, entscheidet
Fabian am Wartepunkt.

Der Unterschied zu `/debatte`: **eine Runde, kein Kreuzverhör.** Eine
Debatte lohnt sich bei einer offenen Frage; eine Kritik prüft ein Artefakt
gegen eine geschriebene Spezifikation. Der Wert liegt in der unabhängigen
Lesung, nicht im Streit.

---

## Vorbereitung

1. Ablage im Projekt, nicht im Scratchpad — die Kritik gehört in die
   Bauakte und wird in Station 12 (Ernte) gelesen:
   `projects/<n>/pruef/kritik-<artefakt>/` (z. B. `kritik-storyboard/`).
   Liegt das Artefakt außerhalb eines Projekts, dann `pruef/kritik-<artefakt>/`
   neben dem Artefakt.
2. **Aus der Repo-Wurzel aufrufen** (`~/Projekte/Personal Brand`), damit
   `CATALOG.md` und `Video Pipeline/…` beide im Lesebereich des Wrappers
   liegen. Pfade im Briefing relativ zur Wurzel.
3. Lies die Dateien selbst, aber gib Codex nur **Pfade**, keine Inhalte.
4. Feststellen, ob Codex mitspielt:

   ```bash
   command -v frage-codex >/dev/null && codex login status
   ```

   Fällt Codex aus, ist das ein Befund: eine Zeile in `urteil.md`, und die
   eigene Lesung steht allein. Nicht abbrechen.

---

## Das Briefing

Schreibe `briefing.md` mit:

- der Frage, wörtlich
- den Pfaden zum Artefakt und zur Spezifikation (relativ zur Wurzel)
- den Prüffragen — je Frage die Stelle in der Spezifikation, gegen die geprüft wird
- der Auflage für die Antwort:

> Antworte als Tabelle `| Zeile/Fläche | Befund | Belegstelle (Datei, Abschnitt) | Schwere |`
> mit Schwere **blockiert** (verstößt gegen eine Regel), **sollte** (Regel
> eingehalten, aber schwächer als das Muster) oder **kann** (Geschmack).
> Danach genau ein Satz: *die eine Änderung, die am meisten bringt.*
> Keine Zusammenfassung, kein Lob, kein Umschreiben des Artefakts. Findest du
> keinen Befund, sage das in einem Satz und nenne die Stelle, an der du am
> längsten gezögert hast.

### Die fünf festen Prüffragen für ein Storyboard

Das ist der Standardfall (`WORKFLOW.md`, Station 4, *Die Kritik vor
Wartepunkt 2*). Für andere Artefakte formulierst du die Fragen aus der
zuständigen Spezifikation, nach demselben Muster: Frage + Belegstelle.

| # | Frage | Belegstelle |
|---|---|---|
| 1 | Nennt die **Prüffrage-Spalte** je Fläche die *gesprochene* Behauptung, die die Fläche belegt — oder nennt sie eine andere Fläche („wie oben", „Fortsetzung")? | `brand/DESIGN.md`, *Die Fläche belegt, sie wiederholt nicht* |
| 2 | **Register und Zustand:** Zeile 1 ist B hell (Hook im Split, Panel zeigt ab Frame 0 etwas); jede B-Zeile hell; jede B-Zeile trägt eine Fläche; Registerwechsel nur an Kapitelgrenzen | `brand/DESIGN.md`, *Die drei Bildzustände*, *Der Hook liegt im Split*; `WORKFLOW.md` Station 4, *Register und Zustand werden zusammen festgelegt* |
| 3 | **Lückenlosigkeit:** endet jedes Bildfenster auf dem Start des nächsten; ist jede Lücke als A-Zustand in der Tabelle? | `brand/DESIGN.md`, *Zwischen zwei Flächen gibt es keine Lücke* |
| 4 | **Bekanntes Objekt:** gibt es zu einer erfundenen Grafik ein Objekt, das der Zuschauer kennt (Terminal, Kommentarfeld, Ads-Manager-Tabelle), oder ein Flächen-Muster in `CATALOG.md`, das dasselbe schon sagt? | `brand/DESIGN.md`, *Bekannte Objekte statt erfundener Grafik*; `CATALOG.md`, *Flächen-Muster* |
| 5 | **Beleg statt Erfindung:** zeigt eine Fläche eine Zahl oder ein Ergebnis, das nicht in `reelplan/skript-final.json` steht? Zeigt das Panel im Hook ab Frame 0 etwas? Wird der CTA vorgeführt, nicht behauptet? | `brand/DESIGN.md`, *Rhythmus*, *Der CTA wird vorgeführt, nicht behauptet* |

Pfade, die ins Storyboard-Briefing gehören: `STORYBOARD.md`,
`reelplan/skript-final.json`, `reelplan/frame.timed.md`, `brand/DESIGN.md`,
`CATALOG.md` (Wurzel) und als Muster eines abgenommenen Storyboards
`Video Pipeline/projects/002-funnel-qualifizierung/STORYBOARD-v2.md`.

---

## Ablauf

1. **Eigene Lesung zuerst.** Schreibe `claude.md` — dieselbe Tabelle,
   dieselben Prüffragen — **bevor** du Codex startest oder seine Antwort
   liest. Wer zuerst liest, stimmt zu, statt zu prüfen.
2. Codex starten, Antwort nach `codex.md`:

   ```bash
   CODEX_MODEL="${CODEX_MODEL:-gpt-6-astra}" frage-codex "$(cat projects/<n>/pruef/kritik-<artefakt>/briefing.md)" \
     > projects/<n>/pruef/kritik-<artefakt>/codex.md
   ```

   Zeitkappe 5 Minuten (`CODEX_TIMEOUT`, Standard 300 s, Exit 124). Läuft er
   hinein, ist das ein Befund — nicht die Kappe lockern.
3. **Urteil** nach `urteil.md`, drei Blöcke:

   | Block | Inhalt |
   |---|---|
   | **Übernommen** | je Befund: Stimme (Codex / Claude / beide), die Änderung am Artefakt, Belegstelle |
   | **Abgelehnt** | je Befund: Stimme, warum nicht, Belegstelle, die die Ablehnung trägt |
   | **Nicht entscheidbar → Fabian** | Befunde, die eine Geschmacks- oder Inhaltsentscheidung sind; als Frage formuliert |

   Nenne die Stimmen beim Namen. Ein Befund, den nur Codex hatte, ist genau
   die Information, für die der Aufwand betrieben wurde.
4. Die Änderungen aus *Übernommen* am Artefakt vornehmen — **das ist ein
   eigener Schritt nach diesem Befehl**, nicht Teil davon. Für ein Storyboard
   steht das Ergebnis danach im Block *Kritik vor Wartepunkt 2* (drei bis
   acht Zeilen: was sich geändert hat, was abgelehnt wurde und warum, was
   Fabian entscheiden muss).

---

## Regeln

- **Nur die Kritik-Ablage wird geschrieben.** Artefakt, STATUS.md, OFFEN.md
  bleiben in diesem Befehl unberührt.
- **Kein `--dangerously-skip-permissions`, kein `--sandbox workspace-write`.**
  Eine Leseschranke ist ein Befund.
- **Antworten nicht glätten.** Ein falscher Befund von Codex kommt als Zitat
  nach *Abgelehnt* und wird dort widerlegt — nicht stillschweigend gestrichen.
- **„Kein Befund" ist ein Ergebnis.** Es wird mit der Stelle notiert, an der
  die Stimme am längsten gezögert hat.
- Modell umstellen über `CODEX_MODEL`; `gpt-6-astra` braucht Codex ≥ 0.153
  (`codex update`).
