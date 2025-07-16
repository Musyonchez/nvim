#!/bin/bash

# Tmux Session Automation Script
# Usage: ./tmux-session.sh [session_name] [project_path]

SESSION_NAME="${1:-dev}"
PROJECT_PATH="${2:-$(pwd)}"

# If project path doesn't start with /, assume it's relative to ~/Code
if [[ ! "$PROJECT_PATH" =~ ^/ ]]; then
    PROJECT_PATH="$HOME/Code/$PROJECT_PATH"
fi

# Function to create a new tmux session with named windows
create_session() {
    local session_name="$1"
    local base_path="$2"
    
    # Check if session already exists
    if tmux has-session -t "$session_name" 2>/dev/null; then
        echo "Session '$session_name' already exists. Attaching..."
        tmux attach-session -t "$session_name"
        return 0
    fi
    
    echo "Creating new session '$session_name' with base path '$base_path'"
    
    # Create new session with first window
    tmux new-session -d -s "$session_name" -c "$base_path" -n "main"
    
    # Create additional windows based on project type
    detect_and_setup_project "$session_name" "$base_path"
    
    # Attach to the session
    tmux attach-session -t "$session_name"
}

# Function to detect project type and setup appropriate windows
detect_and_setup_project() {
    local session_name="$1"
    local base_path="$2"
    
    # Check for common project patterns
    if [[ -f "$base_path/package.json" ]]; then
        setup_node_project "$session_name" "$base_path"
    elif [[ -f "$base_path/client/package.json" && -f "$base_path/server/package.json" ]]; then
        setup_fullstack_project "$session_name" "$base_path"
    elif [[ -d "$base_path/client" || -d "$base_path/frontend" ]]; then
        setup_client_server_project "$session_name" "$base_path"
    else
        setup_generic_project "$session_name" "$base_path"
    fi
}

# Setup for Node.js projects
setup_node_project() {
    local session_name="$1"
    local base_path="$2"
    
    tmux new-window -t "$session_name" -n "server" -c "$base_path"
    tmux new-window -t "$session_name" -n "logs" -c "$base_path"
    tmux new-window -t "$session_name" -n "git" -c "$base_path"
    
    # Windows ready for Node.js development
    
    # Focus on main window
    tmux select-window -t "$session_name:main"
}

# Setup for full-stack projects with client and server folders
setup_fullstack_project() {
    local session_name="$1"
    local base_path="$2"
    
    # Client window
    tmux new-window -t "$session_name" -n "client" -c "$base_path/client"
    
    # Server window
    tmux new-window -t "$session_name" -n "server" -c "$base_path/server"
    
    # Database/logs window
    tmux new-window -t "$session_name" -n "db" -c "$base_path"
    
    # Git window
    tmux new-window -t "$session_name" -n "git" -c "$base_path"
    
    # AI window for Claude/Gemini
    tmux new-window -t "$session_name" -n "ai" -c "$base_path"
    
    # Focus on main window
    tmux select-window -t "$session_name:main"
}

# Setup for client-server projects with separate directories
setup_client_server_project() {
    local session_name="$1"
    local base_path="$2"
    
    local client_dir=""
    local server_dir=""
    
    # Detect client and server directories
    if [[ -d "$base_path/client" ]]; then
        client_dir="$base_path/client"
    elif [[ -d "$base_path/frontend" ]]; then
        client_dir="$base_path/frontend"
    fi
    
    if [[ -d "$base_path/server" ]]; then
        server_dir="$base_path/server"
    elif [[ -d "$base_path/backend" ]]; then
        server_dir="$base_path/backend"
    elif [[ -d "$base_path/api" ]]; then
        server_dir="$base_path/api"
    fi
    
    # Create client window if client directory exists
    if [[ -n "$client_dir" ]]; then
        tmux new-window -t "$session_name" -n "client" -c "$client_dir"
    fi
    
    # Create server window if server directory exists
    if [[ -n "$server_dir" ]]; then
        tmux new-window -t "$session_name" -n "server" -c "$server_dir"
    fi
    
    # Common windows
    tmux new-window -t "$session_name" -n "git" -c "$base_path"
    
    tmux new-window -t "$session_name" -n "ai" -c "$base_path"
    
    # Focus on main window
    tmux select-window -t "$session_name:main"
}

# Setup for generic projects
setup_generic_project() {
    local session_name="$1"
    local base_path="$2"
    
    tmux new-window -t "$session_name" -n "work" -c "$base_path"
    tmux new-window -t "$session_name" -n "git" -c "$base_path"
    
    tmux new-window -t "$session_name" -n "ai" -c "$base_path"
    
    # Focus on main window
    tmux select-window -t "$session_name:main"
}

# Function to list existing sessions
list_sessions() {
    echo "Existing tmux sessions:"
    tmux list-sessions 2>/dev/null || echo "No active sessions"
}

# Function to kill a session
kill_session() {
    local session_name="$1"
    if tmux has-session -t "$session_name" 2>/dev/null; then
        tmux kill-session -t "$session_name"
        echo "Session '$session_name' killed"
    else
        echo "Session '$session_name' does not exist"
    fi
}

# Main execution
case "${1:-}" in
    "--list"|"-l")
        list_sessions
        ;;
    "--kill"|"-k")
        if [[ -z "$2" ]]; then
            echo "Usage: $0 --kill <session_name>"
            exit 1
        fi
        kill_session "$2"
        ;;
    "--help"|"-h")
        echo "Usage: $0 [session_name] [project_path]"
        echo "       $0 --list               List existing sessions"
        echo "       $0 --kill <session>     Kill a session"
        echo "       $0 --help               Show this help"
        echo ""
        echo "If no arguments provided, creates 'dev' session in current directory"
        ;;
    *)
        create_session "$SESSION_NAME" "$PROJECT_PATH"
        ;;
esac