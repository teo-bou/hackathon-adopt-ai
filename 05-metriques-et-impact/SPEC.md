# 05 — Métriques d'Impact & Risque (Tableau de Bord)

## 1. Objectif du module
Traduire l'état brut de la simulation multi-agents en indicateurs décisionnels clairs, mis à jour à chaque action de l'utilisateur.

## 2. Spécifications fonctionnelles
- **Score d'atténuation virale (0–100 %)** :
  - Mesure la réduction de la vitesse de propagation et de la portée projetée par rapport au scénario de référence sans intervention.
- **Indice de risque d'effet Streisand (Faible / Modéré / Critique)** :
  - Détecte si une prise de parole expose le narratif manipulateur à une audience jusque-là non atteinte (cross-cluster spillover).
- **Indicateurs complémentaires** :
  - Taux d'audience immunisée (*pre-bunked*) vs exposée.
  - Temps de réactivité de la cellule de crise.
  - Score global de débriefing en fin de scénario avec historique des décisions.

## 3. Contrats d'interface
- Flux de métriques agrégées mis à jour à chaque tour (ou lot de tours en mode accéléré) :
  `{ turn, simulated_time, viral_reach, attenuation_score, streisand_risk, immunized_ratio, decision_log }`
- `GET /api/sessions/{id}/debrief` : bilan complet post-crise pour restitution.

## 4. Rôle assigné
- **Rôle Scores d'Impact & Débriefing** *(1 personne)* :
  - Définir les formules simples du score d'atténuation virale et du risque d'effet Streisand.
  - Agréger les statistiques tour par tour (% touchés par la rumeur vs % informés).
  - Concevoir l'écran de débriefing de fin de partie.
