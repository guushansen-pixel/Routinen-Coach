# Routinen-Coach

Offline-Android-App, die durch feste tägliche Bewegungs-Routinen führt:
Übung für Übung, mit Atem-Takt, Stufe und Gewicht je Übung, Video-Link und
Verlauf. Ein Programm ist ein "System" (Datenpaket); eigene Systeme lassen
sich in der App anlegen.

Noch keine APK gebaut (v1.0 entstand in einer Cloud-Sitzung).

## Systeme

| System | Inhalt in der App |
|---|---|
| The Happy Body (Aniela und Jerzy Gregorek) | 3 Sequenzen zu je 6 Übungen mit Namen, 5 Stufen, Atemfolge in 6 Schritten (Einatmen, Anspannen, Heben, Dehnen, Zurück, Ausatmen), 3 Runden je Sequenz, Wiederholungen und Gewichtsanteile je Platz, Links zur offiziellen Seite, zu Vimeo und YouTube. **Keine Anleitungstexte, keine Videos** |
| Beweglich in 12 Minuten | eigenes Programm dieser App: 12 verbreitete Beweglichkeits-Übungen in 2 Teilen, mit eigenen Anleitungstexten |
| eigene Systeme | Name plus Liste, eine Übung je Zeile `Name \| Hinweis \| Link`, `#` beginnt einen Teil |

### Woher die Angaben zu The Happy Body stammen

Die Anleitungstexte und Videos gehören den Autoren und sind nicht in der
App. Zu jeder Übung lässt sich ein eigener Hinweis und ein Link speichern;
Links öffnen sich außerhalb der App.

| Angabe | Quelle | Stand |
|---|---|---|
| 18 Übungen, 3 Sequenzen zu je 6, 5 Stufen, Atemfolge | offizielle Seite (Suchtreffer), Tim-Ferriss-Folge 228, The Almanac 2009 | belegt |
| 1.1 Standing Tall, 2.4 Rocking Trunk, 3.5 Power Tower | offizielle Seite und YouTube-Titel (Suchtreffer) | belegt |
| Namen Fly Up und Rising Tower | offizielle Seite (Suchtreffer) | Name belegt, Platz nicht |
| die übrigen 13 Namen, alle weiteren Plätze | Datendatei der freien Tracker-App github.com/zannahpierce-pico/happy-body, die sich auf das Buch beruft | **eine Quelle, nicht am Buch geprüft** |
| 3 Runden je Sequenz, 3 oder 6 Wiederholungen, Übungen 2 und 3 immer 6 ohne Gewicht, Gewichtsanteile (`THB_PCT`) | dieselbe Tracker-App | **eine Quelle, nicht am Buch geprüft** |
| Sekunden je Atemschritt (1,5), Entspannung 5 min | Startwerte dieser App | geschätzt |

Die drei unabhängig belegten Plätze stimmen mit der Drittquelle überein,
das macht sie glaubwürdig, mehr nicht. Die offizielle Seite sperrte beim
Bau automatische Zugriffe; alle Links (YouTube, Vimeo) stammen aus
Suchergebnissen und wurden nicht geöffnet. Per-Übungs-Videos gibt es
öffentlich nur für 1.1 und 3.5; das vollständige Set verkaufen die Autoren.

Wer das Buch hat, gleicht ab und ändert Namen einzeln oder über "Namen
durch eine eigene Liste ersetzen"; Runden und Wiederholungen stehen unter
"Ablauf".

## Ablauf einer Einheit

Ganze Routine oder ein einzelner Teil. Je Übung: Name, Stufe und Gewicht
(±), eigener Hinweis, Knopf zum Video (gespeicherter Link, sonst eine
YouTube-Suche nach dem Namen), Atem-Takt (Kreis wächst und schrumpft über
die Schritte, Ton je Schritt). Jeder Teil läuft so viele Runden
hintereinander, wie unter "Ablauf" eingestellt. "Weiter" zählt die Übung als gemacht; der
Takt ist freiwillig. Am Ende optional ein Entspannungs-Timer. Gespeichert
werden Datum, System, Zahl der Übungen und Dauer; die Startseite zeigt die
Tage in Folge und die letzten vier Wochen.

## Datenmodell (localStorage)

`routinen.data.v1`: `{schema, cur, sound, edits: {system: {übung: {name, how,
link, level, kg}}}, cfg: {system: {rounds, reps, stepSec, rest, relax}}, own:
[System], log: [{d, sys, n, of, min}]}`

Mitgelieferte Systeme stehen im Code (`SYSTEMS`); gespeichert werden nur
die eigenen Änderungen daran. Sicherung als Text über "Daten sichern".

## Ein weiteres System fest einbauen

Eintrag in `SYSTEMS` ergänzen: `id`, `name`, `by`, `about`, `note`,
`links`, `steps` (Atemfolge je Wiederholung), `def` (Vorgaben), `levels`
(0 = keine Stufen), `kg`, `parts: [{name, items: [{id, name, how, link}]}]`.
Der Selbsttest prüft eindeutige Kennungen und https-Links. Nur eigene
Texte einbauen; für fremde Programme bleibt es bei Gerüst plus Link.
