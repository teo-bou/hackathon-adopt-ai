# Simulateur de Crise sur les Réseaux Sociaux

## C'est quoi le projet, en très simple ?

Imaginez un **jeu de simulation** pour des **équipes du gouvernement** (ministères, porte-paroles, cellules de crise).

Une **fausse information (fake news)** démarre sur un faux réseau social (un peu comme X/Twitter). Dans cette simulation, des **centaines de comptes virtuels** (des citoyens, des influenceurs, des trolls et des bots) **se parlent entre eux** et se partagent des messages. Un **algorithme de recommandation** décide quels messages deviennent viraux.

Le but du joueur ? **Tester comment réagir** pour calmer la crise, tour après tour, sans empirer la situation !

---

## Exemple concret d'une partie

> **Scénario** : *« Le gouvernement va taxer les livrets A dès lundi ! »*
>
> - **Tour 1 (Début de crise)** : 3 comptes trolls lancent la rumeur avec un faux document. Quelques citoyens doutent, d'autres s'énervent.
> - **Tour 2 (L'algorithme s'emballe)** : Comme les gens se disputent en commentaires, l'algorithme trouve le post « intéressant » et le pousse à 500 nouveaux comptes.
> - **Votre action** : Vous écrivez une réponse officielle dans l'outil. Avant de publier, l'IA teste votre ton :
>   - *Mauvaise idée* : « C'est totalement faux, arrêtez de relayer n'importe quoi ! » → Ton trop agressif, risque d'**effet Streisand** (tout le monde va en parler encore plus).
>   - *Bonne idée* : « Aucune taxe n'est prévue sur le livret A. Voici comment repérer le faux document qui circule (lien officiel). » → Ton calme et clair.
> - **Tour 3 → Tour 8 (Bouton « Accélérer »)** : On avance vite de 5 tours. On voit sur le graphe que la vraie explication circule mieux et que la rumeur s'essouffle !

---

## Les 6 composantes concrètes (quoi coder et comment)

| Composante | Ce qu'il faut faire concrètement | Exemple simple |
| :--- | :--- | :--- |
| **1. Propagation & Algo de Recommandation (Python)** *(piste : Téo)* | Créer le graphe d'utilisateurs, coder l'algo « Pour vous » qui pousse les posts populaires, et gérer les tours (`+1`, `+5`). | Si 10 bots commentent vite une rumeur, l'algo la pousse à 200 citoyens qui ne suivaient pas l'auteur. |
| **2. Agents qui parlent & Ton (Python + API Mistral)** | Faire répondre les comptes clés (troll, journaliste, citoyen) via l'API Mistral et noter le brouillon du joueur avant publication. | « Arrêtez ces mensonges ! » → note défensive élevée (alerte Streisand) + suggestion de réponse calme. |
| **3. Serveur Central (Python FastAPI)** | Créer 4 routes simples (`/start`, `/test-tone`, `/reply`, `/step`), garder la mémoire de la partie et cacher les appels lents. | React demande `+5 tours` → FastAPI fait tourner la simulation 5 fois et renvoie les nouveaux messages. |
| **4. Interface Web & Graphe (React)** | Afficher le fil de messages, la boîte de rédaction, les boutons tour par tour / accélération et le dessin du graphe animé. | Le joueur voit en bleu les partages entre amis et en orange les posts poussés par l'algorithme. |
| **5. Scénarios & Scores d'Impact (JSON / Data)** | Écrire 2–3 scénarios de fake news avec rebondissements, et compter combien de citoyens croient encore à la rumeur. | Si les vues doublent après la réponse officielle → alerte rouge Streisand. |
| **6. Lancement & Sécurité (Docker)** | Mettre React + FastAPI + ChromaDB dans un `docker-compose.yml` et protéger les clés API dans `.env`. | Taper `docker compose up` pour lancer tout le projet sur n'importe quel PC de l'équipe. |

---

## Organisation du travail (Prépa + 3 jours, équipe de 6 à 8)

Plutôt que de figer des noms partout, chaque membre choisit un rôle selon ses envies (**Python / IA / Algo**, **Frontend React**, **Data / Scénarios**, **Infra / DevOps**).  
*(Seule préférence notée : **Téo** sur la partie **Propagation & Algorithme de recommandation** en Python.)*

Le découpage complet en sous-tâches simples et le planning **Préparation + Jour 1 / 2 / 3** sont détaillés dans [07-repartition-equipe/TASKS.md](07-repartition-equipe/TASKS.md).

---

## Documentation détaillée (dans les dossiers)

| Dossier / Page | Contenu |
| :--- | :--- |
| [site/architecture.html](site/architecture.html) | **Page HTML animée** : composantes, simulateur de graphe en direct et exemples simples |
| [site/index.html](site/index.html) | Site HTML récapitulatif du projet |
| [00-cadrage-et-hypotheses](00-cadrage-et-hypotheses/HYPOTHESES.md) | Cible gouvernementale et toutes les hypothèses du projet |
| [01-scenarios-et-donnees](01-scenarios-et-donnees/SPEC.md) | Scénarios de crise, chronologie et format des données |
| [02-interface-redaction](02-interface-redaction/SPEC.md) | Écrans React, éditeur de réponse et graphe visuel |
| [03-evaluation-ton-rag](03-evaluation-ton-rag/SPEC.md) | Matrice de ton, API Mistral et base de faits RAG |
| [04-simulation-multi-agents](04-simulation-multi-agents/SPEC.md) | Échanges entre nœuds, algo de recommandation et tour par tour |
| [05-metriques-et-impact](05-metriques-et-impact/SPEC.md) | Score d'atténuation virale, effet Streisand et débriefing |
| [06-infra-devops-securite](06-infra-devops-securite/SPEC.md) | Architecture Python/React, Docker et sécurité |
| [07-repartition-equipe](07-repartition-equipe/TASKS.md) | Répartition des charges par rôles (prépa + Jour 1, 2, 3) |
| [Issues GitHub prêtes à créer](07-repartition-equipe/GITHUB_ISSUES.md) | 8 tickets prêts pour GitHub + script [create_github_issues.sh](scripts/create_github_issues.sh) |
