# Script PowerShell pour initialiser le dépôt et pousser vers GitHub.
# Usage: Ouvrir PowerShell dans ce dossier puis `.\
# Script PowerShell pour initialiser le dépôt et pousser vers GitHub.
# Usage: Ouvrir PowerShell dans ce dossier puis `./push_and_init.ps1`

$remote = "https://github.com/helenaguertin/Portfolio.git"

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
	Write-Host "Git n'est pas installé ou non trouvé dans le PATH. Installez Git et relancez le script." -ForegroundColor Yellow
	exit 1
}

# se placer dans le dossier du script
$RepoPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $RepoPath

if (-not (Test-Path ".git")) {
	git init
	Write-Host "Dépôt initialisé."
} else {
	Write-Host "Dossier déjà sous contrôle Git."
}

git add -A

# Vérifier s'il y a des changements à committer
$changes = git status --porcelain
if ($changes) {
	git commit -m "Initial commit"
	Write-Host "Commit créé."
} else {
	Write-Host "Aucun changement à committer."
}

# créer/renommer la branche main
git branch -M main 2>$null

# Ajouter ou mettre à jour le remote
$hasOrigin = git remote | Select-String -Pattern "^origin$"
if (-not $hasOrigin) {
	git remote add origin $remote
	Write-Host "Remote 'origin' ajouté: $remote"
} else {
	git remote set-url origin $remote
	Write-Host "Remote 'origin' mis à jour: $remote"
}

Write-Host "Pushing vers origin/main (vous serez demandé d'authentifier si nécessaire)..."
git push -u origin main