# Application de Traduction et Correction

## Description

Cette application Flutter offre des fonctionnalités de traduction et de correction de texte, utilisant l'API Groq pour des résultats précis. Elle permet aux utilisateurs de traduire du texte dans plusieurs langues, de corriger des erreurs grammaticales et orthographiques, et d'écouter les traductions grâce à la synthèse vocale.

## Fonctionnalités

- Traduction de texte vers plusieurs langues (Anglais, Français, Espagnol, Allemand, Italien)
- Correction grammaticale et orthographique
- Synthèse vocale pour écouter les traductions
- Historique des traductions
- Interface utilisateur intuitive et responsive

## Prérequis

- Flutter (version 2.0 ou supérieure)
- Dart (version 2.12 ou supérieure)
- Un compte Groq avec une clé API valide

## Installation

1. Clonez ce dépôt :

   ```
   git clone https://github.com/votre-nom-utilisateur/nom-du-repo.git
   ```

2. Naviguez dans le répertoire du projet :

   ```
   cd nom-du-repo
   ```

3. Installez les dépendances :

   ```
   flutter pub get
   ```

4. Configurez votre clé API Groq :

   - Ouvrez le fichier `lib/services/translation_service.dart`
   - Remplacez `'VOTRE_CLE_API_GROQ'` par votre véritable clé API Groq

5. Lancez l'application :
   ```
   flutter run
   ```

## Structure du Projet

- `lib/`
  - `main.dart` : Point d'entrée de l'application
  - `screens/`
    - `home_screen.dart` : Écran principal avec les fonctionnalités de traduction et correction
    - `history_screen.dart` : Écran affichant l'historique des traductions
    - `language_selection_screen.dart` : Écran de sélection de la langue
  - `services/`
    - `translation_service.dart` : Service gérant les appels à l'API de traduction
    - `correction_service.dart` : Service gérant les corrections de texte
    - `storage_service.dart` : Service pour la gestion du stockage local
  - `models/`
    - `translation.dart` : Modèle de données pour les traductions
  - `utils/`
    - `constants.dart` : Constantes utilisées dans l'application

## Utilisation

1. Au lancement, sélectionnez la langue cible pour la traduction.
2. Sur l'écran principal, entrez le texte à traduire ou à corriger.
3. Utilisez les boutons "Traduire" ou "Corriger" selon vos besoins.
4. Pour écouter la traduction, appuyez sur "Écouter la traduction".
5. Accédez à l'historique des traductions via l'icône en haut à droite.

## Dépendances Principales

- `http`: Pour les requêtes API
- `shared_preferences`: Pour le stockage local des données
- `flutter_tts`: Pour la fonctionnalité de synthèse vocale
- `logger`: Pour le logging avancé

## Contribution

Les contributions sont les bienvenues ! Pour contribuer :

1. Forkez le projet
2. Créez votre branche de fonctionnalité (`git checkout -b feature/AmazingFeature`)
3. Committez vos changements (`git commit -m 'Add some AmazingFeature'`)
4. Poussez vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrez une Pull Request

## Licence

Ce projet est sous licence MIT. Voir le fichier `LICENSE` pour plus de détails.

## Contact

Votre Nom - [@votretwitter](https://twitter.com/votretwitter) - email@example.com

Lien du projet : [https://github.com/votre-nom-utilisateur/nom-du-repo](https://github.com/votre-nom-utilisateur/nom-du-repo)

## Remerciements

- [Flutter](https://flutter.dev)
- [Groq API](https://groq.com)
- Tous les contributeurs qui ont participé à ce projet
