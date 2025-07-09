alias ls 'ls -lFh --color=auto' # lsを見やすくする
alias la 'ls -A' # 隠しファイルを含めて表示
alias ll 'ls -lA' # 詳細表示

# git
alias gl 'git log --oneline --graph --decorate'

# pacman
alias p 'pacman --color=auto'
alias ps 'pacman -S' # インストール
alias pss 'pacman -Ss' # 検索
alias prm 'pacman -Rns'# 削除

# yay
alias y 'yay --color=auto'

# dotfiles管理用 (Bare Repository)
alias config '/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# --- 環境変数 ---
# デフォルトのエディタをNeovimに設定
set -x EDITOR nvim
set -x VISUAL nvim

# PATHにローカルの実行ファイル置き場を追加
fish_add_path ~/.local/bin

# --- ssh-agent (keychain) ---
# ターミナル起動時にssh-agentを起動し、鍵を登録する
if status is-interactive; and command -v keychain >/dev/null
    command keychain --quiet --nogui id_ed25519
    if test -f $HOME/.keychain/(hostname)-fish
        source $HOME/.keychain/(hostname)-fish
    end
end

# --- Starshipプロンプトの有効化 ---
# この行がfishのプロンプトをStarshipに設定します
starship init fish | source

# fishのデフォルトのあいさつを非表示にする
set -g fish_greeting
