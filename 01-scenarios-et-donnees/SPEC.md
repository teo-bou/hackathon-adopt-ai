# 01 — Scénarios Réalistes & Données de Crise

## 1. Objectif du module
Alimenter le simulateur avec des scénarios réalistes et chronométrés, modélisés à partir de cas documentés (type **EUvsDiSiNFO**), et injecter dynamiquement de nouveaux rebondissements pendant la session d'entraînement.

## 2. Spécifications fonctionnelles
- **Catalogue de scénarios** : au moins 3 scénarios prêts pour la démo (ex. rumeur électorale, manipulation sanitaire/scientifique, fausse alerte institutionnelle).
- **Chronomètre de crise** :
  - Gestion de phases temporelles (T0 alerte, T+15min accélération, T+30min pic médiatique).
  - Déclenchement d'événements scriptés ou conditionnels selon l'inaction ou la réponse du joueur.
- **Flux d'injections** : posts viraux simulés, captures/articles sources, signaux faibles à qualifier par l'utilisateur.
- **Format structuré (JSON/YAML)** : métadonnées du narratif, acteurs initiaux, niveau de menace, corpus de preuves associées.

## 3. Contrats d'interface
- `GET /api/scenarios` : liste des scénarios disponibles.
- `POST /api/sessions` : démarre une session chronométrée avec état initial du graphe et des métriques.
- Flux temps réel (WebSocket / SSE) vers le frontend pour pousser les nouveaux événements de crise.

## 4. Rôle assigné
- **Rôle Scénarios & Données** *(1 personne)* :
  - Collecter et nettoyer des cas inspirés d'EUvsDiSiNFO.
  - Définir le schéma JSON des scénarios et rédiger 2 à 3 scénarios complets avec rebondissements par tour.
  - Préparer les fiches de faits officiels utilisées par l'IA.
