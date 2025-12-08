#!/bin/bash

fun_dockerinfo() {
  k=1
  
  if [ "$1" = "--ip" ]; then
    k=4
  fi
  if [ "$1" = "--name" ]; then
    k=1
  fi
  if [ "$1" = "--status" ]; then
    k=2
  fi
  if [ "$1" = "--image" ]; then
    k=3
  fi
  if [ "$1" = "--network" ]; then
    k=5
  fi
  
   for cid in $(docker ps -aq); do
      docker inspect --format '{{.Name}} {{.State.Status}} {{.Config.Image}} {{range $k,$v := .NetworkSettings.Networks}}{{$v.IPAddress}} ({{$k}}){{end}}' "$cid"  | sed 's#^/##'
    done | awk '{ if ($3=="") $3="N/A"; print }' | column -t | sort -k$k
}

fun_sort_domains() {
   local TARGET_DIR="${1:-.}"

       if [ ! -d "$TARGET_DIR" ]; then
           echo "Fehler: Verzeichnis '$TARGET_DIR' nicht gefunden." >&2
           return 1
       fi

       (
           cd "$TARGET_DIR" || return

           # NEU: find wird verwendet, um alle Dateien und Verzeichnisse auf erster Ebene zu listen
           # -maxdepth 1 -mindepth 1: Listet nur Einträge im aktuellen Verzeichnis.
           # -printf "%f\n": Gibt nur den Dateinamen (ohne ./ oder /) aus.
           find . -maxdepth 1 -mindepth 1 -printf "%f\n" |

           # 1. AWK zum Erstellen des Reverse-Keys
           awk -F. '
           {
               # NF ist die Anzahl der Felder (Komponenten)
               REVERSE_KEY = ""
               for (i = NF - 1; i >= 1; i--) {
                   REVERSE_KEY = REVERSE_KEY $i (i > 1 ? "." : "")
               }
               print REVERSE_KEY, $0
           }
           ' |

           # 2. SORT: Sortiert primär nach dem Reverse-Key
           sort -k1,1 |

           # 3. AWK: Formatiert die Baumstruktur
           awk '
           {
               split($2, parts, ".")
               NUM_COMP = length(parts)

               # Gruppierung: SLD + TLD (die letzten beiden Komponenten)
               # Prüfen, ob der Name mindestens zwei Punkte hat, sonst wird der letzte als TLD angenommen
               if (NUM_COMP < 2) {
                   CURRENT_GROUP = $2 # Name selbst als Gruppe (z.B. "config")
               } else {
                   CURRENT_GROUP = parts[NUM_COMP-1] "." parts[NUM_COMP] # z.B. kwatsh.de
               }

               # -----------------------------------------------------
               # A. Trennung und Überschrift, wenn die Gruppe wechselt
               if (CURRENT_GROUP != PREVIOUS_GROUP && PREVIOUS_GROUP != "") {
                   print "" # Leerzeile
               }

               if (CURRENT_GROUP != PREVIOUS_GROUP) {
                   # Erstellt die Überschrift ## kwatsh.de ##
                   print "## " CURRENT_GROUP " ##"
                   print "-------------------"
               }

               # -----------------------------------------------------
               # B. Ausgabe des Hostnamens/Anwendungsnamens (die restlichen Komponenten)

               HOST_NAME = ""
               if (NUM_COMP > 2) {
                   # Der Hostname besteht aus den Komponenten 1 bis NUM_COMP - 2
                   for (i=1; i <= NUM_COMP - 2; i++) {
                       HOST_NAME = HOST_NAME parts[i] (i < NUM_COMP - 2 ? "." : "")
                   }
               } else if (NUM_COMP == 2) {
                   # Fall: nur SLD.TLD, der Hostname ist leer
                   HOST_NAME = "(Basis-Domain)"
               } else {
                   # Fall: Nur eine Komponente ("config"), Hostname ist der Name selbst
                   HOST_NAME = parts[1]
               }

               print "├── " HOST_NAME

               # Status speichern
               PREVIOUS_GROUP = CURRENT_GROUP
           }
           '
       )
}

alias dockerinfo="fun_dockerinfo"
alias sort_domains="fun_sort_domains"
alias i="git remote -v show && git config user.email && git config user.name && git remote update && git branch && git status"