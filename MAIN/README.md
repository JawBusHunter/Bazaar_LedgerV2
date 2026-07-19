# Bazaar Ledger

Suivi de flips Bazaar Hypixel Skyblock — sync temps réel via Supabase, hébergement sur GitHub Pages.

## 1. Créer le projet Supabase (gratuit)

1. Va sur [supabase.com](https://supabase.com) → **Start your project** → crée un compte si besoin.
2. **New project** → choisis un nom, un mot de passe DB, une région proche de toi.
3. Attends ~2 min que le projet soit prêt.

## 2. Créer la table

1. Dans Supabase : **SQL Editor** → **New query**.
2. Copie-colle tout le contenu de `supabase/schema.sql`.
3. Clique **Run**. Tu dois voir « Success ».

## 3. Récupérer les clés API

1. **Project Settings** (engrenage) → **API**.
2. Note :
   - **Project URL** → `supabaseUrl`
   - **anon public** (clé publique) → `supabaseAnonKey`

> La clé `anon` est faite pour être dans le navigateur. Ne mets **jamais** la clé `service_role` dans le site.

## 4. Configurer le site

Édite `js/config.js` :

```javascript
window.BAZAAR_LEDGER_CONFIG = {
  supabaseUrl: 'https://xxxxx.supabase.co',
  supabaseAnonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',
  roomId: 'mon-groupe-flips'
};
```

- **`roomId`** : identifiant de la « salle » partagée. Toute personne avec le **même** `roomId` voit et modifie les **mêmes** données en direct.
- Pour un groupe d’amis : choisis un `roomId` unique (ex. `skyblock-team-2026`) et partage-le en privé avec eux (dans `config.js` ou en leur disant de le mettre).

## 5. Tester en local

Ouvre `index.html` dans le navigateur (double-clic).  
Le bandeau doit afficher : **Cloud connecté · salle … · sync temps réel active**.

Si tu vois « Cloud non configuré », vérifie `js/config.js`.

## 6. Mettre sur GitHub Pages

```bash
cd Desktop/MAIN
git init
git add .
git commit -m "Bazaar Ledger avec Supabase"
git branch -M main
git remote add origin https://github.com/TON_USER/bazaar-ledger.git
git push -u origin main
```

Sur GitHub : **Settings** → **Pages** → Source : **Deploy from branch** → branche **main**, dossier **/ (root)** → Save.

Le site sera sur : `https://TON_USER.github.io/bazaar-ledger/`

## 7. Partager avec quelqu’un

Envoie-lui :

1. L’URL GitHub Pages du site.
2. Le **`roomId`** si tu ne l’as pas déjà commité dans `config.js` (sinon c’est automatique).

Dès qu’il ouvre le lien, vous voyez les mêmes trades en temps réel.

## Dépannage

| Problème | Solution |
|----------|----------|
| Cloud non configuré | Remplir `js/config.js` |
| Cloud indisponible / permission | Relancer `supabase/schema.sql` |
| Pas de sync temps réel | Supabase → **Database** → **Replication** → activer `ledger_store` |
| CORS / API bloquée | Vérifier l’URL Supabase dans config |

## Fichiers

- `index.html` — application
- `js/config.js` — URL Supabase + roomId
- `supabase/schema.sql` — schéma base de données
