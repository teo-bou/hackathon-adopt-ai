# 00 — Cadrage, Utilisateurs Cibles & Hypothèses du Projet

Ce document recense l'ensemble des hypothèses prises pour cadrer le **Simulateur de Crise Stratégique** (Team UTC — Hackathon Adopt AI). Chaque point marqué *"À valider"* est ouvert à discussion avec l'équipe.

---

## 1. Utilisateurs Finaux & Cas d'Usage
- **Cible principale** : **Acteurs gouvernementaux et institutionnels** (cellules de crise ministérielles, Services d'Information du Gouvernement, porte-paroles, chargés de communication publique).
- **Scénario type** : Une campagne coordonnée de *fake news* cible directement le gouvernement ou une institution publique (ex. fausse réforme, manipulation sanitaire, rumeur sur un service public ou un scrutin).
- **Objectif de l'outil** : Permettre à l'équipe de crise de s'entraîner en conditions réalistes — observer comment la rumeur circule entre des agents sociaux, tester plusieurs réponses possibles, évaluer leur ton avant publication et mesurer l'impact sur la propagation.

---

## 2. Hypothèses sur la Simulation Multi-Agents
- **Modèle hybride (LLM API + règles sur graphe)** *(validé sur le principe, à affiner)* :
  - Faire dialoguer 2 000 agents uniquement via un LLM serait trop lent et coûteux.
  - **Hypothèse** : Un noyau de **15 à 30 agents "porte-voix"** (influenceurs, médias, comptes trolls, porte-paroles citoyens) génère de vrais posts/réponses via API LLM, tandis que le graphe complet (plusieurs centaines à 2 000+ nœuds en Python) simule la propagation et les réactions statistiques.
- **Plateforme simulée** *(à valider)* :
  - Modélisation inspirée d'un fil type **X / Twitter** (posts courts, citations, reposts, hashtags, réponses en thread) éventuellement complétée par un encart **communiqué officiel**.
- **Système de Recommandation réaliste** *(à valider)* :
  - Chaque agent possède un fil hybride : posts de ses abonnements directs (*Following*) + posts poussés par l'algorithme (*For You*).
  - **Formule de poussée algorithmique** : `Score = f(vélocité_engagement, taux_réponses_polarisantes, fraîcheur, affinité_graphe)`. Cela permet de montrer concrètement comment une armée de bots ou une réponse gouvernementale trop défensive (qui attire des commentaires hostiles) se fait artificiellement **pousser** par l'algorithme dans le graphe.
- **Mode de temps : Tour par tour avec accélération** *(validé)* :
  - Simulation **tour par tour** (*turn-based*) : l'utilisateur observe l'état de la crise, rédige ou ajuste sa réponse, puis déclenche le tour suivant.
  - **Accélération d'échelle temporelle** : possibilité d'avancer par sauts (`+1 tour`, `+5 tours`, `+10 tours` / *fast-forward*) pour tester rapidement l'évolution de la crise sur plusieurs heures ou jours simulés.

---

## 3. Hypothèses sur la Stack Technique
- **Frontend** : **React** (interface volontairement simple et lisible : fil social, éditeur de réponse, contrôles de tour/accélération, graphe réseau).
- **Backend unifié** : **Python (FastAPI)** regroupant l'orchestrateur de scénarios, le moteur multi-agents, le système de recommandation et les endpoints REST/WebSocket (architecture monorepo simple à intégrer en hackathon).
- **IA & RAG via API Souveraine** *(piste Mistral privilégiée, à confirmer)* :
  - Appels **API LLM** (ex. **API Mistral** pour la composante souveraine européenne) pour le dialogue entre agents clés et la Matrice d'Évaluation du Ton.
  - **ChromaDB** en Python pour le corpus factuel (EUvsDiSiNFO, fiches institutionnelles) + cache de réponses pour maîtriser latence et coûts.
- **Déploiement** : Conteneurisation via **Docker Compose** pour un lancement reproductible.

---

## 4. Hypothèses sur l'Évaluation & les Métriques
- **Matrice du ton** : Évaluation selon 3 axes — *Factuel*, *Pre-bunking / Inoculation*, *Défensif* — avec détection explicite du **risque d'effet Streisand** (amplification involontaire d'une rumeur encore confidentielle).
- **Score d'atténuation virale** : Comparaison entre la trajectoire observée et la courbe de référence sans intervention officielle.
- **Données de démo** : 1 scénario principal très poussé (fake news visant le gouvernement) + 2 scénarios secondaires prêts en JSON.

---

## 5. Hypothèses Hors Périmètre (V1 Hackathon)
- Pas de connexion directe aux APIs réelles de X, TikTok ou Meta (simulation en vase clos sécurisé).
- Pas d'authentification multi-comptes complexe (accès direct au cockpit pour la démo).
- Pas de génération vidéo/deepfake en temps réel (texte, métadonnées visuelles simulées et liens factices).
