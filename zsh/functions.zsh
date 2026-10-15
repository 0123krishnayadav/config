# ---------------------------------------------------------------------------
# functions.zsh - loaded from .zshrc (after Oh My Zsh, so these win)
# ---------------------------------------------------------------------------

# Kill whatever is listening on a port: killport 3000
killport() {
  lsof -ti:$1 | xargs -r kill
}
