# 04 — Moteur de Simulation Multi-Agents

## 1. Objectif du module
Simuler en temps réel un réseau social complet où des agents autonomes **parlent entre eux** (posts, commentaires, reposts, débats) lors d'une campagne de désinformation, afin de tester plusieurs réponses officielles et voir comment réagit l'écosystème.

## 2. Spécifications fonctionnelles
- **Typologie d'agents (2 000+ agents simulés, mix hybride LLM + règles)** :
  - **Bots coordonnés** : amplification rapide et répétitive dès l'injection d'un narratif.
  - **Usines à trolls** : ciblage des réponses officielles, polarisation et provocation dans les commentaires.
  - **Relais d'influenceurs** : nœuds à fort degré générant des prises de position et des sauts de viralité.
  - **Citoyens / Audience organique** : réactions en langage naturel ou comportemental selon la crédibilité perçue, l'émotion et l'exposition aux contre-discours.
- **Interactions conversationnelles & propagation (Mode Tour par Tour + Accélération)** :
  - Les agents génèrent de vrais fils d'échanges (agents LLM via API pour les profils clés / influenceurs / trolls + agents légers probabilistes en Python pour la masse).
  - **Cadence tour par tour & accélération** : l'utilisateur avance tour par tour (`+1 tour`) pour analyser les échanges et répondre, ou accélère (`+5`, `+10 tours` / échelle temporelle rapide) pour observer l'effet de sa stratégie à moyen terme.
  - Mode **test comparatif ("What-if")** : rejouer ou bifurquer la simulation depuis un tour donné pour comparer l'effet de deux réponses différentes.
  - Modèle à pas discrets (tours) sur un graphe orienté/pondéré (communautés + chambres d'écho) traçant explicitement **chaque échange de post d'un nœud à l'autre** (`source_id -> target_id`, tour, canal).
  - Réaction différenciée selon les scores renvoyés par la Matrice d'Évaluation du Ton (ex. un ton défensif mal calibré augmente la portée via les trolls).
- **Système de Recommandation réaliste ("For You" / Feed algorithmique)** :
  - Modélisation explicite de l'algorithme qui décide quels posts sont **poussés** hors du cercle initial d'abonnés.
  - Score de recommandation calculé à chaque tick selon des signaux réalistes : vélocité d'engagement précoce (likes, réponses, reposts dans les premières minutes), charge émotionnelle / indignation, fraîcheur temporelle et affinité de cluster.
  - Double diffusion visible : **organique (graphe d'abonnements)** vs **algorithmique (posts poussés par le recommender)**, avec explication des facteurs qui ont déclenché le boost.
- **Mécanisme d'échange de posts entre nœuds (Cycle par tick)** :
  1. **Émission (`publish`)** : Un agent (bot, troll, influenceur ou compte gouvernemental) publie un post initial ou une réponse dans un fil.
  2. **Routage double canal (`route`)** :
     - *Canal organique* : le post est poussé dans la file de réception (*inbox/feed*) de tous ses abonnés directs (`source_id -> follower_id`).
     - *Canal algorithmique* : si le `recommendation_score` dépasse le seuil du tick, le recommender injecte le post dans le feed de nœuds **non abonnés** (autres clusters / citoyens indécis).
  3. **Décision du nœud récepteur (`react`)** : Chaque agent destinataire évalue le post selon sa sensibilité, sa confiance institutionnelle et l'historique d'exposition, puis décide d'ignorer, liker, reposter, ou générer une réponse/citation (via LLM pour les profils clés).
  4. **Traçage de l'échange (`emit_event`)** : Chaque transmission réussie émet un événement structuré pour l'animation du graphe et les métriques :
     ```json
     {
       "tick": 14,
       "post_id": "p_948",
       "source_node": "agent_troll_12",
       "target_node": "agent_citoyen_407",
       "channel": "algo_recommendation",
       "action": "repost_with_comment",
       "recommendation_score": 0.87,
       "boost_reasons": ["early_reply_velocity", "high_outrage"]
     }
     ```
- **Flux visuel** :
  - Export de l'état du graphe (nœuds actifs, arêtes de propagation, flux d'événements `source_node -> target_node`, clusters infectés vs immunisés) pour rendu temps réel côté UI.

## 3. Contrats d'interface & Stack
- **Moteur unifié en Python** (FastAPI + NetworkX / NumPy + asyncio pour paralléliser les appels API LLM des agents clés).
- `POST /api/sim/step` avec paramètre `turns` (ex. `turns=1` pour tour par tour, `turns=5` ou `turns=10` pour accélérer la simulation et observer la crise à plus grande échelle temporelle).
- `POST /api/sim/inject-response` : applique la réponse gouvernementale et ses scores de ton sur les probabilités de partage, d'immunisation et de recommandation.

## 4. Rôle assigné
- **Rôle Propagation & Algorithme de Recommandation** *(1 à 2 personnes — préférence notée : Téo)* :
  - Créer le graphe d'agents en Python (NetworkX / NumPy) : citoyens, bots, trolls, influenceurs, compte État.
  - Implémenter l'algorithme de recommandation (*For You* vs *Following*) et le traçage `source_node -> target_node`.
  - Gérer le mode tour par tour et l'accélération (`turns=1`, `turns=5`, `turns=10`).
  - Coupler la réaction des agents aux scores de la Matrice de Ton et aux dialogues générés par l'API Mistral.
