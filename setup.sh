#!/usr/bin/env bash
# setup.sh – Konfigurer Git og SSH på en ny maskin
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

info()    { echo -e "${GREEN}==> $*${NC}"; }
warning() { echo -e "${YELLOW}ADVARSEL: $*${NC}"; }

backup_if_exists() {
  local target="$1"
  if [[ -f "$target" ]]; then
    local backup="${target}.bak.$(date +%Y%m%d_%H%M%S)"
    warning "Eksisterende fil funnet: $target"
    cp "$target" "$backup"
    echo "    Sikkerhetskopi lagret: $backup"
  fi
}

# ─── Git-konfigurasjon ───────────────────────────────────────────────────────
info "Setter opp Git-konfigurasjon..."

read -rp "  Fullt navn (for Git): " git_name
read -rp "  E-postadresse (for Git): " git_email

GITCONFIG_SRC="$SCRIPT_DIR/git/.gitconfig"
GITCONFIG_DEST="$HOME/.gitconfig"

backup_if_exists "$GITCONFIG_DEST"

sed \
  -e "s/YOUR_NAME/$git_name/" \
  -e "s/YOUR_EMAIL/$git_email/" \
  "$GITCONFIG_SRC" > "$GITCONFIG_DEST"

echo "  Git-konfig skrevet til $GITCONFIG_DEST"

# ─── SSH-konfigurasjon ───────────────────────────────────────────────────────
info "Setter opp SSH-konfigurasjon..."

mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

SSH_CONFIG_DEST="$HOME/.ssh/config"
backup_if_exists "$SSH_CONFIG_DEST"

cp "$SCRIPT_DIR/ssh/config.example" "$SSH_CONFIG_DEST"
chmod 600 "$SSH_CONFIG_DEST"

echo "  SSH-konfig kopiert til $SSH_CONFIG_DEST"
echo ""
warning "Husk å redigere $SSH_CONFIG_DEST og bytte YOUR_SSH_KEY med din faktiske nøkkelfil (f.eks. id_ed25519)"

# ─── Ferdig ─────────────────────────────────────────────────────────────────
echo ""
info "Oppsett fullført!"
echo ""
echo "Neste steg:"
echo "  1. Rediger ~/.ssh/config og bytt YOUR_SSH_KEY med din SSH-nøkkel"
echo "  2. Hvis du ikke har en SSH-nøkkel, generer en med:"
echo "       ssh-keygen -t ed25519 -C \"$git_email\""
echo "  3. Legg til din offentlige nøkkel på GitHub:"
echo "       cat ~/.ssh/<din-nokkel>.pub"
