Guide d'installation et d'authentification Git (rapide)

1) Installer Git (Windows)
- Téléchargez l'installateur : https://git-scm.com/download/win et exécutez-le.
- Ou via Chocolatey (PowerShell admin) :
  Set-ExecutionPolicy Bypass -Scope Process -Force
  iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
  choco install git -y

2) Configurer Git
```powershell
git config --global user.name "Votre Nom"
git config --global user.email "votre.email@example.com"
```

3) Authentification GitHub — options
- HTTPS + Personal Access Token (PAT):
  - Créez un PAT sur https://github.com/settings/tokens (scopes `repo`).
  - Lors du `git push`, utilisez votre login GitHub et comme mot de passe le PAT.
- SSH (recommandé):
  - Générer une clé : `ssh-keygen -t ed25519 -C "votre.email@example.com"`
  - Copier la clé publique (`~/.ssh/id_ed25519.pub`) et l'ajouter à https://github.com/settings/keys
  - Tester : `ssh -T git@github.com`

4) Exécuter le script d'initialisation
- Ouvrez PowerShell à la racine du projet et lancez :
```powershell
./push_and_init.ps1
```
Le script initialisera le repo local, créera un commit si nécessaire, ajoutera le remote configuré vers https://github.com/helenaguertin/Portfolio.git et poussera la branche `main`.

Remarques
- Ne partagez jamais votre PAT ou clé privée.
- Si vous préférez, vous pouvez exécuter manuellement les commandes listées dans `README.md`.
