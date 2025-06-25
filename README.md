# dotfiles

## 💻 Setting Up on a New Machine

Follow these steps to set up this environment on a new machine.

### 1\. Clone the Repository

First, clone this repository as a `bare` repository into a directory named `.dotfiles` inside your home directory.

```bash
# Using SSH (Recommended)
git clone --bare git@github.com:dyoshyy/dotfiles.git $HOME/.dotfiles

# Using HTTPS
# git clone --bare https://github.com/your-username/dotfiles.git $HOME/.dotfiles
```

### 2\. Set Up the `config` Alias

Define the `config` alias to interact with your dotfiles.

```bash
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

To make this alias permanent, add it to your shell's configuration file (e.g., `~/.bashrc` or `~/.zshrc`).

```bash
echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> ~/.zshrc
# or >> ~/.bashrc
```

### 3\. Check Out the Files

Check out the configuration files from the repository into your home directory.

```bash
config checkout
```

#### ⚠️ Handling Conflicts

If existing configuration files with the same names (e.g., `.bashrc`) are already on the machine, the `checkout` command will fail. This is a safety measure to prevent accidentally overwriting your local files.

If this happens, use the following commands to automatically back up the conflicting files and then try the checkout again.

```bash
# List conflicting files and move them to a backup directory
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"
echo "Backing up conflicting files to $BACKUP_DIR..."
config checkout 2>&1 | grep -E "^\s+" | awk {'print $1'} | xargs -I{} sh -c 'mkdir -p "$(dirname "$BACKUP_DIR/{}")" && mv "$HOME/{}" "$BACKUP_DIR/{}" && echo "  -> backed up: {}"'

# Retry the checkout
echo "Retrying checkout..."
config checkout
```

### 4\. Configure the Repository

By default, `git status` will show all untracked files in the home directory. To prevent this, configure the local repository to hide them.

```bash
config config --local status.showUntrackedFiles no
```

### 5\. Finish Up

Reload your shell to apply the changes and enable the `config` alias.

```bash
source ~/.zshrc
# or source ~/.bashrc
```

Your environment is now ready\!
