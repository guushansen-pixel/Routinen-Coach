# Routinen-Coach

Offline-Android-App, die durch feste tägliche Bewegungs-Routinen führt
(zuerst The Happy Body, erweiterbar um weitere Systeme). Reine Web-App in
einer Datei, die per [apk-builder](../apk-builder) zur APK wird. Systeme,
Ablauf und Datenmodell stehen in [README.md](README.md), Versionen in
[CHANGELOG.md](CHANGELOG.md).

## Build & Test

Kein Bundler, kein Build-Step. Testserver `node tools/serve.mjs` (Port
8220), dann `http://localhost:8220/web/`. `?debug=1` führt den Selbsttest
aus (Konsole und Zeile auf der Startseite, auch per `rcTests()`). Er muss
komplett `OK` zeigen.

APK bauen über den Wrapper (ohne native Brücke, ohne Internet-Berechtigung;
Links öffnet das Template im Browser):

```powershell
cd "D:\claude code projects\routinen-coach"
.\build.ps1 -Release   # signiert -> dist\routinencoach-<v>.apk
```

## Konventionen

- Alles in `web/index.html`, kein Framework, kein Netzwerk.
- **Keine fremden Texte oder Videos einbauen.** Für Programme anderer
  Autoren nur das Gerüst (Zahl der Teile und Übungen, Stufen) plus Links;
  Anleitungen in der App sind entweder selbst geschrieben oder vom Nutzer
  eingetragen. Nichts über ein Programm behaupten, was nicht belegt ist:
  Unbekanntes bleibt ein leerer Platz (`todo`).
- Links nur über `safeUrl()` (nur https) ins HTML; alles Eingetippte durch
  `esc()`.
- Regeln (`parseList`, `mergeItem`, `sessionPlan`, `paceAt`, `streak`, …)
  sind rein und im Selbsttest; Zeitabläufe rechnen mit `Date.now()`.
- Mitgelieferte Systeme stehen in `SYSTEMS`; gespeichert werden nur die
  Änderungen des Nutzers (`db.edits`, `db.cfg`). Kennungen von Übungen
  nie ändern, sonst hängen gespeicherte Stufen und Links in der Luft.
- Kein `confirm()`/`alert()`: eigene Dialoge über `openModal`.

## Aktueller Stand

v1.0 (code 1, 2026-11-16): zwei Systeme (The Happy Body mit 18 benannten
Plätzen, Runden, Wiederholungen und Gewichtsanteilen; "Beweglich in 12
Minuten" als eigenes Programm), eigene Systeme, Ablauf mit Atem-Takt, Stufe
und Gewicht, Verlauf, Sicherung. In einer Cloud-Sitzung gebaut; am
2026-11-17 lokal als Release-APK gebaut, aufs Handy installiert und nach
GitHub gepusht (guushansen-pixel/Routinen-Coach). **Am Gerät noch nichts
getestet.** Selbsttest 17/17; ein Durchlauf im Browser per Roboter.

**Die Angaben zu The Happy Body sind großteils unbestätigt.** Belegt (über
Suchtreffer der offiziellen Seite) sind nur 1.1, 2.4, 3.5 samt Platz und
die Namen Fly Up und Rising Tower. Alles Weitere stammt aus der Datendatei
einer fremden Tracker-App (Tabelle im README). Daniel hat das Buch verliehen
und bekommt es in zwei bis drei Monaten zurück: dann Namen, Plätze,
`THB_PCT`, Runden und Wiederholungen abgleichen und den Hinweis `unsure`
sowie den Text in `note` anpassen. Keine Anleitungstexte aus Buch oder
Fremd-App übernehmen.

Die offizielle Seite sperrte beim Bau automatische Zugriffe; YouTube,
Vimeo und tim.blog waren in der Sitzung nicht freigegeben. Alle Links sind
ungeöffnete Suchtreffer.

Offen: ob Links im WebView wirklich im Browser bzw. der YouTube-App
aufgehen, ob der Atem-Takt passt (1,5 s je Schritt ist geschätzt), Icon
ansehen.
