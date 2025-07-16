#!/bin/bash

# Tmux Project Templates
# Source this file to get project-specific tmux session functions

# Web Development Template
web_session() {
    local session_name="${1:-web}"
    local project_path="${2:-$(pwd)}"
    
    # If project path doesn't start with /, assume it's relative to ~/Code
    if [[ ! "$project_path" =~ ^/ ]]; then
        project_path="$HOME/Code/$project_path"
    fi
    
    if tmux has-session -t "$session_name" 2>/dev/null; then
        tmux attach-session -t "$session_name"
        return 0
    fi
    
    tmux new-session -d -s "$session_name" -c "$project_path" -n "editor"
    tmux new-window -t "$session_name" -n "client" -c "$project_path"
    tmux new-window -t "$session_name" -n "server" -c "$project_path"
    tmux new-window -t "$session_name" -n "tests" -c "$project_path"
    tmux new-window -t "$session_name" -n "git" -c "$project_path"
    tmux new-window -t "$session_name" -n "ai" -c "$project_path"
    
    # Windows ready for development
    tmux select-window -t "$session_name:editor"
    tmux attach-session -t "$session_name"
}

# Full Stack Template (separate client/server dirs)
fullstack_session() {
    local session_name="${1:-fullstack}"
    local project_path="${2:-$(pwd)}"
    
    # If project path doesn't start with /, assume it's relative to ~/Code
    if [[ ! "$project_path" =~ ^/ ]]; then
        project_path="$HOME/Code/$project_path"
    fi
    
    if tmux has-session -t "$session_name" 2>/dev/null; then
        tmux attach-session -t "$session_name"
        return 0
    fi
    
    tmux new-session -d -s "$session_name" -c "$project_path" -n "main"
    
    # Check for client directory
    local client_path=""
    if [[ -d "$project_path/client" ]]; then
        client_path="$project_path/client"
    elif [[ -d "$project_path/frontend" ]]; then
        client_path="$project_path/frontend"
    fi
    
    # Check for server directory
    local server_path=""
    if [[ -d "$project_path/server" ]]; then
        server_path="$project_path/server"
    elif [[ -d "$project_path/backend" ]]; then
        server_path="$project_path/backend"
    elif [[ -d "$project_path/api" ]]; then
        server_path="$project_path/api"
    fi
    
    # Client window (nvim for client development)
    if [[ -n "$client_path" ]]; then
        tmux new-window -t "$session_name" -n "client" -c "$client_path"
    fi
    
    # Server window (nvim for server development)
    if [[ -n "$server_path" ]]; then
        tmux new-window -t "$session_name" -n "server" -c "$server_path"
    fi
    
    # Claude AI window
    tmux new-window -t "$session_name" -n "claude" -c "$project_path"
    
    # Gemini AI window
    tmux new-window -t "$session_name" -n "gemini" -c "$project_path"
    
    # Client running window (for running client folder)
    if [[ -n "$client_path" ]]; then
        tmux new-window -t "$session_name" -n "client-run" -c "$client_path"
    fi
    
    # Server running window (for running server folder)
    if [[ -n "$server_path" ]]; then
        tmux new-window -t "$session_name" -n "server-run" -c "$server_path"
    fi
    
    # Lazygit window
    tmux new-window -t "$session_name" -n "lazygit" -c "$project_path"
    
    # Terminal window (for downloads and package management)
    tmux new-window -t "$session_name" -n "terminal" -c "$project_path"
    
    tmux select-window -t "$session_name:main"
    tmux attach-session -t "$session_name"
}

# Python/Data Science Template
python_session() {
    local session_name="${1:-python}"
    local project_path="${2:-$(pwd)}"
    
    # If project path doesn't start with /, assume it's relative to ~/Code
    if [[ ! "$project_path" =~ ^/ ]]; then
        project_path="$HOME/Code/$project_path"
    fi
    
    if tmux has-session -t "$session_name" 2>/dev/null; then
        tmux attach-session -t "$session_name"
        return 0
    fi
    
    tmux new-session -d -s "$session_name" -c "$project_path" -n "main"
    tmux new-window -t "$session_name" -n "jupyter" -c "$project_path"
    tmux new-window -t "$session_name" -n "tests" -c "$project_path"
    tmux new-window -t "$session_name" -n "git" -c "$project_path"
    tmux new-window -t "$session_name" -n "env" -c "$project_path"
    
    # Windows ready for Python development
    tmux select-window -t "$session_name:main"
    tmux attach-session -t "$session_name"
}

# DevOps/Infrastructure Template
devops_session() {
    local session_name="${1:-devops}"
    local project_path="${2:-$(pwd)}"
    
    # If project path doesn't start with /, assume it's relative to ~/Code
    if [[ ! "$project_path" =~ ^/ ]]; then
        project_path="$HOME/Code/$project_path"
    fi
    
    if tmux has-session -t "$session_name" 2>/dev/null; then
        tmux attach-session -t "$session_name"
        return 0
    fi
    
    tmux new-session -d -s "$session_name" -c "$project_path" -n "main"
    tmux new-window -t "$session_name" -n "docker" -c "$project_path"
    tmux new-window -t "$session_name" -n "k8s" -c "$project_path"
    tmux new-window -t "$session_name" -n "terraform" -c "$project_path"
    tmux new-window -t "$session_name" -n "monitoring" -c "$project_path"
    tmux new-window -t "$session_name" -n "git" -c "$project_path"
    
    # Windows ready for DevOps development
    tmux select-window -t "$session_name:main"
    tmux attach-session -t "$session_name"
}

# Generic development template
dev_session() {
    local session_name="${1:-dev}"
    local project_path="${2:-$(pwd)}"
    
    # If project path doesn't start with /, assume it's relative to ~/Code
    if [[ ! "$project_path" =~ ^/ ]]; then
        project_path="$HOME/Code/$project_path"
    fi
    
    if tmux has-session -t "$session_name" 2>/dev/null; then
        tmux attach-session -t "$session_name"
        return 0
    fi
    
    tmux new-session -d -s "$session_name" -c "$project_path" -n "main"
    tmux new-window -t "$session_name" -n "work" -c "$project_path"
    tmux new-window -t "$session_name" -n "tests" -c "$project_path"
    tmux new-window -t "$session_name" -n "git" -c "$project_path"
    tmux new-window -t "$session_name" -n "ai" -c "$project_path"
    
    # Windows ready for development
    tmux select-window -t "$session_name:main"
    tmux attach-session -t "$session_name"
}

# Simple project session
project_session() {
    local session_name="${1:-project}"
    local project_path="${2:-$(pwd)}"
    
    # If project path doesn't start with /, assume it's relative to ~/Code
    if [[ ! "$project_path" =~ ^/ ]]; then
        project_path="$HOME/Code/$project_path"
    fi
    
    if tmux has-session -t "$session_name" 2>/dev/null; then
        tmux attach-session -t "$session_name"
        return 0
    fi
    
    tmux new-session -d -s "$session_name" -c "$project_path" -n "main"
    tmux new-window -t "$session_name" -n "main-run" -c "$project_path"
    tmux new-window -t "$session_name" -n "claude" -c "$project_path"
    tmux new-window -t "$session_name" -n "gemini" -c "$project_path"
    tmux new-window -t "$session_name" -n "lazygit" -c "$project_path"
    tmux new-window -t "$session_name" -n "terminal" -c "$project_path"
    
    tmux select-window -t "$session_name:main"
    tmux attach-session -t "$session_name"
}