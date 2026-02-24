#!/bin/bash

# Mettre à jour la liste des paquets
sudo apt update

# Installer figlet
sudo apt install -y figlet

# Vérifier si l'installation a réussi
if command -v figlet &> /dev/null; then
    echo "Figlet a été installé avec succès."

    # Générer quelques exemples d'art ASCII
echo "Exemple 1:"
figlet "Hello World"

echo "Exemple 2:"
figlet -f slant "ASCII Art"

echo "Exemple 3:"
figlet -f block "Bash Script"

echo "Exemple 4:"
figlet -f digital "Ubuntu"
else
    echo "Échec de l'installation de figlet."
fi