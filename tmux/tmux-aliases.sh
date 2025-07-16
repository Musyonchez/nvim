#!/bin/bash

# Tmux Session Aliases and Helper Functions
# Add this to your ~/.bashrc or ~/.zshrc: source ~/tmux-aliases.sh

# Source the templates
source ~/tmux-templates.sh

# Hijack tmux command to show custom help
tmux() {
    if [[ $# -eq 0 ]]; then
        echo "Tmux Automation Commands:"
        echo ""
        echo "Session Management:"
        echo "  tmux_ls                    - List all sessions"
        echo "  tmux_a <session-name>      - Attach to session"
        echo "  tmux_k <session-name>      - Kill session"
        echo "  tmux_ka                    - Kill all sessions"
        echo ""
        echo "Session Creation:"
        echo "  tmux_fs <name> <path>      - Full-stack session (main, client, server, claude, gemini, client-run, server-run, lazygit, terminal)"
        echo "  tmux_p <name> <path>       - Project session (main, main-run, claude, gemini, lazygit, terminal)"
        echo "  tmux_n <name>              - Normal tmux session (default name: 'normal')"
        echo ""
        echo "Examples:"
        echo "  tmux_fs events events      - Full-stack session in ~/Code/events"
        echo "  tmux_p nvim nvim           - Project session in ~/Code/nvim"
        echo "  tmux_n work                - Normal tmux session named 'work'"
        echo ""
        echo "Note: Paths are relative to ~/Code unless they start with /"
        echo ""
        echo "To use original tmux: /usr/bin/tmux"
    else
        # Pass all arguments to the real tmux
        /usr/bin/tmux "$@"
    fi
}

# Quick functions for common tmux operations
tmux_ls() { /usr/bin/tmux list-sessions; }
tmux_a() { /usr/bin/tmux attach-session -t "$1"; }
tmux_k() { /usr/bin/tmux kill-session -t "$1"; }
tmux_ka() { /usr/bin/tmux kill-server; }

# Quick session creation functions
tmux_fs() { fullstack_session "$1" "$2"; }
tmux_p() { project_session "$1" "$2"; }
tmux_n() { 
    local session_name="${1:-normal}"
    /usr/bin/tmux new-session -s "$session_name"
}

# Helper functions

# Quick attach to most recent session
tma() {
    local session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | head -n1)
    if [[ -n "$session" ]]; then
        tmux attach-session -t "$session"
    else
        echo "No active tmux sessions"
    fi
}

# Create session in specific directory (defaults to Code directory)
tmux-here() {
    local session_name="${1:-$(basename $(pwd))}"
    local current_path="$(pwd)"
    
    # If we're already in Code directory or subdirectory, use current path
    # Otherwise default to Code directory
    if [[ "$current_path" =~ ^$HOME/Code ]]; then
        ~/tmux-session.sh "$session_name" "$current_path"
    else
        ~/tmux-session.sh "$session_name" "$HOME/Code"
    fi
}

# Create session for a project (defaults to Code directory)
tmux-project() {
    if [[ $# -lt 2 ]]; then
        echo "Usage: tmux-project <session_name> <project_path>"
        echo "Note: project_path is relative to ~/Code unless it starts with /"
        return 1
    fi
    
    local session_name="$1"
    local project_path="$2"
    
    # If project path doesn't start with /, assume it's relative to ~/Code
    if [[ ! "$project_path" =~ ^/ ]]; then
        project_path="$HOME/Code/$project_path"
    fi
    
    if [[ ! -d "$project_path" ]]; then
        echo "Directory $project_path does not exist"
        return 1
    fi
    
    ~/tmux-session.sh "$session_name" "$project_path"
}

# Switch between sessions interactively
tmux-switch() {
    local session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --prompt="Select session: ")
    if [[ -n "$session" ]]; then
        tmux switch-client -t "$session" 2>/dev/null || tmux attach-session -t "$session"
    fi
}


# Create a monitoring session with logs
tmux-monitor() {
    local session_name="${1:-monitor}"
    local project_path="${2:-$(pwd)}"
    
    # If project path doesn't start with /, assume it's relative to ~/Code
    if [[ ! "$project_path" =~ ^/ ]]; then
        project_path="$HOME/Code/$project_path"
    fi
    
    if tmux has-session -t "$session_name" 2>/dev/null; then
        tmux attach-session -t "$session_name"
        return 0
    fi
    
    tmux new-session -d -s "$session_name" -c "$project_path" -n "system"
    tmux send-keys -t "$session_name:system" "htop" Enter
    
    tmux new-window -t "$session_name" -n "logs" -c "$project_path"
    tmux send-keys -t "$session_name:logs" "tail -f /var/log/syslog" Enter
    
    tmux new-window -t "$session_name" -n "network" -c "$project_path"
    tmux send-keys -t "$session_name:network" "ss -tulpn" Enter
    
    tmux new-window -t "$session_name" -n "docker" -c "$project_path"
    tmux send-keys -t "$session_name:docker" "docker ps -a" Enter
    
    tmux select-window -t "$session_name:system"
    tmux attach-session -t "$session_name"
}

# Kill all sessions except current
tmux-cleanup() {
    local current_session=""
    if tmux display-message -p 2>/dev/null; then
        current_session=$(tmux display-message -p "#{session_name}" 2>/dev/null)
    fi
    
    tmux list-sessions -F "#{session_name}" 2>/dev/null | while read session; do
        if [[ "$session" != "$current_session" ]]; then
            echo "Killing session: $session"
            tmux kill-session -t "$session"
        fi
    done
}

# Show tmux session status
tmux-status() {
    echo "=== Tmux Sessions ==="
    if tmux list-sessions 2>/dev/null; then
        echo ""
        echo "=== Current Session Windows ==="
        if tmux display-message -p 2>/dev/null; then
            local current_session=$(tmux display-message -p "#{session_name}")
            echo "Session: $current_session"
            tmux list-windows -t "$current_session" -F "#{window_index}: #{window_name} (#{pane_current_path})"
        else
            echo "Not in a tmux session"
        fi
    else
        echo "No active sessions"
    fi
}