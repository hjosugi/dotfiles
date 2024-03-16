# prompt
set __fish_git_prompt_color_branch white

# alias
alias glg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
alias glga="git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --all"

# peco
function peco_select_history_order
  if test (count $argv) = 0
    set peco_flags --layout=top-down
  else
    set peco_flags --layout=bottom-up --query "$argv"
  end

  history|peco $peco_flags|read foo

  if [ $foo ]
    commandline $foo
  else
    commandline ''
  end
end

function peco_z
  set -l query (commandline)

  if test -n $query
    set peco_flags --query "$query"
  end

  z -l | peco $peco_flags | awk '{ print $2 }' | read recent
  if [ $recent ]
      cd $recent
      commandline -r ''
      commandline -f repaint
  end
end

function pgch
  if [ -e .git ]
    git checkout (git branch | peco | tr -d " ")
  else
    echo "[ERROR]: .git is not found."
  end
end

function trc
  pbpaste | awk -v eof=(math (pbpaste | wc -l)+1) '{if (NR==eof) print $0;else print $0","}' | pbcopy
end  

# ghq
set GHQ_SELECTOR fzf
set -g GHQ_SELECTOR_OPTS --no-sort --reverse --ansi --color bg+:13,hl:3,pointer:7

# python
set -x LDFLAGS "-L/usr/local/opt/tcl-tk/lib"
set -x CPPFLAGS "-I/usr/local/opt/tcl-tk/include"
set -x PKG_CONFIG_PATH "/usr/local/opt/tcl-tk/lib/pkgconfig"
set -x PYTHON_CONFIGURE_OPTS "--with-tcltk-includes='-I/usr/local/opt/tcl-tk/include' --with-tcltk-libs='-L/usr/local/opt/tcl-tk/lib -ltcl8.6 -ltk8.6'"


# pyenv init
if command -v pyenv 1>/dev/null 2>&1
  pyenv init - | source
end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/h.suginoo/google-cloud-sdk/path.fish.inc' ]; . '/Users/h.suginoo/google-cloud-sdk/path.fish.inc'; end

# keys
bind \cf forward-word
# bind \cb prevd-or-backward-word 

# zoxide
zoxide init fish --cmd z | source

# php
set PKG_CONFIG_PATH /usr/local/opt/icu4c/lib/pkgconfig /usr/local/opt/krb5/lib/pkgconfig /usr/local/opt/libedit/lib/pkgconfig /usr/local/opt/libxml2/lib/pkgconfig /usr/local/opt/openssl@1.1/lib/pkgconfig $PKG_CONFIG_PATH
# set PATH /usr/local/opt/bison/bin $PATH
set -gx PKG_CONFIG_PATH /usr/local/opt/icu4c/lib/pkgconfig /usr/local/opt/krb5/lib/pkgconfig /usr/local/opt/libedit/lib/pkgconfig /usr/local/opt/libxml2/lib/pkgconfig /usr/local/opt/openssl@1.1/lib/pkgconfig $PKG_CONFIG_PATH
set -gx PHP_CONFIGURE_OPTIONS --with-openssl=/usr/local/opt/openssl@1.1 --with-libxml-dir=/usr/local/opt/libxml2 --with-iconv=/usr/local/opt/libiconv --with-zlib
fish_add_path /usr/local/opt/openssl@3/bin

