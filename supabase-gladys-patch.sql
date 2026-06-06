-- ============================================================
-- Patch: Kenya accuracy update + Gladys payment gateway
-- Run AFTER supabase-directory-migration.sql
-- ============================================================

-- 1. Add "last_verified_note" column so entries can carry a freshness note
ALTER TABLE directory_entries ADD COLUMN IF NOT EXISTS last_verified_note TEXT;

-- 2. Add Gladys as Kenya's primary payment gateway
--    Source: joingladys.com — CBK-regulated PSP, banking via Diamond Trust Bank
INSERT INTO directory_entries
  (country_id, section, role_or_type, name, notes, contact_url, source_url, verified, display_order, last_verified_note)
VALUES (
  (SELECT id FROM countries WHERE slug='kenya'),
  'payment_partner',
  'Primary Payment Gateway',
  'Gladys',
  'Gladys is the Payment Service Provider (PSP) that processes Uber Eats Kenya transactions. It is licensed and regulated by the Central Bank of Kenya, with banking services provided by Diamond Trust Bank (a tier-1 CBK-regulated bank). '
  'To dispute a charge: contact Gladys directly at support@joingladys.com or help@joingladys.com, or call +254 798 696421. '
  'Provide your transaction reference number. As a CBK-regulated PSP, Gladys is obligated to investigate and respond to merchant payment disputes.',
  'https://joingladys.com',
  'https://joingladys.com',
  true,
  0,  -- display first among payment partners
  'Verified June 2026 via joingladys.com'
);

-- 3. Update the existing M-Pesa entry to clarify it routes through Gladys
UPDATE directory_entries
SET notes = 'M-Pesa payments in the Uber Eats Kenya app are routed through Gladys (the platform''s CBK-regulated PSP). '
            'If Uber does not refund: (a) First contact Gladys at support@joingladys.com — as the PSP they can trace and reverse the transaction. '
            '(b) Also call Safaricom M-Pesa on 0722 000 100 and raise a merchant dispute using your M-Pesa transaction code (format: SL7XXXXXXX or similar). '
            'Safaricom and Gladys are jointly able to trace the payment end-to-end.',
    last_verified_note = 'Updated June 2026 — Gladys confirmed as PSP'
WHERE country_id = (SELECT id FROM countries WHERE slug='kenya')
  AND section = 'payment_partner'
  AND name = 'M-Pesa (Safaricom)';

-- 4. Add accuracy/verification notes to Kenya executive entries
--    Executive roles change — always verify on LinkedIn before contacting
UPDATE directory_entries
SET last_verified_note = 'Role verified via public announcements — confirm current title on LinkedIn before use',
    notes = notes || ' Note: executive roles change periodically. Verify this person''s current title on LinkedIn before reaching out.'
WHERE country_id = (SELECT id FROM countries WHERE slug='kenya')
  AND section = 'executive';

-- 5. Same accuracy note for all other executive entries in all countries
UPDATE directory_entries
SET last_verified_note = COALESCE(last_verified_note, 'Verify current role on LinkedIn before use')
WHERE section = 'executive'
  AND last_verified_note IS NULL;

-- ============================================================
-- Reminder: after running this, also add SUPABASE_SERVICE_ROLE_KEY
-- and ADMIN_EMAIL to your Vercel environment variables so the
-- admin contributions review page works.
-- ============================================================
