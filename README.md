# NetApp Scripts Repository

Bienvenue dans le repository NetApp Scripts ! 🚀

Ce repository contient une collection de scripts PowerShell et autres outils utiles pour gérer et automatiser les tâches liées aux baies de stockage NetApp.

## Table des Matières

- [À propos](#à-propos)
- [Scripts Disponibles](#scripts-disponibles)
- [Prérequis](#prérequis)
- [Installation](#installation)
- [Utilisation](#utilisation)
- [Contribuer](#contribuer)
- [Licence](#licence)

## À propos

Ce repository a été créé pour centraliser et partager des scripts utiles pour l'administration des baies NetApp. Que vous soyez un administrateur système ou un ingénieur stockage, vous trouverez ici des outils pour faciliter votre travail quotidien.

## Scripts Disponibles

- **Remove-OldAntiRansomwareSnapshots.ps1** : Script PowerShell pour supprimer les snapshots anti-ransomware vieux de plus de 15 jours.

D'autres scripts seront ajoutés au fur et à mesure. Restez à l'écoute ! 📡

## Prérequis

Avant d'utiliser les scripts de ce repository, assurez-vous d'avoir les éléments suivants :

- PowerShell installé sur votre machine.
- Le module NetApp PowerShell Toolkit installé et configuré.
- Les permissions nécessaires pour exécuter des commandes sur vos baies NetApp.

## Installation

1. Clonez ce repository sur votre machine locale :
    ```bash
    git clone https://github.com/votre_nom_utilisateur/netapp-scripts.git
    ```

2. Accédez au répertoire cloné :
    ```bash
    cd netapp-scripts
    ```

3. Installez le module NetApp PowerShell Toolkit si ce n'est pas déjà fait :
    ```powershell
    Install-Module -Name DataONTAP
    ```

## Utilisation

Chaque script est accompagné de sa propre documentation et de ses instructions d'utilisation. Reportez-vous aux commentaires dans les scripts pour plus de détails.

Par exemple, pour exécuter le script `Remove-OldAntiRansomwareSnapshots.ps1` :
```powershell
.\Remove-OldAntiRansomwareSnapshots.ps1
