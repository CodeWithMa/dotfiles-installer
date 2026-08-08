WARNING: Never run random scripts by piping them from curl into your shell!
Make sure to read its content first!

``` shell
curl -s "https://raw.githubusercontent.com/CodeWithMa/dotfiles-installer/refs/heads/dev/install.zsh" | zsh
```

If you cloned from Codeberg and need to update your remotes to GitHub:

``` shell
curl -s "https://raw.githubusercontent.com/CodeWithMa/dotfiles-installer/refs/heads/dev/update-remote.zsh" | zsh
```
