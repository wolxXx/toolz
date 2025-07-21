#!/bin/bash

SHOW_HELP=false

# Array to store function queue
declare -a FUNCTION_QUEUE=()

# Execute queued functions with error handling
function execute_queue() {
    for func in "${FUNCTION_QUEUE[@]}"; do
        if declare -F "$func" > /dev/null; then
            $func
        else
            echo "Error: Function '$func' not found"
            FUNCTION_QUEUE=()
            SHOW_HELP=true
            break
        fi
    done
}

# Lists all Docker networks and their connected containers with IP addresses
# Uses docker network ls to get network names and docker network inspect for details
function show_networks() {
    echo "Docker networks:"
    for network in $(docker network ls --format "{{.Name}}" | sort); do
        echo -e "\nNetwork: $network"
        docker network inspect "$network" --format '{{range .Containers}}  - {{.Name}} ({{.IPv4Address}})
{{end}}'
    done
}

# Displays a formatted table of all Docker containers with their details
# Shows container names, images, status, ports, creation time and networks
function show_running() {
    echo "Running containers:"
    docker ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}\t{{.CreatedAt}}\t{{.Networks}}" | tail -n +2 | sort
}

# Displays basic Docker container information including:
# - IP addresses and container names (sorted by IP)
# - Full container listing with all details
# Uses docker inspect to get network info and docker ps for container status
function info() {
    echo "Base container information:"
    docker ps -qa | xargs -n 1 docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}} {{ .Name }}' | sed 's/ \// /' | sort && docker ps -a
}

# Parse command line arguments
# --networks: Show Docker networks and their containers
# --running: Show running Docker containers
# Invalid arguments will show help message
while [[ $# -gt 0 ]]; do
    case $1 in
        --networks)
            FUNCTION_QUEUE+=("show_networks")
            shift
            ;;
        --info)
            FUNCTION_QUEUE+=("info")
            shift
            ;;
        --running)
            FUNCTION_QUEUE+=("show_running")
            shift
            ;;
        *)
            FUNCTION_QUEUE=()
            SHOW_HELP=true
            echo "Unknown parameter: $1"
            break 
            ;;
    esac
done


# Execute queue or show help
if [ ${#FUNCTION_QUEUE[@]} -gt 0 ]; then
    execute_queue
fi

if [ "$SHOW_HELP" = true ] || [ ${#FUNCTION_QUEUE[@]} -eq 0 ]; then
    echo "Usage: $0 [--networks] [--running]"
    echo ""
    echo "Options:"
    echo "  --info      Base information about your containers"
    echo "  --networks  List all Docker networks and their connected containers with IP addresses"
    echo "  --running   Display a table of all Docker containers with their details (name, image, status, etc)"
    echo ""
    exit 1
fi

exit 0