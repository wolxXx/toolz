#!/bin/bash

alias dockerinfo="docker ps -qa | xargs -n 1 docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}} {{ .Name }}' | sed 's/ \// /' | sort && docker ps -a"
alias i="git status && git branch"
