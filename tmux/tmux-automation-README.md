# Tmux Automation Setup

Automated tmux session management for development workflows with named windows and base directories.

**Updated**: Now defaults to ~/Code directory for all relative paths!

## Files Created

- `tmux-session.sh` - Main automation script with intelligent project detection
- `tmux-templates.sh` - Project-specific session templates
- `tmux-aliases.sh` - Shell aliases and helper functions

## Quick Setup

1. Make the aliases available in your shell:
```bash
echo 'source ~/tmux-aliases.sh' >> ~/.bashrc
# or for zsh:
echo 'source ~/tmux-aliases.sh' >> ~/.zshrc
```

2. Reload your shell:
```bash
source ~/.bashrc  # or ~/.zshrc
```

## Main Session Types

### tmux_fs (Full-Stack)
Creates a full-stack session with:
- **main** - Base project directory
- **client** - nvim for client development
- **server** - nvim for server development
- **claude** - Claude AI
- **gemini** - Gemini AI
- **client-run** - For running client folder
- **server-run** - For running server folder
- **lazygit** - Lazygit
- **terminal** - Downloads and package management

Usage:
```bash
tmux_fs events events
# Auto-detects ~/Code/events/client and ~/Code/events/server
```

### tmux_p (Project)
Simple project session with:
- **main** - Base project directory
- **main-run** - Terminal for running main directory
- **claude** - Claude AI
- **gemini** - Gemini AI
- **lazygit** - Lazygit
- **terminal** - General terminal for downloads and package management

Usage:
```bash
tmux_p nvim nvim
# Creates session in ~/Code/nvim
```

### tmux_n (Normal)
Standard tmux session with no predefined windows:

Usage:
```bash
tmux_n work
# Creates normal tmux session named 'work' in current directory

tmux_n
# Creates normal tmux session named 'normal' in current directory
```

## Usage Examples

### Basic Commands
```bash
# Full-stack session  
tmux_fs events events

# Simple project session
tmux_p nvim nvim

# Normal tmux session
tmux_n work
```

### Session Management
```bash
# List all sessions
tmux_ls

# Attach to session
tmux_a session-name

# Kill session
tmux_k session-name

# Kill all sessions
tmux_ka
```

### Quick Help
```bash
# Show command reference
tmux
```

## Code Directory Integration

**All relative paths now default to ~/Code directory!**

Examples:
- `tmux_fs events events` → Creates session in `~/Code/events`  
- `tmux_p nvim nvim` → Creates session in `~/Code/nvim`
- `tmux_n work` → Creates session in current directory

Absolute paths still work:
- `tmux_p test /tmp/test` → Creates session in `/tmp/test`

## Window Definitions

### Full-Stack Session Windows:
- **main** - Base project directory for overview
- **client** - nvim for client development
- **server** - nvim for server development
- **claude** - Claude AI assistance
- **gemini** - Gemini AI assistance
- **client-run** - For running the client folder (npm, etc.)
- **server-run** - For running the server folder (npm, etc.)
- **lazygit** - Git version control
- **terminal** - Downloads and package management (npm, pacman, yay, pip)

### Project Session Windows:
- **main** - Base project directory
- **main-run** - Terminal for running main directory operations
- **claude** - Claude AI assistance
- **gemini** - Gemini AI assistance
- **lazygit** - Git version control
- **terminal** - General terminal for downloads and package management

### Normal Session:
- Standard tmux session with default window behavior
- Opens in current working directory
- No predefined windows

## Your Projects Examples

```bash
# Nvim configuration
tmux_p nvim nvim

# Events project (full-stack)
tmux_fs events events

# Syntax project (simple)
tmux_p syntax syntax

# Quick work session
tmux_n work
```

## Tips

1. **Use short relative paths** like `tmux_p nvim nvim` instead of full paths
2. **The script prevents duplicate sessions** - it will attach to existing sessions instead
3. **Windows are created empty** - no commands run automatically
4. **Base directories are set per window** so you don't need to cd before starting tmux
5. **All relative paths default to ~/Code** making project access much faster
6. **Type `tmux` for quick command reference**
7. **Use `tmux_n` for simple sessions without structured windows**

## Troubleshooting

- **Script not executable**: Run `chmod +x ~/tmux-session.sh ~/tmux-templates.sh ~/tmux-aliases.sh`
- **Functions not available**: Ensure you've sourced the aliases file in your shell config
- **Sessions not starting**: Check that tmux is installed and project paths exist
- **Path issues**: Remember relative paths go to ~/Code, use absolute paths if needed