rom netapp_ontap import config, HostConnection
from netapp_ontap.resources import Volume, Snapshot
from datetime import datetime, timedelta
import requests
from requests.auth import HTTPBasicAuth
import urllib3

# Informations de connexion
netapp_host = "192.168.0.101"
username = "admin"
password = "Netapp1!"

# URL de base pour les appels API
base_url = f"https://{netapp_host}/api"

# Configurer la connexion à la baie NetApp
config.CONNECTION = HostConnection(
    host=netapp_host,
    username=username,
    password=password,
    verify=False  # Changez à True si vous utilisez des certificats SSL
)

def clear_suspect_files(volume_uuid):
    try:
        url = f"{base_url}/security/anti-ransomware/suspects/{volume_uuid}"
        print(f"Appel API pour supprimer les fichiers suspects sur le volume {volume_uuid}...")

        payload = {
            "is_false_positive": True
        }

        response = requests.delete(
            url,
            auth=HTTPBasicAuth(username, password),
            json=payload,
            verify=False  # Changez à True si vous utilisez des certificats SSL
        )

        if response.status_code == 200:
            print(f"Fichiers suspects sur le volume {volume_uuid} ont été supprimés avec succès.")
        else:
            print(f"Échec de la suppression des fichiers suspects sur le volume {volume_uuid}. Code de statut: {response.status_code}")
            print(f"Réponse: {response.text}")
    except Exception as e:
        print(f"Une erreur s'est produite lors de la suppression des fichiers suspects sur le volume {volume_uuid}: {e}")


def main():
    try:
        print("Connexion à la baie NetApp...")
        # Récupérer tous les volumes
        volumes = Volume.get_collection()
        print("Volumes récupérés avec succès.")

        for volume in volumes:
            print(f"Traitement du volume: {volume.name}")
            volume.get()  # Récupérer les détails du volume
            print(f"Détails du volume {volume.name} récupérés.")
            volume_uuid = volume['uuid']
            print(f"L'uuid du volume est {volume_uuid}")
            # Suppression des fichiers suspects sur le volume
            clear_suspect_files(volume_uuid)

            # Récupérer tous les snapshots pour chaque volume
            snapshots = Snapshot.get_collection(volume.uuid)
            print(f"Snapshots pour le volume {volume.name} récupérés.")

            for snapshot in snapshots:
                snapshot.get()  # Récupérer les détails du snapshot
                print(f"Traitement du snapshot: {snapshot.name}")

                # Vérifier si le nom du snapshot contient "Anti-ransomware" en utilisant find
                if snapshot.name.find("Anti_ransomware") != -1:
                    print(f"Snapshot {snapshot.name} identifié pour suppression.")
                    # Supprimer le snapshot avec force
                    snapshot.delete()
                    print(f"Snapshot {snapshot.name} sur le volume {volume.name} a été supprimé.")
                else:
                    print(f"Snapshot {snapshot.name} ne correspond pas aux critères de suppression.")
    except Exception as e:
        print(f"Une erreur s'est produite : {e}")

if __name__ == "__main__":
    main()