# 07 — Répartition des Charges par Rôles & Feuille de Route (Préparation + 3 Jours)

> **Format retenu** : Équipe de **6 à 8 personnes**, préparation avant le hackathon + **3 jours sur place**.  
> **Stack validée** : Backend **Python (FastAPI)** + Frontend **React** simple + **API LLM (piste Mistral)** + **ChromaDB** + mode **tour par tour avec accélération**.  
> **Répartition ouverte par rôles** (sans noms figés, sauf préférence notée de **Téo** sur *Propagation & Algorithme de recommandation*).

---

## 1. Concrètement, qui fait quoi par composante ? (6 à 8 personnes)

### Rôle 1 — Propagation & Algorithme de Recommandation *(Python — 1 à 2 pers., dont Téo)*
- **Partie 1 : Fabriquer le réseau social (le graphe)**
  - Créer 500 à 2 000 profils fictifs : citoyens normaux, bots, trolls, influenceurs et 1 compte gouvernemental.
  - Définir les liens d'abonnements (*qui suit qui*, par petites communautés).
  - *Exemple simple* : Alice suit 15 amis ; un compte troll est suivi par 40 bots qui partagent tout ce qu'il poste.
- **Partie 2 : L'algorithme de recommandation (« Pour vous »)**
  - Donner une note à chaque post selon : nb de likes/commentaires rapides, ton énervé, et affinité entre communautés.
  - Si la note dépasse un seuil, pousser le post dans le fil de personnes qui ne suivent même pas l'auteur.
- **Partie 3 : Les échanges nœud → nœud & l'avance rapide**
  - À chaque tour, décider qui ignore, partage ou répond, et garder la trace `qui -> qui` pour dessiner les flèches dans React.
  - Permettre de lancer 1 tour ou 5/10 tours d'un coup (`step(turns=5)`).

### Rôle 2 — Agents qui parlent & Analyse du Ton *(Python + API Mistral — 1 à 2 pers.)*
- **Partie 1 : Faire dialoguer les comptes clés**
  - Appeler l'API Mistral avec de petits prompts pour générer les réponses de 10 à 20 comptes importants (un troll, un journaliste, un citoyen inquiet).
  - *Exemple simple* : Après une annonce de l'État, le journaliste demande un lien officiel pendant que le troll crie au mensonge.
- **Partie 2 : Noter le brouillon du joueur (Matrice du Ton)**
  - Avant de publier, noter la réponse sur 3 critères simples : *Clarté factuelle*, *Explication de l'intox (pre-bunking)*, *Ton trop agressif (risque Streisand)*.
- **Partie 3 : Base de preuves (ChromaDB)**
  - Stocker 10 fiches de vrais faits pour que l'IA propose des reformulations appuyées sur des sources fiables.

### Rôle 3 — Serveur Central & Liaison API *(Backend Python FastAPI — 1 pers.)*
- **Partie 1 : Exposer 4 routes claires pour le site**
  - `POST /start` (démarrer un scénario), `POST /test-tone` (noter un brouillon), `POST /reply` (publier une réponse officielle), `POST /step` (avancer de 1 ou N tours).
- **Partie 2 : Mémoire de partie & Comparaison (*What-if*)**
  - Sauvegarder chaque tour pour pouvoir afficher l'historique ou tester une deuxième réponse sur la même crise.
- **Partie 3 : Fluidité**
  - Mettre un petit cache pour que le bouton « Accélérer +5 tours » reste rapide.

### Rôle 4 — Interface Web & Graphe Visuel *(Frontend React — 1 à 2 pers.)*
- **Partie 1 : Fil social simulé**
  - Une colonne façon Twitter/X pour lire les posts qui s'échangent entre agents.
- **Partie 2 : Éditeur de réponse & test de ton**
  - Une zone texte pour rédiger la réponse de crise, un bouton *« Tester le ton »* (affiche 3 jauges + conseils) et un bouton *« Publier »*.
- **Partie 3 : Contrôles du jeu & Graphe animé**
  - Boutons **Tour +1** et **Accélérer (+5 / +10 tours)**.
  - Dessiner les points (agents) et les flèches (bleu = partage entre abonnés, orange = poussé par l'algorithme).

### Rôle 5 — Scénarios de Crise & Scores d'Impact *(Data / Contenu — 1 pers.)*
- **Partie 1 : Écrire les scénarios en JSON**
  - 2 à 3 histoires concrètes (ex. rumeur de taxe, fausse alerte sanitaire) inspirées d'EUvsDiSiNFO, avec des rebondissements aux tours 3, 5, 8.
- **Partie 2 : Calculer des scores faciles à lire**
  - % de citoyens qui croient la rumeur, % qui ont compris la vraie info, et alerte *effet Streisand* (si la réponse de l'État fait exploser la rumeur au lieu de la calmer).

### Rôle 6 — Lancement Facile & Sécurité *(DevOps / Infra — 1 pers.)*
- **Partie 1 : Tout lancer en une commande**
  - Créer un `docker-compose.yml` (React + FastAPI + ChromaDB) et un fichier `.env.example` pour les clés API Mistral.
- **Partie 2 : Filet de sécurité pour la démo**
  - Prévoir un mode cache / démo locale au cas où l'API externe rame pendant la présentation finale.

*(Si l'équipe est de 6 personnes, les rôles 3 + 6 ou 5 + 2 peuvent facilement se regrouper.)*

---

## 2. Planning : Préparation + 3 Jours de Hackathon

### Avant le Hackathon — Préparation
- Se mettre d'accord sur le **format JSON** échangé entre React et FastAPI (un post, un échange `source -> cible`, un tour).
- Écrire le **scénario principal** (ex. rumeur contre le gouvernement) et les 10 fiches de vrais faits.
- Tester la clé **API Mistral** avec un petit script Python de 20 lignes et préparer un dépôt propre (`backend/` Python + `frontend/` React).

### Jour 1 — Faire tourner 1 tour complet
- Graphe simple (ex. 100 comptes) + premier échange de posts en Python.
- Un appel API Mistral qui note un brouillon de texte.
- Page React basique : lire 3 posts, écrire une réponse, cliquer « Tour +1 ».

### Jour 2 — Recommender réaliste, Graphe animé & Accélération
- Algorithme « Pour vous » qui pousse les posts chauds + bouton **Accélérer (+5 tours)**.
- Graphe visuel dans React montrant les flèches organiques vs algorithmiques + jauges d'impact.
- Dialogues générés entre bots, trolls, influenceurs et citoyens.

### Jour 3 — Réglages, Mode Secours & Démo
- Régler les chiffres de propagation pour que la différence entre *réponse agressive (effet Streisand)* et *réponse calme (pre-bunking)* soit flagrante à l'écran.
- Activer le cache de secours pour la démo et préparer le scénario de présentation en 3 minutes.
