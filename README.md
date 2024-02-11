## USAGE

1. Add

```
chezmoi add --follow ~/.zshrc
```

2. Edit and apply

```
chezmoi edit {TARGET_PATH}
chezmoi apply
```

## Ignore

- Ignore file or dir
  .chezmoiignore

```
ディレクトリを除外
iterm/

ファイルを除外
README.md
```

- update

```
chezmoi update
```

## 移行

1. chezmoi のプロジェクトへの移動

```
$ chezmoi cd
```

2. 変更の commit & push

```
$ git add .
$ git remote add origin git@github.com:kawamataryo/dotfiles.git
$ git push
```

そして別 PC にて chezmoi のプロジェクト初期化の際に GitHub のリポジトリを指定します

3. 別 PC での操作

```
$ brew install chezmoi

$ chezmoi init git@github.com:kawamataryo/dotfiles.git
```

これで~/.local/share/chezmoi 配下に GitHub リポジトリ上のファイルが作成されます。
この状態で apply コマンドを実行すれば適切なパスに dotfiles が作成されます。

```
$ chezmoi apply
```

---

- 参考
  https://github.com/johnmanjiro13/dotfiles