eval (opam env --switch=default)
abbr -a -- gbdel 'git branch | peco | xargs git branch --delete' # imported from a universal variable, see `help abbr`
abbr -a -- nk 'nkf -g' # imported from a universal variable, see `help abbr`
abbr -a -- lf 'exa -T --git-ignore' # imported from a universal variable, see `help abbr`
abbr -a -- ccu 'string upper (pbpaste)' # imported from a universal variable, see `help abbr`
abbr -a -- cddl 'cd Downloads ; clear' # imported from a universal variable, see `help abbr`
abbr -a -- gcn 'git add -A; git commit --amend --no-edit' # imported from a universal variable, see `help abbr`
abbr -a -- cs 'cloudsql -instances=carparking-jp:asia-northeast1:carparking-db-prod-replica-read-1=tcp:3308' # imported from a universal variable, see `help abbr`
abbr -a -- gresh 'git reset --hard origin/' # imported from a universal variable, see `help abbr`
abbr -a -- adc pbpaste\ \|\ awk\ -v\ eof=\(math\ \(pbpaste\ \|\ wc\ -l\)+1\)\ \'\{if\ \(NR==eof\)\ print\ \$0\;else\ print\ \$0\",\"\}\'\ \|\ pbcopy\  # imported from a universal variable, see `help abbr`
abbr -a -- gcoe 'git config user.email' # imported from a universal variable, see `help abbr`
abbr -a -- gpl 'gh pr list | fzf | head -n 1 | cut -f1 | xargs gh pr checkout' # imported from a universal variable, see `help abbr`
abbr -a -- aqc pbpaste\ \|\ awk\ -v\ eof=\(math\ \(pbpaste\ \|\ wc\ -l\)+1\)\ \'\{if\ \(NR==eof\)\ print\ \"\\\"\"\$0\"\\\"\"\;else\ print\ \"\\\"\"\$0\"\\\",\"\}\'\ \|\ pbcopy # imported from a universal variable, see `help abbr`
abbr -a -- grm 'git checkout main ; git pull origin main ; git checkout - ; git rebase main' # imported from a universal variable, see `help abbr`
abbr -a -- glp 'git log -p' # imported from a universal variable, see `help abbr`
abbr -a -- gssa 'git stash save -u' # imported from a universal variable, see `help abbr`
abbr -a -- ob 'open ~/workspace/bengal.code-workspace' # imported from a universal variable, see `help abbr`
abbr -a -- cddoc 'cd Documents ; clear' # imported from a universal variable, see `help abbr`
abbr -a -- c clear # imported from a universal variable, see `help abbr`
abbr -a -- gc gcloud # imported from a universal variable, see `help abbr`
abbr -a -- gpuo 'git pull origin' # imported from a universal variable, see `help abbr`
abbr -a -- gpd 'git checkout develop ; git fetch --all ; git reset --hard origin/(git symbolic-ref --short HEAD)' # imported from a universal variable, see `help abbr`
abbr -a -- gcom 'git add -A; git commit -m' # imported from a universal variable, see `help abbr`
abbr -a -- fg ghq\ list\ \|\ fzf\ --preview\ \"ls\ -laTp\ \(ghq\ root\)/\{\}\ \|\ tail\ -n+4\ \|\ awk\ \'\{print\ \\\$9\\\"/\\\"\\\$6\\\"/\\\"\\\$7\ \\\"\ \\\"\ \\\$10\}\'\" # imported from a universal variable, see `help abbr`
abbr -a -- aco pbpaste\ \|\ awk\ -v\ eof=\(math\ \(pbpaste\ \|\ wc\ -l\)+1\)\ \'\{if\ \(NR==eof\)\ print\ \$0\;else\ print\ \$0\",\"\}\'\ \|\ pbcopy\  # imported from a universal variable, see `help abbr`
abbr -a -- flr 'flutter run -d (pbpaste)' # imported from a universal variable, see `help abbr`
abbr -a -- grhard 'git reset --hard TARGET_COMMIT' # imported from a universal variable, see `help abbr`
abbr -a -- G 'go run' # imported from a universal variable, see `help abbr`
abbr -a -- cfd code\ \(fd\ \|\ sk\ --preview\ \'bat\ --style=numbers\ --color=always\ --line-range\ :500\ \{\}\'\ \|\ tr\ -d\ \"\\n\"\) # imported from a universal variable, see `help abbr`
abbr -a -- fco fish_config # imported from a universal variable, see `help abbr`
abbr -a -- nfd fd\ \|\ sk\ --preview\ \'bat\ --style=numbers\ --color=always\ --line-range\ :500\ \{\}\'\ \|\ tr\ -d\ \"\\n\"\ \|\ xargs\ nvim # imported from a universal variable, see `help abbr`
abbr -a -- cs-as 'cloudsql -instances=staging-carparking-jp:asia-northeast1:aplus-staging=tcp:3310' # imported from a universal variable, see `help abbr`
abbr -a -- ng 'nkf -g' # imported from a universal variable, see `help abbr`
abbr -a -- vls 'volta list' # imported from a universal variable, see `help abbr`
abbr -a -- ccsv read\ -c7d\ t\;\ echo\ \$t\ \|\ fd\ \'.csv\$\'\ --changed-within\ \(date\ -v-\$t\ +\"\%Y-\%m-\%d\ \%H:\%M:\%S\"\)\ \|\ sk\ \|\ xargs\ mlr\ --icsv\ --otsv\ cat\ \|\ pbcopy # imported from a universal variable, see `help abbr`
abbr -a -- pls 'cd ( ls -1d */ | peco )' # imported from a universal variable, see `help abbr`
abbr -a -- sg 'read q; googler --json -n20 -tm12 $q | gfzs' # imported from a universal variable, see `help abbr`
abbr -a -- s-ca pbpaste\\\ \\\|\\\ awk\\\ -F\\\ \\\'_\\\'\\\ \\\'\\\{\\\ printf\\\ \\\$1\\\;\\\ for\\\(i=2\\\;\\\ i\\\<=NF\\\;\\\ i++\\\)\\\ \\\{printf\\\ toupper\\\(substr\\\(\\\$i,1,1\\\)\\\)\\\ substr\\\(\\\$i,2\\\)\\\}\\\}\\\ END\\\ \\\{print\\\ \\\"\\\"\\\}\\\'\\\ \\\|\\\ pbcopy # imported from a universal variable, see `help abbr`
abbr -a -- d 'dart run' # imported from a universal variable, see `help abbr`
abbr -a -- sb /Applications/Sublime\\\ Text.app/Contents/SharedSupport/bin/subl\ . # imported from a universal variable, see `help abbr`
abbr -a -- dr 'dart run' # imported from a universal variable, see `help abbr`
abbr -a -- ca bat # imported from a universal variable, see `help abbr`
abbr -a -- gtd 'git tag -d v' # imported from a universal variable, see `help abbr`
abbr -a -- fld 'flutter devices' # imported from a universal variable, see `help abbr`
abbr -a -- gpm 'git pull origin main' # imported from a universal variable, see `help abbr`
abbr -a -- gs 'git show' # imported from a universal variable, see `help abbr`
abbr -a -- gco 'git add -A ; git commit -m ":+1: ' # imported from a universal variable, see `help abbr`
abbr -a -- pz zi # imported from a universal variable, see `help abbr`
abbr -a -- gan 'git add -A ; git commit --amend --no-edit' # imported from a universal variable, see `help abbr`
abbr -a -- clg '| ccze -A' # imported from a universal variable, see `help abbr`
abbr -a -- lg git\ log\ --graph\ --pretty=format:\'\%Cred\%h\%C\(reset\)\ \%C\(yellow\ reverse\)\%d\%Creset\ \%s\ \%Cgreen\(\%cr\)\ \%C\(bold\ blue\)\%Creset\%n\'\ --abbrev-commit\ --date=relative\ --branches # imported from a universal variable, see `help abbr`
abbr -a -- gsls git\ stash\ list\ \|\ peco\ \|\ awk\ -F\ \'\{\|\}\'\ \'\{print\ \$2\}\'\ \|\ xargs\ git\ stash\ apply # imported from a universal variable, see `help abbr`
abbr -a -- gr 'git rebase' # imported from a universal variable, see `help abbr`
abbr -a -- ldc lazydocker # imported from a universal variable, see `help abbr`
abbr -a -- gch 'git checkout' # imported from a universal variable, see `help abbr`
abbr -a -- gchp 'gh pr checkout' # imported from a universal variable, see `help abbr`
abbr -a -- gcma 'git commit --amend -m' # imported from a universal variable, see `help abbr`
abbr -a -- gcon 'git config user.name' # imported from a universal variable, see `help abbr`
abbr -a -- de 'yarn dev' # imported from a universal variable, see `help abbr`
abbr -a -- ydl 'yarn lint:js --fix && yarn lint:style --fix ; yarn dev' # imported from a universal variable, see `help abbr`
abbr -a -- gres 'git reset --soft @~' # imported from a universal variable, see `help abbr`
abbr -a -- s stack-2.7.5 # imported from a universal variable, see `help abbr`
abbr -a -- ycl 'cd app ; yarn clear-build-cache ; cd ../' # imported from a universal variable, see `help abbr`
abbr -a -- gfp 'git fetch --all ; git fetch --prune' # imported from a universal variable, see `help abbr`
abbr -a -- gg 'ghq get' # imported from a universal variable, see `help abbr`
abbr -a -- cadd 'code -add' # imported from a universal variable, see `help abbr`
abbr -a -- nt 'yarn ts-node' # imported from a universal variable, see `help abbr`
abbr -a -- glo 'git log --oneline --decorate' # imported from a universal variable, see `help abbr`
abbr -a -- grim 'git rebase -i (git show-ref -s origin/main)' # imported from a universal variable, see `help abbr`
abbr -a -- vf code\ \(sk\ --ansi\ -i\ -c\ \'rg\ --color=always\ --line-number\ \"\{\}\"\'\ --preview\ \"bat\ --style=numbers\ --line-range=:500\ --color=always\ --highlight-line\ \{2\}\ \{1\}\"\ --delimiter\ \':\'\ --nth\ 1\ \|\ awk\ -F\ \":\"\ \'\{print\ \$1\}\'\) # imported from a universal variable, see `help abbr`
abbr -a -- gp 'gh pr' # imported from a universal variable, see `help abbr`
abbr -a -- pri 'yarn prisma' # imported from a universal variable, see `help abbr`
abbr -a -- gpuf 'git fetch --all ; git reset --hard origin/(git symbolic-ref --short HEAD)' # imported from a universal variable, see `help abbr`
abbr -a -- trs pbpaste\ \|\ tr\ -d\ \"\[\\\"\\\'\]\"\ \|\ pbcopy # imported from a universal variable, see `help abbr`
abbr -a -- na navi\ --print\ \|\ tr\ -d\ \'\\n\'\|\ pbcopy # imported from a universal variable, see `help abbr`
abbr -a -- fpath echo\ -e\ \'\ PATH表示:\ echo\ \$fish_user_paths\ \|\ tr\ \"\ \"\ \"\\\\\\n\"\ \|\ nl\ \\n\ PATH追加:\ set\ -U\ fish_user_paths\ /usr/local/xxx/bin\ \$fish_user_paths\ \\n\ PATH削除:\ set\ --erase\ --universal\ fish_user_paths\[0\]\' # imported from a universal variable, see `help abbr`
abbr -a -- cs-o 'cloudsql -instances=carparking-one:asia-northeast1:carparking-one-db=tcp:3321' # imported from a universal variable, see `help abbr`
abbr -a -- grd 'git checkout develop ; git fetch --all ; git reset --hard origin/(git symbolic-ref --short HEAD) ; git checkout - ; git rebase develop;' # imported from a universal variable, see `help abbr`
abbr -a -- gresm git\ log\ \ \|\ sed\ -n\ -e\ \'5p\'\ \|\ pbcopy\ \|\ git\ reset\ --mixed\ @\~ # imported from a universal variable, see `help abbr`
abbr -a -- ph peco_select_history # imported from a universal variable, see `help abbr`
abbr -a -- gl glga # imported from a universal variable, see `help abbr`
abbr -a -- gra 'git rebase --abort' # imported from a universal variable, see `help abbr`
abbr -a -- nv volta\ list\ node\ \|\ fzf\ \|\ awk\ \'\{print\ \$2\}\'\ \|\ xargs\ volta\ install # imported from a universal variable, see `help abbr`
abbr -a -- grid 'git rebase -i (git show-ref -s origin/develop)' # imported from a universal variable, see `help abbr`
abbr -a -- his history\ \|\ peco\ \|\ tr\ -d\ \'\\n\'\ \|\ pbcopy # imported from a universal variable, see `help abbr`
abbr -a -- grso 'git reset --soft @~' # imported from a universal variable, see `help abbr`
abbr -a -- gss 'git stash save -u' # imported from a universal variable, see `help abbr`
abbr -a -- fin 'fisher install' # imported from a universal variable, see `help abbr`
abbr -a -- gw gitweb # imported from a universal variable, see `help abbr`
abbr -a -- ppa 'ps aux | peco' # imported from a universal variable, see `help abbr`
abbr -a -- h echo\ \"\~/\"\ \|\ tr\ -d\ \"\\n\"\ \|\ pbcopy # imported from a universal variable, see `help abbr`
abbr -a -- cia 'code-insiders -add' # imported from a universal variable, see `help abbr`
abbr -a -- ccs pbpaste\ \|\ sed\ -E\ \'s/\(.\)\(\[A-Z\]\)/\\1_\\2/g\'\ \|\ tr\ \'\[A-Z\]\'\ \'\[a-z\]\'\ \|\ pbcopy # imported from a universal variable, see `help abbr`
abbr -a -- p3 python3 # imported from a universal variable, see `help abbr`
abbr -a -- hs 'stack-2.7.5 runghc' # imported from a universal variable, see `help abbr`
abbr -a -- gbch 'git checkout -b' # imported from a universal variable, see `help abbr`
abbr -a -- pmig 'yarn prisma migrate dev --name' # imported from a universal variable, see `help abbr`
abbr -a -- ma git\ remote\ show\ origin\ \|\ grep\ \'HEAD\ branch\'\ \|\ awk\ \'\{print\ \$NF\}\'\ \|\ tr\ -d\ \"\\n\"\ \|\ pbcopy # imported from a universal variable, see `help abbr`
abbr -a -- mm git\ remote\ show\ origin\ \|\ grep\ \'HEAD\ branch\'\ \|\ awk\ \'\{print\ \$NF\} # imported from a universal variable, see `help abbr`
abbr -a -- n node # imported from a universal variable, see `help abbr`
abbr -a -- gpuma git\ checkout\ \(git\ remote\ show\ origin\ \|\ grep\ \'HEAD\ branch\'\ \|\ awk\ \'\{print\ \$NF\}\'\)\ \;\ git\ pull\ origin\ \(git\ remote\ show\ origin\ \|\ grep\ \'HEAD\ branch\'\ \|\ awk\ \'\{print\ \$NF\}\'\)\ \;\ git\ checkout\ -\ \;\ git\ rebase\ \(git\ remote\ show\ origin\ \|\ grep\ \'HEAD\ branch\'\ \|\ awk\ \'\{print\ \$NF\}\'\) # imported from a universal variable, see `help abbr`
abbr -a -- o 'open .' # imported from a universal variable, see `help abbr`
abbr -a -- sfi open\ \(fd\ \|\ sk\ --preview\ \'bat\ --style=numbers\ --color=always\ --line-range\ :500\ \{\}\'\ \|\ tr\ -d\ \"\\n\"\) # imported from a universal variable, see `help abbr`
abbr -a -- tn 'yarn ts-node' # imported from a universal variable, see `help abbr`
abbr -a -- oba 'open ~/workspace/bengal-api.code-workspace' # imported from a universal variable, see `help abbr`
abbr -a -- fz 'ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 (ghq root)/{}/README.*"' # imported from a universal variable, see `help abbr`
abbr -a -- odl 'cd /Users/h.suginoo/Downloads ; open . ; cd - ; clear' # imported from a universal variable, see `help abbr`
abbr -a -- cs-s 'cloudsql -instances=staging-carparking-jp:asia-northeast1:carparking-jp-staging-replica=tcp:3309' # imported from a universal variable, see `help abbr`
abbr -a -- gsr 'git checkout --ours . ; git reset ; git checkout .' # imported from a universal variable, see `help abbr`
abbr -a -- l lsd # imported from a universal variable, see `help abbr`
abbr -a -- pab 'abbr | peco' # imported from a universal variable, see `help abbr`
abbr -a -- e exa # imported from a universal variable, see `help abbr`
abbr -a -- voltan 'volta install node@' # imported from a universal variable, see `help abbr`
abbr -a -- gcone 'git commit --amend --no-edit' # imported from a universal variable, see `help abbr`
abbr -a -- pc 'tr -d | pbcopy' # imported from a universal variable, see `help abbr`
abbr -a -- pfi 'fd . | peco' # imported from a universal variable, see `help abbr`
abbr -a -- s-up 'string upper (pbpaste)' # imported from a universal variable, see `help abbr`
abbr -a -- ccc pbpaste\ \|\ awk\ -F\ \'_\'\ \'\{\ printf\ \$1\;\ for\(i=2\;\ i\<=NF\;\ i++\)\ \{printf\ toupper\(substr\(\$i,1,1\)\)\ substr\(\$i,2\)\}\}\ END\ \{print\ \"\"\}\'\ \|\ pbcopy # imported from a universal variable, see `help abbr`
abbr -a -- ti 'cd /Users/h.suginoo/Tips ; clear ; ls' # imported from a universal variable, see `help abbr`
abbr -a -- v nvim # imported from a universal variable, see `help abbr`
abbr -a -- ci- 'code-insiders -add' # imported from a universal variable, see `help abbr`
abbr -a -- y yarn # imported from a universal variable, see `help abbr`
abbr -a -- gpus 'git push origin' # imported from a universal variable, see `help abbr`
abbr -a -- ys 'yarn staging:deploy' # imported from a universal variable, see `help abbr`
abbr -a -- yd 'yarn dev' # imported from a universal variable, see `help abbr`
abbr -a -- x xonsh # imported from a universal variable, see `help abbr`
abbr -a -- grv 'git remote -v' # imported from a universal variable, see `help abbr`
abbr -a -- gbde 'git branch | xargs git branch -D' # imported from a universal variable, see `help abbr`
abbr -a -- nfg sk\ --ansi\ -i\ -c\ \'rg\ --color=always\ --line-number\ \"\{\}\"\'\ --preview\ \"bat\ --style=numbers\ --line-range=:500\ --color=always\ --highlight-line\ \{2\}\ \{1\}\"\ --delimiter\ \':\'\ --nth\ 1\ \|\ awk\ -F\ \":\"\ \'\{print\ \$1\}\'\ \|\ xargs\ nvim # imported from a universal variable, see `help abbr`
abbr -a -- g git # imported from a universal variable, see `help abbr`
abbr -a -- ghq 'ghq get' # imported from a universal variable, see `help abbr`
abbr -a -- dcc docker-compose # imported from a universal variable, see `help abbr`
abbr -a -- fw sk\ --ansi\ -i\ -c\ \'rg\ --color=always\ --line-number\ \"\{\}\"\'\ --preview\ \"bat\ --style=numbers\ --line-range=:500\ --color=always\ --highlight-line\ \{2\}\ \{1\}\"\ --delimiter\ \':\'\ --nth\ 1\ \|\ awk\ -F\ \":\"\ \'\{print\ \$1\}\'\ \|\ xargs # imported from a universal variable, see `help abbr`
abbr -a -- gresm- 'git reset --mixed @~' # imported from a universal variable, see `help abbr`
abbr -a -- yp 'yarn prettier --write --list-different .' # imported from a universal variable, see `help abbr`
abbr -a -- gpusf 'git push -f origin' # imported from a universal variable, see `help abbr`
abbr -a -- jis 'nkf -s --overwrite' # imported from a universal variable, see `help abbr`
abbr -a -- cs-ps 'cloudsql -instances=staging-carparking-jp:asia-northeast1:carparking-jp-staging=tcp:3309' # imported from a universal variable, see `help abbr`
abbr -a -- cs-tp 'cloudsql -instances=tomemiru:asia-northeast1:tomemiru=tcp:3351' # imported from a universal variable, see `help abbr`
abbr -a -- cs-ts 'cloudsql -instances=staging-tomemiru:asia-northeast1:tomemiru-staging=tcp:3350'
abbr -a -- gf 'git fetch --all' # imported from a universal variable, see `help abbr`
abbr -a -- ghcr 'gh pr create' # imported from a universal variable, see `help abbr`
abbr -a -- oad 'open ~/workspace/admin-carparking.code-workspace' # imported from a universal variable, see `help abbr`
abbr -a -- gc-p 'git cherry-pick' # imported from a universal variable, see `help abbr`
abbr -a -- obi 'open ~/workspace/birman-api.code-workspace' # imported from a universal variable, see `help abbr`
abbr -a -- gb 'git branch | sk | xargs git checkout' # imported from a universal variable, see `help abbr`
abbr -a -- gmm git\ checkout\ \(git\ remote\ show\ origin\ \|\ grep\ \'HEAD\ branch\'\ \|\ awk\ \'\{print\ \$NF\}\'\)\ \;\ git\ pull\ origin\ \(git\ remote\ show\ origin\ \|\ grep\ \'HEAD\ branch\'\ \|\ awk\ \'\{print\ \$NF\}\'\)\ \;\ git\ checkout\ -\ \;\ git\ rebase\ \(git\ remote\ show\ origin\ \|\ grep\ \'HEAD\ branch\'\ \|\ awk\ \'\{print\ \$NF\}\'\) # imported from a universal variable, see `help abbr`
abbr -a -- grc 'git rebase --continue' # imported from a universal variable, see `help abbr`
abbr -a -- c- 'code -add' # imported from a universal variable, see `help abbr`
abbr -a -- gada 'git add -A' # imported from a universal variable, see `help abbr`
abbr -a -- sfile open\ \(fd\ \|\ sk\ --preview\ \'bat\ --style=numbers\ --color=always\ --line-range\ :500\ \{\}\'\ \|\ tr\ -d\ \"\\n\"\) # imported from a universal variable, see `help abbr`
abbr -a -- gcoma 'git commit --amend -m' # imported from a universal variable, see `help abbr`
abbr -a -- s-sn pbpaste\\\ \\\|\\\ sed\\\ -E\\\ \\\'s/\\\(.\\\)\\\(\\\[A-Z\\\]\\\)/\\\\1_\\\\2/g\\\'\\\ \\\|\\\ tr\\\ \\\'\\\[A-Z\\\]\\\'\\\ \\\'\\\[a-z\\\]\\\'\\\ \\\|\\\ pbcopy # imported from a universal variable, see `help abbr`
abbr -a -- gcr 'gh pr create' # imported from a universal variable, see `help abbr`
abbr -a -- H --help # imported from a universal variable, see `help abbr`
abbr -a -- gme 'git merge' # imported from a universal variable, see `help abbr`
abbr -a -- gri 'git rebase -i' # imported from a universal variable, see `help abbr`
abbr -a -- gcpm 'git checkout main ; git pull origin main' # imported from a universal variable, see `help abbr`
abbr -a -- pp pbpaste # imported from a universal variable, see `help abbr`
abbr -a -- vc volta\ list\ node\ \|\ fzf\ \|\ awk\ \'\{print\ \$2\}\'\ \|\ xargs\ volta\ install # imported from a universal variable, see `help abbr`
abbr -a -- gcg 'gcloud sql generate-login-token | pbcopy'



# pnpm
alias pn=pnpm
abbr -a pd 'pnpm dev' 



# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/fish/__tabtab.fish ]; and . ~/.config/tabtab/fish/__tabtab.fish; or true


function fish_greeting
end

alias .. 'cd ..'
alias ... 'cd ../..'


# pnpm
set -gx PNPM_HOME "/Users/h.suginoo/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /Users/h.suginoo/.ghcup/bin # ghcup-env

# fish_add_path -U /nix/var/nix/profiles/default/bin
# fish_add_path -U /usr/local/go/bin
# fish_add_path -U /Users/h.suginoo/.fzf_bin/bin
# fish_add_path -U /nix/var/nix/profiles/default/bin
# fish_add_path -U /usr/local/opt/bison/bin
# fish_add_path -U /Users/h.suginoo/.cabal/bin
# fish_add_path -U /Users/h.suginoo/.ghcup/bin
# fish_add_path -U /Users/h.suginoo/google-cloud-sdk/bin
# fish_add_path -U /usr/local/opt/asdf/shims
# fish_add_path -U /usr/local/Cellar/asdf/0.10.1/libexec/bin
# fish_add_path -U /usr/local/opt/asdf/installs/flutter/2.10.0-stable/bin/flutter
# fish_add_path -U /usr/local/opt/openssl@3/bin
# fish_add_path -U /usr/local/opt/asdf/asdf.fish
# fish_add_path -U /Users/h.suginoo/.volta/bin
# fish_add_path -U /Users/h.suginoo/.cargo/bin
# fish_add_path -U /usr/local/opt/tcl-tk/bin
# fish_add_path -U /Users/h.suginoo/.yarn/bin
# fish_add_path -U /Users/h.suginoo/.fzf_bin/bin
# fish_add_path -U /nix/var/nix/profiles/default/bin
