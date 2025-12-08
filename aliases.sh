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
           echo "error: directory '$TARGET_DIR' not found." >&2
           return 1
       fi

       (
           cd "$TARGET_DIR" || return
           find . -maxdepth 1 -mindepth 1 -printf "%f\n" |
           awk -F. '
           {
               REVERSE_KEY = ""
               for (i = NF - 1; i >= 1; i--) {
                   REVERSE_KEY = REVERSE_KEY $i (i > 1 ? "." : "")
               }
               print REVERSE_KEY, $0
           }
           ' |

           sort -k1,1 |

           awk '
           {
               split($2, parts, ".")
               NUM_COMP = length(parts)

               if (NUM_COMP < 2) {
                   CURRENT_GROUP = $2
               } else {
                   CURRENT_GROUP = parts[NUM_COMP-1] "." parts[NUM_COMP]
               }

               # -----------------------------------------------------
               if (CURRENT_GROUP != PREVIOUS_GROUP && PREVIOUS_GROUP != "") {
                   print ""
               }

               if (CURRENT_GROUP != PREVIOUS_GROUP) {
                   print "## " CURRENT_GROUP " ##"
                   print "-------------------"
               }

               HOST_NAME = ""
               if (NUM_COMP > 2) {
                   for (i=1; i <= NUM_COMP - 2; i++) {
                       HOST_NAME = HOST_NAME parts[i] (i < NUM_COMP - 2 ? "." : "")
                   }
               } else if (NUM_COMP == 2) {
                   HOST_NAME = "(Basis-Domain)"
               } else {
                   HOST_NAME = parts[1]
               }

               print "├── " HOST_NAME

               PREVIOUS_GROUP = CURRENT_GROUP
           }
           '
       )
}

alias dockerinfo="fun_dockerinfo"
alias sort_domains="fun_sort_domains"
alias i="git remote -v show && git config user.email && git config user.name && git remote update && git branch && git status"