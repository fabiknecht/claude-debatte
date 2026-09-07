---
description: Drei Modelle streiten in drei Runden ueber eine Frage am Bestand
argument-hint: <Frage zum Bestand>
---

Fahre eine Debatte ueber: **$ARGUMENTS**

Beteiligt sind drei Modelle: du selbst, die Codex CLI (`frage-codex`) und die
Antigravity CLI (`frage-agy`). Beide Wrapper duerfen **nur lesen**. Du bist
der Einzige, der Dateien anfassen darf — und in diesem Befehl fasst auch du
nichts an. Eine Debatte ist ein Befund, keine Aenderung.

Der Nutzen ist Widerspruch, nicht Rechenleistung. Halte die drei Stimmen
auseinander, statt sie zu einer Meinung zu verruehren.

---

## Vorbereitung

1. Lege einen Ordner im Scratchpad an: `debatte-<kurzname>/`.
2. Finde die Dateien, um die es geht. **Lies sie selbst**, aber gib den
   beiden anderen nur **Pfade**, keine Inhalte — sie lesen mit eigenen Augen.
   Kommen sie zu einem anderen Befund als du, ist genau das das Ergebnis.
3. Stelle fest, wer mitspielt:

   ```bash
   command -v frage-codex >/dev/null && codex login status
   command -v frage-agy   >/dev/null
   ```

   Faellt einer aus, laeuft die Debatte mit zweien weiter. Sage in **einer
   Zeile**, wer fehlt und warum — und brich nicht ab.

---

## Runde 1 — Eroeffnung, blind

Schreibe ein Briefing nach `debatte-<kurzname>/briefing.md`:

- die Frage, woertlich
- die relevanten Pfade, relativ zum Arbeitsordner
- die Auflage: **eine These in einem Satz, dann hoechstens fuenf Saetze
  Begruendung, jede mit einer Belegstelle aus dem Bestand.** Keine Uebersicht,
  keine Abwaegung, keine Handlungsempfehlung.

Dann, in **einem** Tool-Block, damit sie parallel laufen:

```bash
frage-codex "$(cat debatte-<kurzname>/briefing.md)"
frage-agy   "$(cat debatte-<kurzname>/briefing.md)"
```

**Bilde deine eigene These, bevor du die beiden Antworten liest.** Schreibe
sie zuerst nach `debatte-<kurzname>/claude-r1.md`. Das ist der Kern des
Verfahrens: wer zuerst die anderen liest, argumentiert nicht mehr
unabhaengig, sondern stimmt zu. Dann hast du drei Modelle und trotzdem eine
Meinung.

Lege alle drei Eroeffnungen als `codex-r1.md`, `agy-r1.md`, `claude-r1.md` ab.

---

## Runde 2 — Kreuzverhoer

Jeder bekommt die beiden **anderen** Thesen im Wortlaut und genau einen
Auftrag:

> Greife den schwaechsten Punkt an. Nenne die Belegstelle im Bestand, die
> ihn widerlegt. Keine Hoeflichkeit, keine Zusammenfassung, kein Lob. Findest
> du keinen Angriffspunkt, sage das ausdruecklich in einem Satz und begruende,
> warum die Position haelt.

Auch hier beide Wrapper in **einem** Tool-Block. Du selbst greifst ebenfalls
an — die beiden anderen, nicht dich selbst.

Ablage: `codex-r2.md`, `agy-r2.md`, `claude-r2.md`.

Ein „findet keinen Angriffspunkt" ist ein Ergebnis, kein Ausweichen. Notiere
es als solches.

---

## Runde 3 — Urteil

Du schreibst die Auswertung, niemand sonst. Nach
`debatte-<kurzname>/urteil.md`, und **in voller Laenge in den Chat** — nicht
nur als Dateiverweis.

Vier Bloecke, in dieser Reihenfolge:

| Block | Inhalt |
|---|---|
| **Einigkeit** | Was alle drei tragen, nachdem sie sich angegriffen haben. Das ist der belastbare Teil |
| **Echter Dissens** | Wo sie sich nach Runde 2 immer noch widersprechen. Je Seite die Belegstelle, nicht die Behauptung |
| **Scheindissens** | Wo sie dasselbe meinen und verschieden nennen. Meist der groesste Posten |
| **Entscheidung** | Deine Empfehlung mit Begruendung — und ausdruecklich, was Fabian entscheiden muss und nicht du |

Nenne die Stimmen beim Namen (Codex, agy, Claude), wenn sie auseinandergehen.
„Die Modelle meinen" verschenkt genau die Information, fuer die der Aufwand
betrieben wurde.

---

## Regeln

- **Nichts wird geschrieben ausser im Scratchpad.** Kein Repo-Bestand wird
  geaendert, auch nicht „nur die STATUS.md". Was aus der Debatte folgt,
  entscheidet Fabian danach in einem eigenen Auftrag.
- **Kein `--dangerously-skip-permissions`, kein `--sandbox workspace-write`.**
  Wenn ein Wrapper an einer Leseschranke scheitert, ist das ein Befund, kein
  Grund, die Schranke zu oeffnen.
- **Antworten nicht glaetten.** Wenn Codex etwas Falsches behauptet, kommt es
  als Zitat in die Auswertung und wird dort widerlegt — nicht stillschweigend
  korrigiert.
- **Laeuft ein Wrapper laenger als etwa fuenf Minuten**, brich ab und melde
  es. `agy` hat ein eingebautes Zeitlimit von 5 Minuten, `codex` nicht.
- Modelle umstellen bei Bedarf ueber `CODEX_MODEL`, `AGY_MODEL` (Standard
  `gemini-3.1-pro-high`), `AGY_EFFORT`.
