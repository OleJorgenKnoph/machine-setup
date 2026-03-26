# machine-setup
[![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/OleJorgenKnoph/machine-setup)

Personlige konfigurasjonsfiler for oppsett av nye utviklingsmaskiner. Inneholder Git-aliaser og innstillinger, samt SSH-konfigurasjonsmaler.

## Innhold

```
machine-setup/
├── git/.gitconfig       # Git-aliaser og globale innstillinger (mal)
├── ssh/config.example   # SSH-konfigurasjonsmal for GitHub og generell bruk
└── setup.sh             # Automatisk oppsettskript
```

## Kom i gang

### Automatisk oppsett

```bash
git clone <repo-url> ~/machine-setup
cd ~/machine-setup
chmod +x setup.sh
./setup.sh
```

Skriptet vil:
1. Spørre om navn og e-post til Git-konfig
2. Kopiere konfigfiler til riktige steder (med sikkerhetskopiering av eksisterende)
3. Vise neste steg for SSH-oppsett

### Manuelt oppsett

**Git:**
```bash
# Kopier og rediger
cp git/.gitconfig ~/.gitconfig
# Sett inn ditt navn og e-post:
git config --global user.name "Ditt Navn"
git config --global user.email "din@epost.no"
```

**SSH:**
```bash
mkdir -p ~/.ssh
cp ssh/config.example ~/.ssh/config
# Rediger ~/.ssh/config og bytt ut YOUR_SSH_KEY med din faktiske nøkkelfil
```

## Git-aliaser

| Alias | Kommando | Beskrivelse |
|-------|----------|-------------|
| `git st` | `git status` | Vis status |
| `git co <branch>` | `git checkout` | Bytt branch |
| `git cob <navn>` | `git checkout -b` | Lag og bytt til ny branch |
| `git ci` | `git commit` | Commit |
| `git br` | `git branch` | List branches |
| `git lg` | `git log --oneline --graph --decorate` | Kompakt logg med graf |
| `git clean-merged-branches` | — | Slett alle lokale branches som er merget inn (unntatt main/master/develop) |
| `git reset-hard-remote-head` | `git fetch && git reset --hard @{u}` | Tilbakestill til remote HEAD |

## Git-innstillinger

- **Default branch:** `main`
- **Push:** `simple` — pusher bare gjeldende branch
- **Pull:** `rebase = true` — holder historikken lineær
- **Rerere:** aktivert — husker konfliktløsninger for gjenbruk
- **Editor:** IntelliJ IDEA (`idea -w`) — bytt til din foretrukne editor

## SSH-konfigurasjon

`ssh/config.example` setter opp:

- **Alle verter:** automatisk SSH-agent, keep-alive (60s), moderne nøkkeltyper prioritert (ed25519 → ecdsa → rsa)
- **github.com:** bruker `git`-brukeren med din spesifiserte SSH-nøkkel

## Forutsetninger

- Git
- En SSH-nøkkel (generer med `ssh-keygen -t ed25519 -C "din@epost.no"`)
- (Valgfritt) IntelliJ IDEA, om du vil bruke den som Git-editor
