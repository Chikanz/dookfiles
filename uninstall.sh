#!/usr/bin/env bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_info() {
    echo -e "${BLUE}==>${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}!${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Get the dotfiles directory
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

print_warning "This will unstow all dotfiles and remove all symlinks"
print_warning "The ~/.dotfiles directory will remain (but can be deleted manually)"
read -p "Continue? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    print_error "Aborted"
    exit 1
fi

# Unstow all packages
print_info "Unstowing all packages..."
cd "$DOTFILES_DIR"

for dir in */; do
    dirname=$(basename "$dir")
    # Skip hidden directories like .git
    if [[ ! "$dirname" =~ ^\. ]]; then
        print_info "Unstowing $dirname..."
        stow -D "$dirname" 2>&1 | grep -v "BUG in find_stowed_path" || true
    fi
done

print_success "All packages unstowed"

# Clean up any remaining symlinks that point to .dotfiles
print_info "Cleaning up any remaining .dotfiles symlinks in home directory..."
CLEANED=0
find "$HOME" -maxdepth 1 -type l | while read link; do
    if readlink "$link" | grep -q ".dotfiles"; then
        print_warning "Removing symlink: $link"
        rm "$link"
        CLEANED=$((CLEANED + 1))
    fi
done

if [[ $CLEANED -eq 0 ]]; then
    print_success "No additional symlinks to clean up"
else
    print_success "Cleaned up $CLEANED additional symlinks"
fi

echo ""
print_success "Uninstall complete!"
echo ""
print_info "Next steps:"
echo "  1. To completely remove dotfiles: rm -rf $DOTFILES_DIR"
echo "  2. To restore backups, check for directories like: ~/.dotfiles_backup_*"
echo ""
