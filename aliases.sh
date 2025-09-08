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

alias dockerinfo="fun_dockerinfo"
alias i="git remote -v show && git config user.email && git config user.name && git remote update && git branch && git status"