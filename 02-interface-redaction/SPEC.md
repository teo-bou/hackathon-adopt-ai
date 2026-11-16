# 02 — Interface de Rédaction de Réponse (Frontend)

## 1. Objectif du module
Offrir aux utilisateurs (cellules de crise, communicants, rédactions) un poste de pilotage ergonomique pour lire la menace entrante, rédiger rapidement une réponse adaptée à la plateforme ciblée et visualiser son impact.

## 2. Spécifications fonctionnelles
- **Vue principale type Twitter / X (React simple)** :
  - Barre supérieure avec compteur de tour, boutons **Tour suivant (+1)** et **Accélérer (+5 / +10 tours)**, niveau d'alerte et indicateurs clés.
  - **Colonne fil Twitter/X** : affiche les posts viraux, réponses des bots/trolls/citoyens et permet au joueur de répondre directement comme sur un vrai réseau social.
  - **Éditeur de réponse** : bouton **Tester le ton** (jauges Factuel / Pre-bunking / Risque Streisand + suggestions) et bouton **Publier**.
- **Vue Graphe de propagation (à côté ou juste derrière le fil)** :
  - **Graphe interactif d'échanges et de propagation** : visualisation en direct des transferts de posts d'un nœud à l'autre (arêtes animées/colorées selon diffusion organique entre abonnés vs **poussée par l'algorithme de recommandation**).
  - **Inspecteur de recommandation** : panneau expliquant pourquoi tel post a été poussé dans les fils (score d'engagement précoce, pic de commentaires trolls, affinité).
  - Jauges d'atténuation virale et de risque d'effet Streisand.

## 3. Contrats d'interface & Stack
- **Stack** : React (simple, léger), librairie de graphe (ex. `react-force-graph` ou `cytoscape.js` / Canvas).
- Consomme les APIs `/start`, `/test-tone`, `/reply` et `/step`.

## 4. Rôle assigné
- **Rôle Frontend React & Graphe Visuel** *(1 à 2 personnes)* :
  - Construire la vue type Twitter/X (fil social + zone de réponse avec test de ton).
  - Ajouter les boutons tour par tour / accélération (`+1`, `+5`, `+10 tours`).
  - Intégrer le graphe de propagation animé relié aux événements `source -> target`.
