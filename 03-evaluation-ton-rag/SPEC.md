# 03 — Matrice d'Évaluation du Ton (LLM & RAG)

## 1. Objectif du module
Permettre à l'utilisateur de tester et d'ajuster sa réponse *avant* publication grâce à une analyse comparative LLM + RAG évaluant la posture communicationnelle et l'ancrage factuel.

## 2. Spécifications fonctionnelles
- **Classification & scoring du ton** sur 3 axes principaux :
  1. **Posture factuelle** : clarté des preuves, neutralité, absence d'agressivité.
  2. **Pre-bunking / Inoculation** : capacité à exposer le mécanisme manipulateur sans renforcer le mythe.
  3. **Posture défensive / Risque Streisand** : risque de légitimer ou d'amplifier une rumeur mineure par sur-réaction.
- **Pipeline RAG souverain (API LLM + Vector Store)** :
  - Appels **API LLM souveraine** (piste **Mistral API** ou équivalent à confirmer) sans besoin de GPU local.
  - Indexation de fiches factuelles et de bonnes pratiques de communication de crise (**ChromaDB** en Python).
  - Récupération des contre-arguments vérifiés pertinents pour le scénario actif.
- **Sortie structurée** :
  - Scores normalisés (0–100) par posture.
  - Alertes ciblées (ex. *"Évitez de répéter le mot-clé viral en titre"*).
  - 2 à 3 suggestions de reformulation adaptées à la plateforme choisie.

## 3. Contrats d'interface
- `POST /api/tone/evaluate`
  - **Entrée** : `{ scenario_id, platform, draft_text, current_viral_stage }`
  - **Sortie** : `{ scores: { factual, prebunking, defensive_risk }, streisand_warning, sources: [...], suggestions: [...] }`

## 4. Rôle assigné
- **Rôle IA : Agents qui parlent & Analyse du Ton** *(1 à 2 personnes)* :
  - Mettre en place **Python + ChromaDB + client API LLM (Mistral)**.
  - Écrire les prompts pour faire parler les profils clés (troll, journaliste, citoyen) et noter le brouillon du joueur (Factuel, Pre-bunking, risque Streisand).
  - Construire une petite base de fiches de vérité dans ChromaDB pour suggérer des reformulations sourcées.
