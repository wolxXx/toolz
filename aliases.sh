#!/bin/bash

alias dockerinfo="docker ps -qa | xargs -n 1 docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}} {{ .Name }}' | sed 's/ \// /' | sort && docker ps -a"
alias i="git remote -v show && git config user.email && git config user.name && git remote update && git branch && git status"
