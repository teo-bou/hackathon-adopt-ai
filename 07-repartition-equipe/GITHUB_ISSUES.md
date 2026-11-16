# Issues GitHub à créer — Simulateur de Crise (Team UTC)

Ces tickets correspondent directement aux 6 composantes et sous-parties du projet (sans noms figés, avec préférence notée de **Téo** sur l'issue #1).

> **Note technique** : La CLI `gh` n'étant pas installée sur cette machine, vous pouvez exécuter le script [create_github_issues.sh](../scripts/create_github_issues.sh) dès que `gh` est installé et connecté (`brew install gh && gh auth login`), ou copier ces issues directement sur GitHub.

---

### Issue 1 — `[Algo & Propagation] Créer le graphe d'agents et le moteur tour par tour`
- **Labels** : `python`, `simulation`, `priorité-haute`
- **Rôle** : Algo & Propagation *(préférence : Téo)*
- **Description** :
  - Construire le graphe d'utilisateurs en Python (citoyens, bots, trolls, influenceurs, compte État).
  - Tracer les échanges de posts `source_node -> target_node`.
  - Exposer `step(turns=1)` et le mode accélération `step(turns=5|10)`.

### Issue 2 — `[Algo & Recommender] Implémenter l'algorithme de recommandation "Pour vous"`
- **Labels** : `python`, `recommender`, `priorité-haute`
- **Rôle** : Algo & Propagation *(préférence : Téo)*
- **Description** :
  - Calculer un score de recommandation selon la vélocité d'engagement précoce, la polarisation émotionnelle et l'affinité de cluster.
  - Injecter les posts viraux hors du cercle des abonnés directs (`channel: "algo_recommendation"`).

### Issue 3 — `[IA & API Mistral] Faire parler les comptes clés et analyser le ton des réponses`
- **Labels** : `python`, `llm`, `mistral`, `rag`
- **Rôle** : IA & Prompts
- **Description** :
  - Intégrer l'API Mistral pour générer les réactions des comptes porte-voix (troll, journaliste, citoyen).
  - Implémenter `POST /test-tone` : scoring *Factuel*, *Pre-bunking*, *Risque Streisand* + suggestions.
  - Indexer 10 fiches de faits officiels dans ChromaDB.

### Issue 4 — `[Backend FastAPI] Créer les routes de jeu, mémoire de partie et cache`
- **Labels** : `python`, `fastapi`, `backend`
- **Rôle** : Backend API Python
- **Description** :
  - Implémenter `/start`, `/test-tone`, `/reply`, `/step` (tour par tour + accélération).
  - Sauvegarder l'historique des tours pour supporter le mode comparatif (*What-if*).
  - Ajouter un cache de réponses IA pour garder les sauts de +5/+10 tours fluides.

### Issue 5 — `[Frontend React] Construire la vue type Twitter/X + graphe animé de propagation`
- **Labels** : `react`, `frontend`, `ui`
- **Rôle** : Frontend React
- **Description** :
  - Vue principale type Twitter/X avec fil de posts en direct et boîte de rédaction.
  - Bouton *Tester le ton* (jauges + conseils) et contrôles **Tour +1** / **Accélérer +5 / +10**.
  - Graphe animé montrant les échanges entre nœuds (bleu = organique, orange = poussé par l'algorithme).

### Issue 6 — `[Scénarios & Données] Rédiger les scénarios EUvsDiSiNFO en JSON et fiches de vérité`
- **Labels** : `data`, `scénarios`
- **Rôle** : Scénarios & Data
- **Description** :
  - Créer le schéma JSON de scénario (rumeur de départ, comptes initiaux, rebondissements aux tours 3, 5, 8).
  - Rédiger 1 scénario phare ciblant le gouvernement (ex. fausse taxe) + 2 scénarios secondaires.

### Issue 7 — `[Métriques] Calculer l'atténuation virale, l'effet Streisand et le débriefing`
- **Labels** : `data`, `métriques`
- **Rôle** : Métriques & Scores
- **Description** :
  - Calculer à chaque tour : portée de la rumeur, % de citoyens informés, indice d'effet Streisand.
  - Générer le bilan comparatif avant/après réponse pour l'écran final.

### Issue 8 — `[DevOps] Mettre en place Docker Compose, .env et mode secours démo`
- **Labels** : `devops`, `docker`, `sécurité`
- **Rôle** : Infra & Sécurité
- **Description** :
  - Créer `docker-compose.yml` (React + FastAPI + ChromaDB) et `.env.example` pour les clés Mistral.
  - Prévoir un mode cache / fallback si le réseau coupe pendant la démo finale.
