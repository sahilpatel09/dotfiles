alias di="docker inspect \$(docker ps --format='table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.RunningFor}}\t{{.Status}}' | sed 1d | sort -k2 | fzf | awk '{ print \$1 }')"
alias dl="docker logs --tail 300 -f \$(docker ps --format='table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.RunningFor}}\t{{.Status}}' | sed 1d | sort -k2 | fzf | awk '{ print \$1 }')"
alias de="docker exec -it \$(docker ps --format='table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.RunningFor}}\t{{.Status}}' | sed 1d | sort -k2 | fzf | awk '{ print \$1 }') sh"

alias dps="docker stack ps \$(docker stack ls --format '{{.Name}}' | fzf)"

alias dsl="docker service logs --tail 300 -f \$(docker service ls --format '{{.ID}}\t{{.Name}}' | sed 1d | fzf | awk '{ print \$1 }')"

alias dstats="docker ps --format='table {{.ID}}\t{{.Names}}\t{{.Image}}' | sed 1d | fzf -m | awk '{ print \$1 }' | xargs -r docker stats"

alias ssf="ssh \$(awk '/^Host / && !/\\*/ {print \$2}' ~/.ssh/config | fzf)"

alias gist="gist.fzf"
alias pr="pr.fzf"

alias ssh-rsa='ssh -o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedKeyTypes=+ssh-rsa'

alias ll='ls -alF'
alias cal='cd /home/spatel/Desktop/dev/calibration'
alias al='cd /home/spatel/Desktop/dev/alarm-log'
alias la='ls -A'
alias l='ls -CF'
alias dpf='docker ps | grep'

alias ..='cd ..'                    # Go up one directory
alias ...='cd ../..'                # Go up two directories
alias ....='cd ../../..'            # Go up three directories

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias inPg='docker exec -it $(docker ps -q -f name=ccse_pgmaster) psql -U postgres -d ccse_prod'

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias brave='brave-browser --disk-cache-dir=/mnt/ramdisk/brave-cache'


function dstats() {
  docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.BlockIO}}"
}


dlf() {
    local container_id
    container_id=$(docker ps -q -f name="$1")

    # Check for multiple containers
    if [ "$(echo "$container_id" | wc -l)" -gt 1 ]; then
        echo "Error: Multiple containers match the name '$1'. Please provide a more specific name."
        return 1
    fi

    # Check for no containers
    if [ -z "$container_id" ]; then
        echo "Error: No containers match the name '$1'."
        return 1
    fi

    # Check for tail argument
    if [ -n "$2" ]; then
        docker logs --tail "$2" -f "$container_id"
    else
        docker logs -f "$container_id"
    fi
}



export LS_COLORS="di=1;33:ln=1;36:so=1;35:pi=1;34:ex=1;32:bd=1;33:cd=1;33:su=1;31:sg=1;31:tw=1;34:ow=1;34"


parse_git_branch() {
  git branch 2>/dev/null | sed -n '/\* /s///p' | awk '{print "\033[38;5;214m("$1")"}'
}

PS1='\[\e[38;5;208m\]λ \[\e[38;5;214m\]\W \[\e[0m\]$(parse_git_branch) \[\e[38;5;214m\]➜ \[\e[0m\]'


# Override cd to log visited directories
cd() {
  # Call the builtin cd and capture the result
  builtin cd "$@" || return

  # Define log file
  CYCLE_DIR="$HOME/.cycle"
  HISTORY_FILE="$CYCLE_DIR/history"

  # Ensure directory exists
  mkdir -p "$CYCLE_DIR"
  touch "$HISTORY_FILE"

  # Get absolute path after cd and log it
  pwd >> "$HISTORY_FILE"
}


#eval "$(starship init bash)
