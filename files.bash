#!/bin/bash

# Define variables
DOTFILES_DIR="$HOME/Lab/git-repos/.dotfiles/"
DOTFILES=(".bashrc" ".vimrc" ".zshrc" ".tmux.conf" ".config/nvim") # Add any other dotfiles you want to back up

# Create the backup directory if it doesn't exist
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Creating backup directory at $DOTFILES_DIR..."
    mkdir -p "$DOTFILES_DIR"
else
    echo "Backup directory already exists at $DOTFILES_DIR."
fi

# Copy dotfiles to the backup directory
echo "Copying dotfiles to $DOTFILES_DIR..."
for item in "${DOTFILES[@]}"; do
    SOURCE="$HOME/$item"
    TARGET="$DOTFILES_DIR/$item"

    if [ -f "$SOURCE" ]; then
        # Copy file
        cp -f "$SOURCE" "$DOTFILES_DIR"
        echo "Copied file $item to $DOTFILES_DIR."
    elif [ -d "$SOURCE" ]; then
        # Copy directory recursively
        mkdir -p "$(dirname "$TARGET")"
        cp -rf "$SOURCE" "$TARGET"
        echo "Copied directory $item to $DOTFILES_DIR."
    else
        echo "File or directory $item does not exist, skipping."
    fi
done

# Initialize a git repository if not already done
if [ ! -d "$DOTFILES_DIR/.git" ]; then
    echo "Initializing git repository in $DOTFILES_DIR..."
    cd "$DOTFILES_DIR" && git init
else
    echo "Git repository already initialized in $DOTFILES_DIR."
fi

# Create a .gitignore file to exclude unnecessary files
GITIGNORE="$DOTFILES_DIR/.gitignore"
echo "Creating .gitignore file..."
cat > "$GITIGNORE" <<EOL
*.swp
*.bak
*~
*.tmp
EOL

# Commit and push the changes
cd "$DOTFILES_DIR"
git add .
git commit -m "Backing up dotfiles"
git push origin main
