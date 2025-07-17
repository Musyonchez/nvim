# Tmux Configuration Upgrade Guide

## What's New in Enhanced Config

Your enhanced tmux configuration (`tmux-enhanced.conf`) includes significant improvements while preserving all your existing keybindings and workflow.

## 🚀 Major Enhancements

### 1. **New Plugins Added**
- **tmux-fzf** - Fuzzy finder for sessions, windows, panes (`Prefix + C-f`)
- **tmux-thumbs** - Better text copying with hints (`Prefix + F`)

### 2. **Enhanced Navigation**
- Smart vim-tmux integration with `C-h/j/k/l`
- Better window switching with `M-n/M-p`
- Extended window selection (`M-1` through `M-9`)
- Quick session switching (`M-s`, `M-w`)

### 3. **Improved Status Bar**
- Better visual indicators for zoom, sync, prefix key
- Enhanced window status formatting
- More informative session display

### 4. **Developer Features**
- Popup windows support (`C-g` for lazygit, `C-t` for terminal)
- Quick access to your tmux automation (`Prefix + A`, `Prefix + T`)
- Better copy-paste with mouse support
- Enhanced pane synchronization

### 5. **Performance Optimizations**
- Faster status updates (2s intervals)
- Better terminal detection
- Increased history (100k lines)
- Optimized refresh rates

## 📋 Installation Steps

### 1. **Backup Current Config**
```bash
cp ~/.tmux.conf ~/.tmux.conf.backup
```

### 2. **Install New Plugins**
The config includes new plugins that need to be installed:

```bash
# If you don't have TPM installed yet:
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Copy the enhanced config
cp ~/Code/nvim/tmux/tmux-enhanced.conf ~/.tmux.conf

# Reload tmux config
tmux source ~/.tmux.conf

# Install new plugins (in tmux session)
# Press: Prefix + I (capital i)
```

### 3. **Install Plugin Dependencies**
Some plugins need external tools:

```bash
# For tmux-thumbs (if you want hint-based copying)
# This is optional - the plugin will work without it
sudo pacman -S rust
# or cargo install tmux-thumbs

# For better clipboard support (if not already installed)
sudo pacman -S xclip wl-clipboard
```

## 🔧 New Keybindings

### **Popup Windows** (New!)
- `Prefix + C-g` - Popup lazygit
- `Prefix + C-t` - Popup terminal
- `Prefix + \`` - Quick command popup

### **Enhanced Navigation**
- `C-h/j/k/l` - Smart vim-tmux pane switching
- `M-n/M-p` - Next/previous window (no prefix)
- `M-s` - Quick session chooser
- `M-w` - Quick window chooser

### **Fuzzy Finding**
- `Prefix + C-f` - Fuzzy finder menu (sessions, windows, panes)

### **Text Copying**
- `Prefix + F` - Thumbs mode (hint-based copying)
- Double-click - Select word
- Triple-click - Select line

### **Automation Integration**
- `Prefix + A` - Show automation help
- `Prefix + T` - Quick automation guide

## 🎯 What's Preserved

All your existing keybindings still work:
- `Prefix = C-a`
- `|` and `-` for splits
- `h/j/k/l` for pane navigation
- `H/J/K/L` for resizing
- `M-1` through `M-5` for window selection
- All your copy-paste bindings
- Mouse support
- All plugin settings (resurrect, continuum, etc.)

## 🔄 Gradual Migration

You can migrate gradually:

1. **Keep your current config** - The enhanced version is in `tmux-enhanced.conf`
2. **Test specific features** - Copy sections you like to your existing config
3. **Full switch** - Replace your config when ready

## 🛠 Troubleshooting

### Plugin Installation Issues
```bash
# If plugins don't install automatically
cd ~/.tmux/plugins/tpm
git pull

# In tmux, run:
# Prefix + I (install plugins)
# Prefix + U (update plugins)
```

### Performance Issues
```bash
# If status bar updates are too frequent
# In your config, change:
set -g status-interval 5  # Instead of 2
```

### Popup Windows Not Working
Popup windows require tmux 3.2+. Check version:
```bash
tmux -V
```

## 📊 Performance Comparison

| Feature | Old Config | Enhanced Config |
|---------|------------|-----------------|
| History | 50k lines | 100k lines |
| Status Updates | 5s | 2s |
| Plugin Count | 5 | 7 |
| Keybindings | ~30 | ~45 |
| Popup Support | No | Yes |

## 🎨 Visual Improvements

- Better pane border highlighting
- Enhanced status bar indicators
- Cleaner window status format
- More informative session display
- Better zoom/sync indicators

## 🔗 Integration with Your Automation

The enhanced config includes hooks for your tmux automation scripts:

- Quick access to session types (`tmux_fs`, `tmux_p`, `tmux_n`)
- Visual indicators for automation features
- Popup integration for quick commands

Try it out and let me know if you want any adjustments!