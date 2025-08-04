# Informations de connexion
$NetAppCluster = "192.168.0.101"
$Username = "admin"
$Password = "Netapp1!"
$domain = "DEMO"
$dnsdomain = "demo.netapp.com"
$domainadmin = "Administrator@"+$domain

# Convertir le mot de passe en SecureString
$SecurePassword = ConvertTo-SecureString -String $Password -AsPlainText -Force

# Créer les informations d'identification
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Username, $SecurePassword

# Se connecter à la baie NetApp
Connect-NcController -Name $NetAppCluster -Credential $Credential

#Récuper la version de la baie
$Systver = Get-NcSystemVersion

if ($Systver.Version -like "*9.16.1*" ) {
    Invoke-Ncssh "options -option-name arw.snap.retain.hours.after.clear.suspect.false.alert -option-value 4"
    Write-Host " Passage de la suppression du snap antiransomware apres faux positif à 4h"
}

# Récupérer tous les volumes
$Volumes = Get-NcVol

foreach ($Volume in $Volumes) {
    
# Si le volume a Antiransomware d'activé et n'est pas un volume root alors supprime l'alerte Antiransomware
   Invoke-Ncssh "set -privilege diag -confirmations off; anti-ransomware volume attack clear-suspect -vserver $($Volume.vserver) -volume $($Volume.Name) -false-positive true"
  
}

Write-Host "Operation terminee."