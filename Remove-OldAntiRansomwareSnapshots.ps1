# Importer le module NetApp PowerShell Toolkit
Import-Module DataONTAP

# Informations de connexion
$NetAppCluster = "adresse_ip_ou_nom_de_la_baie"
$Username = "votre_nom_utilisateur"
$Password = "votre_mot_de_passe"

# Convertir le mot de passe en SecureString
$SecurePassword = ConvertTo-SecureString -String $Password -AsPlainText -Force

# Créer les informations d'identification
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Username, $SecurePassword

# Se connecter à la baie NetApp
Connect-NcController -Name $NetAppCluster -Credential $Credential

# Définir la date limite pour les snapshots à supprimer (plus de 15 jours)
$DateLimit = (Get-Date).AddDays(-15)

# Récupérer tous les volumes
$Volumes = Get-NcVol

foreach ($Volume in $Volumes) {
    # Récupérer tous les snapshots pour chaque volume
    $Snapshots = Get-NcSnapshot -Volume $Volume.Name

    foreach ($Snapshot in $Snapshots) {
        # Vérifier si le snapshot est un snapshot anti-ransomware et s'il est plus ancien que la date limite
        if ($Snapshot.Name -like "*antiransomware*" -and $Snapshot.Created -lt $DateLimit) {
            # Supprimer le snapshot
            Remove-NcSnapshot -Volume $Volume.Name -Snapshot $Snapshot.Name -Confirm:$false
            Write-Host "Snapshot $($Snapshot.Name) sur le volume $($Volume.Name) a été supprimé."
        }
    }
}

# Se déconnecter de la baie NetApp
Disconnect-NcController -Name $NetAppCluster

Write-Host "Opération terminée."
