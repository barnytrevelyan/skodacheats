# How to create a new brand site from this template

All brand-specific content lives in **one file only**: `config/brand.config.js`  
The shared page code contains zero brand strings — verified by automated grep.

## Steps

### 1. Copy the repo
```bash
git clone https://github.com/barnytrevelyan/ubercheats.git skodacheats
cd skodacheats
git remote set-url origin https://github.com/barnytrevelyan/skodacheats.git
```

### 2. Replace brand.config.js
Edit `config/brand.config.js` with the new brand's content:
- `name` — site name (e.g. "SkodaCheats")
- `targetCompany` — legal entity name (e.g. "Škoda Auto a.s.")
- `targetProduct` — product/service (e.g. "Škoda")
- `domain` — new site URL
- `categories` — complaint types relevant to the brand
- `guide.steps` — escalation steps (chargeback, DVSA, Motor Ombudsman, etc.)
- `legal.cases` — relevant regulatory actions (Dieselgate, VW Group fines, etc.)
- `contacts` — official social media accounts
- `faq` — brand-specific FAQ
- All `meta` titles and descriptions

### 3. Create a new Supabase project
- Go to supabase.com → New project
- Run all SQL migration files in order:
  1. `supabase-setup.sql`
  2. `supabase-migration.sql`
  3. `supabase-migration-multi-currency.sql`
  4. `supabase-auth-migration.sql`
  5. `supabase-directory-migration.sql` (update country/region seed data for new brand)
  6. `supabase-resolve-patch.sql`
- Note your new Project URL, Anon Key, and Service Role Key

### 4. Rename the contacts page (optional)
The contacts page is at `pages/uber-contacts.js` for this brand.
For a new brand, rename it: `mv pages/uber-contacts.js pages/skoda-contacts.js`
Update `BRAND.contactsPageSlug` in the config to match.

### 5. Register a domain and deploy to Vercel
- Create a new Vercel project pointing to your new repo
- Add environment variables:
  ```
  NEXT_PUBLIC_SUPABASE_URL=<new project URL>
  NEXT_PUBLIC_SUPABASE_ANON_KEY=<new anon key>
  SUPABASE_SERVICE_ROLE_KEY=<new service role key>
  NEXT_PUBLIC_SITE_URL=https://www.yournewdomain.com
  ADMIN_EMAIL=your@email.com
  ```
- Connect your domain in Vercel settings

### 6. Verify isolation
Run the brand audit script to confirm zero brand strings leaked:
```bash
grep -rn "Uber\|UberCheats" pages/ components/ --include="*.js" \
  | grep -v "BRAND\.\|import BRAND\|require.*brand"
# Should return: no output
```

## What is brand-specific vs shared

| Brand-specific (in config only) | Shared infrastructure |
|---|---|
| Site name, tagline, domain | Complaint submission form |
| Complaint categories | Case pages & search |
| Guide steps & country tips | Auth (magic link) |
| Legal cases | Admin review page |
| Social media accounts | File uploads |
| FAQ items | Sitemap & robots.txt |
| Hero imagery | SEO/schema structure |
| Email templates | Stats bar |
| All metadata titles | Directory framework |
| Legal disclaimers | Mobile responsive layout |

## Database isolation

Each brand has its own Supabase project. The env vars control which database
is used — there is no shared database, no shared tables, no possible data crossing.
