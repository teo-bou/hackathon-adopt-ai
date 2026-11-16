# 06 — Architecture Technique, DevOps & Sécurité

## 1. Objectif du module
Garantir une architecture modulaire, reproductible en local comme sur le cloud, résiliente pendant les démos du hackathon et conforme aux exigences de souveraineté.

## 2. Spécifications techniques
- **Architecture globale (simple et modulaire)** :
  - **Frontend** : **React** (interface épurée : fil social, éditeur de réponse, contrôles tour par tour / accélération, graphe de propagation).
  - **Backend unifié** : **Python (FastAPI)** hébergeant l'API REST, l'orchestrateur tour par tour, le moteur multi-agents + système de recommandation et le module RAG.
  - **IA / RAG** : Appels **API LLM souveraine** (piste **Mistral API**) + **ChromaDB** pour le corpus factuel.
- **Conteneurisation & Déploiement** :
  - `docker-compose.yml` unifié (Frontend React + Backend FastAPI + ChromaDB) pour lancer toute la stack en une commande.
  - Pipeline CI/CD (lint, tests unitaires, build images).
- **Sécurité & Résilience** :
  - Isolation des clés API (`.env`), validation stricte des entrées utilisateur, rate-limiting sur les endpoints LLM, cache de réponses pour sécuriser les accélérations multi-tours et la démo live.

## 3. Rôles assignés
- **Rôle Backend FastAPI** *(1 personne)* :
  - Structurer le backend Python FastAPI et exposer les routes (`/start`, `/test-tone`, `/reply`, `/step`) + sauvegarde de partie.
  - Mettre en place un cache pour garder l'accélération multi-tours fluide.
- **Rôle Infra / Docker & Sécurité** *(1 personne)* :
  - Préparer `docker-compose.yml` (React + FastAPI + ChromaDB), `.env.example` pour les clés Mistral et un mode secours démo.
