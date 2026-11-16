#!/usr/bin/env bash
set -euo pipefail

# Prérequis : brew install gh && gh auth login
# Utilisation : ./scripts/create_github_issues.sh

REPO="teo-bou/hackathon-adopt-ai"

gh issue create --repo "$REPO" \
  --title "[Algo & Propagation] Créer le graphe d'agents et le moteur tour par tour" \
  --body "Construire le graphe d'utilisateurs en Python (citoyens, bots, trolls, influenceurs, compte État), tracer les échanges source -> cible, et exposer step(turns=1|5|10). (Préférence notée : Téo)"

gh issue create --repo "$REPO" \
  --title "[Algo & Recommender] Implémenter l'algorithme de recommandation Pour vous" \
  --body "Calculer un score de recommandation selon la vélocité précoce, la polarisation émotionnelle et l'affinité de cluster pour pousser les posts hors du cercle d'abonnés directs. (Préférence notée : Téo)"

gh issue create --repo "$REPO" \
  --title "[IA & API Mistral] Faire parler les comptes clés et analyser le ton des réponses" \
  --body "Intégrer l'API Mistral pour les réactions des comptes porte-voix, implémenter POST /test-tone (Factuel, Pre-bunking, Risque Streisand) et indexer 10 fiches officielles dans ChromaDB."

gh issue create --repo "$REPO" \
  --title "[Backend FastAPI] Créer les routes de jeu, mémoire de partie et cache" \
  --body "Implémenter /start, /test-tone, /reply, /step (tour par tour + accélération), sauvegarder l'historique pour le mode What-if et cacher les réponses IA."

gh issue create --repo "$REPO" \
  --title "[Frontend React] Construire la vue type Twitter/X et le graphe animé" \
  --body "Créer la vue type Twitter/X (fil social + boîte de réponse avec test de ton), les boutons Tour +1 / Accélérer +5/+10 et le graphe animé des propagations (organique vs algo)."

gh issue create --repo "$REPO" \
  --title "[Scénarios & Données] Rédiger les scénarios EUvsDiSiNFO en JSON" \
  --body "Définir le schéma JSON de scénario avec rebondissements par tour et rédiger 1 scénario gouvernemental phare + 2 scénarios secondaires."

gh issue create --repo "$REPO" \
  --title "[Métriques] Calculer atténuation virale, effet Streisand et débriefing" \
  --body "Calculer à chaque tour la portée de la rumeur, le % de citoyens informés, l'indice d'effet Streisand et générer le bilan final."

gh issue create --repo "$REPO" \
  --title "[DevOps] Mettre en place Docker Compose, .env et mode secours démo" \
  --body "Créer docker-compose.yml (React + FastAPI + ChromaDB), .env.example pour les clés Mistral et un mode fallback pour sécuriser la démo."

echo "Toutes les issues ont été créées sur $REPO !"
