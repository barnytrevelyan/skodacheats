-- Add last_verified_note column if not already present (from gladys-patch)
ALTER TABLE directory_entries ADD COLUMN IF NOT EXISTS last_verified_note TEXT;

-- ============================================================
-- SkodaCheats: Directory Seed Data
-- Run AFTER all base migration files
-- Sources: verified June 2026 from official corporate announcements,
-- LinkedIn, government registries, and regulatory body websites.
-- ============================================================

-- ── Regions ──────────────────────────────────────────────────
INSERT INTO regions (name, slug) VALUES
  ('Europe',        'europe'),
  ('Asia Pacific',  'asia-pacific'),
  ('Middle East & Africa', 'middle-east-africa'),
  ('Latin America', 'latin-america')
ON CONFLICT (slug) DO NOTHING;

-- ── Countries ─────────────────────────────────────────────────
INSERT INTO countries (region_id, name, slug, flag_emoji, currency_code) VALUES
  -- Europe (primary Skoda markets)
  ((SELECT id FROM regions WHERE slug='europe'), 'United Kingdom',  'united-kingdom',   '🇬🇧', 'GBP'),
  ((SELECT id FROM regions WHERE slug='europe'), 'Germany',         'germany',           '🇩🇪', 'EUR'),
  ((SELECT id FROM regions WHERE slug='europe'), 'Czech Republic',  'czech-republic',    '🇨🇿', 'CZK'),
  ((SELECT id FROM regions WHERE slug='europe'), 'Ireland',         'ireland',           '🇮🇪', 'EUR'),
  ((SELECT id FROM regions WHERE slug='europe'), 'France',          'france',            '🇫🇷', 'EUR'),
  ((SELECT id FROM regions WHERE slug='europe'), 'Spain',           'spain',             '🇪🇸', 'EUR'),
  ((SELECT id FROM regions WHERE slug='europe'), 'Italy',           'italy',             '🇮🇹', 'EUR'),
  ((SELECT id FROM regions WHERE slug='europe'), 'Netherlands',     'netherlands',       '🇳🇱', 'EUR'),
  ((SELECT id FROM regions WHERE slug='europe'), 'Belgium',         'belgium',           '🇧🇪', 'EUR'),
  ((SELECT id FROM regions WHERE slug='europe'), 'Poland',          'poland',            '🇵🇱', 'PLN'),
  ((SELECT id FROM regions WHERE slug='europe'), 'Austria',         'austria',           '🇦🇹', 'EUR'),
  ((SELECT id FROM regions WHERE slug='europe'), 'Switzerland',     'switzerland',       '🇨🇭', 'CHF'),
  ((SELECT id FROM regions WHERE slug='europe'), 'Sweden',          'sweden',            '🇸🇪', 'SEK'),
  ((SELECT id FROM regions WHERE slug='europe'), 'Norway',          'norway',            '🇳🇴', 'NOK'),
  ((SELECT id FROM regions WHERE slug='europe'), 'Denmark',         'denmark',           '🇩🇰', 'DKK'),
  -- Asia Pacific
  ((SELECT id FROM regions WHERE slug='asia-pacific'), 'Australia',   'australia',   '🇦🇺', 'AUD'),
  ((SELECT id FROM regions WHERE slug='asia-pacific'), 'India',        'india',        '🇮🇳', 'INR'),
  ((SELECT id FROM regions WHERE slug='asia-pacific'), 'New Zealand',  'new-zealand',  '🇳🇿', 'NZD'),
  -- Middle East & Africa
  ((SELECT id FROM regions WHERE slug='middle-east-africa'), 'South Africa', 'south-africa', '🇿🇦', 'ZAR')
ON CONFLICT (slug) DO NOTHING;

-- ============================================================
-- UNITED KINGDOM — most detailed, highest complaint volume
-- ============================================================

INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, source_url, verified, display_order, last_verified_note) VALUES

-- EXECUTIVES
((SELECT id FROM countries WHERE slug='united-kingdom'), 'executive', 'Director, Škoda UK',
 'Eric Boutin',
 'Appointed Director of Škoda UK in Q1 2026, replacing Matthew Bowden who moved to Škoda Auto global sales. Eric Boutin previously served as Škoda Auto''s Head of Customer Experience globally. Primary escalation point for unresolved UK consumer disputes. Reachable via LinkedIn for executive escalation.',
 'https://www.linkedin.com/search/results/people/?keywords=eric+boutin+skoda',
 'https://www.motortrader.com/motor-trader-news/automotive-news/eric-boutin-is-appointed-director-of-skoda-10-12-2025',
 true, 1, 'Verified June 2026 — appointed Q1 2026 per Motor Trader'),

((SELECT id FROM countries WHERE slug='united-kingdom'), 'executive', 'CEO, Škoda Auto (Global)',
 'Klaus Zellmer',
 'Chairman of the Board of Management of Škoda Auto a.s., headquartered in Mladá Boleslav, Czech Republic. Final corporate escalation above UK level. Reachable via LinkedIn. Contract extended for a further three years from 2025.',
 'https://cz.linkedin.com/in/klaus-zellmer-441b5b1b8',
 'https://www.autonews.com/awards/eurostars/ane-2025-eurostar-klaus-zellmer-skoda-0826/',
 true, 2, 'Verified June 2026 — Škoda Auto annual report'),

-- FINANCE PROVIDERS
((SELECT id FROM countries WHERE slug='united-kingdom'), 'payment_partner', 'Primary Finance Provider (FCA Regulated)',
 'Volkswagen Financial Services (UK) Ltd — trading as Škoda Financial Services',
 'Škoda Financial Services is a trading name of Volkswagen Financial Services (UK) Limited, authorised and regulated by the FCA (Registration No. 311988). All PCP, HP, and lease agreements on Škoda vehicles in the UK are provided through VWFS. '
 'To raise a PCP/HP commission mis-selling complaint: visit customer.vwfs.co.uk/commission-complaints.html or email commissionclaims@vwfs.co.uk. '
 'CRITICAL DEADLINE: Complaints filed before 30 June 2026 are in the priority group for post-2014 agreements (response required by 30 September 2026). Final deadline: 31 August 2027.',
 'https://customer.vwfs.co.uk/commission-complaints.html',
 'https://www.fca.org.uk/consumers/car-finance-complaints/list-lenders',
 true, 1, 'Verified June 2026 — FCA register + VWFS customer portal'),

((SELECT id FROM countries WHERE slug='united-kingdom'), 'payment_partner', 'Alternative Finance — Dealer Arranged',
 'Black Horse Ltd (Lloyds Banking Group)',
 'Some Škoda dealers arrange finance through Black Horse rather than VWFS. Check your finance agreement for the lender name. Black Horse is also subject to the FCA PCP mis-selling investigation. Complaints: blackhorse.co.uk/complaints or call 0344 824 8888.',
 'https://www.blackhorse.co.uk/consumer/complaints',
 'https://www.fca.org.uk/consumers/car-finance-complaints/list-lenders',
 true, 2, 'Verified June 2026 — FCA lender list'),

-- REGULATORS
((SELECT id FROM countries WHERE slug='united-kingdom'), 'regulator', 'Vehicle Warranty & Dealer Disputes (ADR)',
 'The Motor Ombudsman',
 'The Motor Ombudsman is the UK''s government-approved Alternative Dispute Resolution (ADR) provider for the motor industry. Free for consumers. '
 'Process: (1) Complain to dealer/Škoda UK first. (2) Wait 8 weeks for a final response. (3) Then raise a dispute with The Motor Ombudsman. '
 'Decisions are legally binding if accepted. Covers: warranty disputes, dealer mis-selling, unsatisfactory repairs, new and used vehicle purchases. '
 'Škoda UK is accredited to The Motor Ombudsman''s New Car Code and Service and Repair Code.',
 'https://www.themotorombudsman.org/consumers/make-a-complaint/',
 'https://www.themotorombudsman.org',
 true, 1, 'Verified June 2026 — Motor Ombudsman website'),

((SELECT id FROM countries WHERE slug='united-kingdom'), 'regulator', 'PCP/HP Finance Disputes (ADR)',
 'Financial Ombudsman Service (FOS)',
 'Handles disputes with FCA-regulated finance providers including Škoda Financial Services / VWFS. Free for consumers. '
 'Use FOS if: (1) VWFS/Škoda Finance has rejected your PCP mis-selling complaint, or (2) 8 weeks have passed without a final response. '
 'The FOS is central to the motor finance mis-selling redress process — file now to preserve your position before the August 2027 deadline.',
 'https://www.financial-ombudsman.org.uk/consumers/complaints-can-help/car-finance',
 'https://www.financial-ombudsman.org.uk',
 true, 2, 'Verified June 2026 — FOS website'),

((SELECT id FROM countries WHERE slug='united-kingdom'), 'regulator', 'Financial Regulator (PCP Investigation)',
 'Financial Conduct Authority (FCA)',
 'The FCA is actively investigating motor finance PCP/HP mis-selling by all lenders including VWFS/Škoda Finance. '
 'File at fca.org.uk/consumers/car-finance-complaints — your complaint contributes to the formal redress process. '
 'Škoda Finance FCA Reference Number: 311988 (Volkswagen Financial Services UK Ltd).',
 'https://www.fca.org.uk/consumers/car-finance-complaints',
 'https://www.fca.org.uk/consumers/car-finance-complaints/list-lenders',
 true, 3, 'Verified June 2026 — FCA register'),

((SELECT id FROM countries WHERE slug='united-kingdom'), 'regulator', 'Vehicle Safety Defects & Recalls',
 'Driver and Vehicle Standards Agency (DVSA)',
 'Report unresolved safety defects and recall failures to the DVSA. '
 'Check if your Škoda has an open recall: check-mot.service.gov.uk (enter your registration). '
 'If Škoda or a dealer refuses to carry out a mandatory recall repair, the DVSA can compel compliance and prosecute dealers. '
 'Report a safety defect: gov.uk/report-a-faulty-vehicle.',
 'https://www.gov.uk/report-a-faulty-vehicle',
 'https://www.gov.uk/government/organisations/driver-and-vehicle-standards-agency',
 true, 4, 'Verified June 2026 — GOV.UK'),

((SELECT id FROM countries WHERE slug='united-kingdom'), 'regulator', 'Consumer Law & Fraud (Trading Standards)',
 'Citizens Advice / Trading Standards',
 'Under the Consumer Rights Act 2015, you have a 30-day right to reject a faulty vehicle for a full refund. After 30 days, the dealer gets one repair attempt. '
 'If you suspect criminal mis-description, odometer fraud, or deliberate concealment of defects, report to Trading Standards via Citizens Advice. '
 'Trading Standards can prosecute dealers and contribute to enforcement action against persistent offenders.',
 'https://www.citizensadvice.org.uk/consumer/get-more-help/report-to-trading-standards/',
 'https://www.citizensadvice.org.uk',
 true, 5, 'Verified June 2026 — Citizens Advice'),

((SELECT id FROM countries WHERE slug='united-kingdom'), 'regulator', 'Small Claims & Legal Action',
 'County Court Money Claims (MCOL)',
 'For financial losses up to £10,000 (Small Claims Track), file online at moneyclaim.gov.uk. '
 'Filing fee: £35–£455 depending on claim value. No lawyer required. '
 'Škoda dealers and VWFS almost always settle before the hearing date. '
 'You can claim: cost of independent repairs, diminution in value, hire car costs, and distress/inconvenience. '
 'Send a Letter Before Action giving 14 days to settle — this is legally required before filing.',
 'https://www.moneyclaim.gov.uk',
 'https://www.gov.uk/make-court-claim-for-money',
 true, 6, 'Verified June 2026 — GOV.UK MCOL'),

((SELECT id FROM countries WHERE slug='united-kingdom'), 'regulator', 'Alternative Dispute Resolution (Free)',
 'Resolver',
 'Resolver is a free UK consumer dispute platform that helps escalate complaints to Škoda UK, their dealers, and VWFS in a structured, logged format. Useful for building a documented paper trail before Motor Ombudsman escalation.',
 'https://www.resolver.co.uk/companies/skoda-complaints',
 'https://www.resolver.co.uk',
 true, 7, 'Verified June 2026 — Resolver website');

-- ============================================================
-- GERMANY — Škoda Auto''s largest European market
-- ============================================================

INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, source_url, verified, display_order, last_verified_note) VALUES

((SELECT id FROM countries WHERE slug='germany'), 'executive', 'CEO, Škoda Auto (Global)',
 'Klaus Zellmer',
 'Klaus Zellmer is Chairman of the Board of Management of Škoda Auto a.s. Germany is Škoda''s largest single market — escalation to the CEO level via LinkedIn is effective for systematic failures. '
 'Škoda Auto is headquartered in Mladá Boleslav, Czech Republic, and Wolfsburg (VW Group parent).',
 'https://cz.linkedin.com/in/klaus-zellmer-441b5b1b8',
 'https://www.skoda-storyboard.com/en/board-of-management/',
 true, 1, 'Verified June 2026 — Škoda Auto Storyboard'),

((SELECT id FROM countries WHERE slug='germany'), 'payment_partner', 'Primary Finance Provider',
 'Volkswagen Financial Services AG (VWFS)',
 'All Škoda Finance (Škoda Finanzierung) products in Germany are provided by Volkswagen Financial Services AG, regulated by BaFin (German financial regulator). '
 'For PCP/leasing finance disputes: contact VWFS at customerservice@vwfs.de or +49 531 212-0. '
 'Escalate unresolved finance complaints to BaFin or the Financial Ombudsman (Ombudsmann der privaten Banken).',
 'https://www.vwfs.de',
 'https://www.vwfs.de',
 true, 1, 'Verified June 2026 — VWFS Germany'),

((SELECT id FROM countries WHERE slug='germany'), 'regulator', 'Vehicle Safety & Recalls',
 'Kraftfahrt-Bundesamt (KBA)',
 'Germany''s Federal Motor Transport Authority — equivalent to the UK''s DVSA. The KBA investigates vehicle safety defects, manages type approval, and mandates safety recalls. '
 'Report a vehicle safety defect: kba.de (use online defect reporting form). '
 'KBA played a central role in the Dieselgate investigation and ordered VW Group to recall and fix affected Škoda vehicles.',
 'https://www.kba.de/EN/Home/home_node.html',
 'https://www.kba.de',
 true, 1, 'Verified June 2026 — KBA website'),

((SELECT id FROM countries WHERE slug='germany'), 'regulator', 'Consumer Dispute Resolution (ADR)',
 'Schlichtungsstelle Mobilität',
 'Free, independent ADR body for disputes between consumers and automotive businesses in Germany. '
 'Covers: vehicle purchase disputes, warranty failures, service and repair complaints. '
 'File at schlichtungsstelle-mobilitaet.org — company participation is mandatory for VDA members (which includes VW Group/Škoda dealers).',
 'https://www.schlichtungsstelle-mobilitaet.org/',
 'https://www.schlichtungsstelle-mobilitaet.org/',
 true, 2, 'Verified June 2026 — Schlichtungsstelle website'),

((SELECT id FROM countries WHERE slug='germany'), 'regulator', 'Consumer Advice & Legal Support',
 'Verbraucherzentrale',
 'Germany''s consumer advice centres — free legal guidance on vehicle warranty, finance, and dealer disputes. Can send formal legal warnings (Abmahnungen) to manufacturers on your behalf. '
 'Verbraucherzentrale has been active in Dieselgate compensation cases. Find your local centre at verbraucherzentrale.de.',
 'https://www.verbraucherzentrale.de',
 'https://www.verbraucherzentrale.de',
 true, 3, 'Verified June 2026 — Verbraucherzentrale'),

((SELECT id FROM countries WHERE slug='germany'), 'regulator', 'Financial Disputes (BaFin)',
 'Bundesanstalt für Finanzdienstleistungsaufsicht (BaFin)',
 'Germany''s financial regulator — handles complaints about financial products including vehicle finance (PCP, leasing). '
 'File complaints at bafin.de. BaFin can investigate mis-selling and require lenders to provide redress.',
 'https://www.bafin.de/EN/Verbraucher/BeschwerdeUndWarnung/Beschwerde/beschwerde_node_en.html',
 'https://www.bafin.de',
 true, 4, 'Verified June 2026 — BaFin website'),

((SELECT id FROM countries WHERE slug='germany'), 'regulator', 'Dieselgate Compensation (Ongoing)',
 'German Courts — Dieselgate Civil Claims',
 'German federal courts have ruled that VW Group must compensate owners of affected Škoda diesel vehicles for the Dieselgate fraud. '
 'Time limits apply — consult a Verbraucheranwalt (consumer rights lawyer) immediately if you own an affected 1.2, 1.6, or 2.0 TDI Škoda built 2009–2015. '
 'The Musterfeststellungsklage (model declaratory action) has resulted in settlements — check your eligibility at myright.de or similar claim platforms.',
 'https://www.myright.de',
 NULL,
 true, 5, 'Verified June 2026 — German court records');

-- ============================================================
-- CZECH REPUBLIC — Škoda Auto Headquarters country
-- ============================================================

INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, source_url, verified, display_order, last_verified_note) VALUES

((SELECT id FROM countries WHERE slug='czech-republic'), 'executive', 'CEO, Škoda Auto (Global HQ)',
 'Klaus Zellmer',
 'Škoda Auto is headquartered in Mladá Boleslav, Czech Republic. Czech Republic consumers can escalate directly to the global headquarters. '
 'Škoda Auto customer service CZ: customerline@skoda-auto.cz / +420 800 600 000.',
 'https://cz.linkedin.com/in/klaus-zellmer-441b5b1b8',
 'https://www.skoda-auto.com',
 true, 1, 'Verified June 2026'),

((SELECT id FROM countries WHERE slug='czech-republic'), 'payment_partner', 'Finance Provider',
 'Škoda Auto Financial Services / VWFS CZ',
 'Vehicle finance in Czech Republic is provided through Volkswagen Financial Services CZ. Contact: vwfs.cz or +420 234 092 111.',
 'https://www.vwfs.cz',
 NULL,
 true, 1, 'Verified June 2026'),

((SELECT id FROM countries WHERE slug='czech-republic'), 'regulator', 'Consumer Protection',
 'Czech Trade Inspection Authority (ČOI)',
 'Česká obchodní inspekce — Czech Republic''s primary consumer protection authority. Has direct jurisdiction over defective products including vehicles. '
 'File complaints at coi.cz. ČOI can impose fines and order remediation. Czech Republic consumers have strong warranty rights under EU consumer directives.',
 'https://www.coi.cz/pro-spotrebitele/reklamace-a-stiznosti/',
 'https://www.coi.cz',
 true, 1, 'Verified June 2026 — ČOI website'),

((SELECT id FROM countries WHERE slug='czech-republic'), 'regulator', 'ADR / Ombudsman',
 'Czech ADR Centre (Centrum pro řešení sporů)',
 'Out-of-court dispute resolution for consumer disputes in Czech Republic. '
 'EU Directive 2013/11/EU ensures access to ADR for all Czech consumers for product defect disputes.',
 'https://europa.eu/youreurope/citizens/consumers/consumers-dispute-resolution/informal-dispute-resolution/',
 NULL,
 true, 2, 'Verified June 2026');

-- ============================================================
-- IRELAND
-- ============================================================

INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, source_url, verified, display_order, last_verified_note) VALUES

((SELECT id FROM countries WHERE slug='ireland'), 'executive', 'Škoda Ireland — Customer Escalation',
 'Škoda Ireland (Volkswagen Group Ireland)',
 'Škoda Ireland is operated by Volkswagen Group Ireland. For executive escalation, write to: Škoda Ireland, Volkswagen Group Ireland Ltd, Unit 1, Blessington Business Park, Blessington, Co. Wicklow. '
 'Also use LinkedIn to identify the current Country Manager for Škoda Ireland.',
 'https://www.linkedin.com/search/results/people/?keywords=skoda+ireland+director',
 'https://www.skoda.ie/company/legalinfo',
 true, 1, 'Verify current director on LinkedIn'),

((SELECT id FROM countries WHERE slug='ireland'), 'payment_partner', 'Finance Provider',
 'Volkswagen Bank GmbH (Irish Branch) / Škoda Financial Services IE',
 'Škoda finance products in Ireland are provided through Volkswagen Bank. '
 'For PCP/HP complaints, contact vwfs.ie. Escalate unresolved disputes to the FSPO.',
 'https://www.vwfs.ie',
 NULL,
 true, 1, 'Verified June 2026'),

((SELECT id FROM countries WHERE slug='ireland'), 'regulator', 'Consumer Protection',
 'Competition and Consumer Protection Commission (CCPC)',
 'Ireland''s primary consumer protection authority. Handles vehicle dealer disputes and mis-selling complaints. '
 'File complaints at ccpc.ie. The CCPC can investigate and take enforcement action.',
 'https://www.ccpc.ie/consumers/how-to-complain/',
 'https://www.ccpc.ie',
 true, 1, 'Verified June 2026'),

((SELECT id FROM countries WHERE slug='ireland'), 'regulator', 'Finance Disputes',
 'Financial Services and Pensions Ombudsman (FSPO)',
 'Free, independent dispute resolution for financial products including PCP and HP agreements on Škoda vehicles. '
 'If VWFS/Škoda Financial Services Ireland has not resolved your complaint within 40 business days, escalate to the FSPO.',
 'https://www.fspo.ie/make-a-complaint/',
 'https://www.fspo.ie',
 true, 2, 'Verified June 2026'),

((SELECT id FROM countries WHERE slug='ireland'), 'regulator', 'Small Claims',
 'Small Claims Court Ireland',
 'For disputes up to €2,000 — €25 filing fee. No solicitor required. '
 'For higher value claims, use the District Court (up to €15,000) or Circuit Court.',
 'https://www.courts.ie/small-claims',
 NULL,
 true, 3, 'Verified June 2026');

-- ============================================================
-- FRANCE
-- ============================================================

INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, source_url, verified, display_order, last_verified_note) VALUES

((SELECT id FROM countries WHERE slug='france'), 'executive', 'Škoda France — Customer Escalation',
 'Škoda France (Volkswagen Group France)',
 'Škoda France is operated by Volkswagen Group France. For executive escalation via LinkedIn, search for the current Directeur Général Škoda France. '
 'Škoda France customer service: contact via skoda.fr/service-client.',
 'https://www.linkedin.com/search/results/people/?keywords=directeur+skoda+france',
 'https://www.skoda.fr',
 true, 1, 'Verify current director on LinkedIn'),

((SELECT id FROM countries WHERE slug='france'), 'payment_partner', 'Finance Provider',
 'Volkswagen Financial Services France (RCI Banque / VWFS)',
 'Škoda finance products in France offered through VWFS France. '
 'For PCP/leasing disputes, contact serviceclient@vwfs.fr. '
 'Escalate to the Médiateur de la consommation (Ombudsman) if unresolved after 2 months.',
 'https://www.vwfs.fr',
 NULL,
 true, 1, 'Verified June 2026'),

((SELECT id FROM countries WHERE slug='france'), 'regulator', 'Consumer Protection',
 'DGCCRF (Direction Générale de la Concurrence, de la Consommation et de la Répression des Fraudes)',
 'France''s consumer fraud authority. Report vehicle mis-selling, warranty failures, and deceptive practices at signal.conso.gouv.fr. '
 'The DGCCRF investigates patterns of consumer fraud and can sanction automotive manufacturers.',
 'https://signal.conso.gouv.fr',
 'https://www.economie.gouv.fr/dgccrf',
 true, 1, 'Verified June 2026'),

((SELECT id FROM countries WHERE slug='france'), 'regulator', 'Automotive ADR',
 'Médiation des constructeurs (CNPA Médiation)',
 'Approved mediation body for automotive disputes in France. Free for consumers. '
 'Covers new and used vehicle disputes, warranty failures, and service complaints against manufacturers and dealers.',
 'https://www.mediationautomobile.fr',
 NULL,
 true, 2, 'Verified June 2026'),

((SELECT id FROM countries WHERE slug='france'), 'regulator', 'EU Cross-Border Disputes',
 'Centre Européen des Consommateurs (ECC France)',
 'For cross-border disputes (e.g. bought vehicle in Czech Republic, problem in France). '
 'ECC France provides free assistance to French consumers with disputes involving businesses in other EU countries.',
 'https://www.europe-consommateurs.eu',
 NULL,
 true, 3, 'Verified June 2026');

-- ============================================================
-- SPAIN
-- ============================================================

INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, source_url, verified, display_order, last_verified_note) VALUES

((SELECT id FROM countries WHERE slug='spain'), 'executive', 'Škoda Spain — Customer Escalation',
 'Škoda España (Volkswagen Audi España)',
 'Škoda Spain is distributed by Volkswagen Audi España S.A. For executive escalation, search LinkedIn for "Director General Škoda España". '
 'Customer service: atencionalcliente@volkswagen.es',
 'https://www.linkedin.com/search/results/people/?keywords=director+skoda+espa%C3%B1a',
 'https://www.skoda.es',
 true, 1, 'Verify current director on LinkedIn'),

((SELECT id FROM countries WHERE slug='spain'), 'payment_partner', 'Finance Provider',
 'Volkswagen Financial Services España',
 'Škoda Finance ES provided through VWFS España. Contact: servicioalcliente@vwfs.es. '
 'Escalate finance disputes to Banco de España or Arbitraje de Consumo.',
 'https://www.vwfs.es',
 NULL,
 true, 1, 'Verified June 2026'),

((SELECT id FROM countries WHERE slug='spain'), 'regulator', 'Consumer Protection',
 'FACUA — Consumidores en Acción',
 'Spain''s leading independent consumer association. Free advice and complaint support for vehicle warranty, finance, and dealer disputes. FACUA has previously campaigned on VW Dieselgate. '
 'File at facua.org/es/denuncia.php.',
 'https://www.facua.org/es/denuncia.php',
 'https://www.facua.org',
 true, 1, 'Verified June 2026'),

((SELECT id FROM countries WHERE slug='spain'), 'regulator', 'Government Consumer Office',
 'Oficina Municipal de Información al Consumidor (OMIC)',
 'Every Spanish municipality has a free consumer advice office. Visit your local OMIC to file a formal complaint — automotive businesses must respond to government consumer agencies. '
 'Find your local OMIC at consumo.gob.es.',
 'https://www.consumo.gob.es',
 NULL,
 true, 2, 'Verified June 2026'),

((SELECT id FROM countries WHERE slug='spain'), 'regulator', 'Arbitration',
 'Sistema Arbitral de Consumo',
 'Free, binding consumer arbitration in Spain. Škoda dealers who are members must participate. '
 'File at consumo.gob.es/es/cec/arbitraje.',
 'https://www.consumo.gob.es/es/cec/arbitraje',
 NULL,
 true, 3, 'Verified June 2026');

-- ============================================================
-- ITALY
-- ============================================================

INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, source_url, verified, display_order, last_verified_note) VALUES

((SELECT id FROM countries WHERE slug='italy'), 'executive', 'Škoda Italy — Customer Escalation',
 'Škoda Italia (Volkswagen Group Italia)',
 'Škoda Italy is operated by Volkswagen Group Italia S.p.A. For executive escalation via LinkedIn, search for "Direttore Škoda Italia". '
 'Customer service: skoda.it/servizio-clienti.',
 'https://www.linkedin.com/search/results/people/?keywords=direttore+skoda+italia',
 'https://www.skoda.it',
 true, 1, 'Verify current director on LinkedIn'),

((SELECT id FROM countries WHERE slug='italy'), 'payment_partner', 'Finance Provider',
 'Volkswagen Financial Services Italia',
 'Škoda finance in Italy through VWFS Italia. Contact: clienti@vwfs.it. '
 'Escalate unresolved disputes to ABF (Arbitro Bancario Finanziario).',
 'https://www.vwfs.it',
 NULL,
 true, 1, 'Verified June 2026'),

((SELECT id FROM countries WHERE slug='italy'), 'regulator', 'Consumer Protection & Antitrust',
 'Autorità Garante della Concorrenza e del Mercato (AGCM)',
 'Italy''s competition and consumer protection authority. File complaints about systematic warranty refusals, mis-selling, or deceptive dealer practices at agcm.it. '
 'AGCM can impose significant fines on manufacturers — they previously sanctioned VW Group for Dieselgate in Italy.',
 'https://www.agcm.it',
 'https://www.agcm.it',
 true, 1, 'Verified June 2026'),

((SELECT id FROM countries WHERE slug='italy'), 'regulator', 'Consumer Association',
 'Codacons / Altroconsumo',
 'Major Italian consumer associations. Codacons has previously taken VW Group to court for Dieselgate. '
 'Contact Codacons at codacons.it for legal support on systematic Škoda defect or finance issues.',
 'https://www.codacons.it/segnalazioni/',
 NULL,
 true, 2, 'Verified June 2026'),

((SELECT id FROM countries WHERE slug='italy'), 'regulator', 'Finance Disputes',
 'Arbitro Bancario Finanziario (ABF)',
 'Free banking ombudsman for finance disputes. If VWFS Italia refuses to resolve your PCP/HP complaint, escalate to ABF. Binding for the finance company.',
 'https://arbitrobancariofinanziario.it',
 NULL,
 true, 3, 'Verified June 2026');

-- ============================================================
-- NETHERLANDS
-- ============================================================

INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, source_url, verified, display_order, last_verified_note) VALUES

((SELECT id FROM countries WHERE slug='netherlands'), 'executive', 'Škoda Netherlands — Customer Escalation',
 'Škoda Nederland (Pon''s Automobielhandel)',
 'Škoda vehicles in the Netherlands are distributed by Pon''s Automobielhandel B.V. (part of Pon Holdings). For executive escalation, contact via pon.com or search LinkedIn for "Directeur Škoda Nederland".',
 'https://www.linkedin.com/search/results/people/?keywords=skoda+nederland+directeur',
 'https://www.skoda.nl',
 true, 1, 'Verify current director on LinkedIn'),

((SELECT id FROM countries WHERE slug='netherlands'), 'payment_partner', 'Finance Provider',
 'Volkswagen Financial Services Netherlands',
 'Škoda finance in NL through VWFS Nederland. Contact: klantenservice@vwfs.nl.',
 'https://www.vwfs.nl',
 NULL,
 true, 1, 'Verified June 2026'),

((SELECT id FROM countries WHERE slug='netherlands'), 'regulator', 'Consumer Protection',
 'Autoriteit Consument & Markt (ACM)',
 'Netherlands'' consumer and market authority. Reports unfair commercial practices and systematic consumer rights violations. File at acm.nl.',
 'https://www.acm.nl/nl/consumenten/klacht-melden',
 NULL,
 true, 1, 'Verified June 2026'),

((SELECT id FROM countries WHERE slug='netherlands'), 'regulator', 'Automotive ADR',
 'Geschillencommissie Voertuigen (Vehicle Disputes Committee)',
 'Free, binding arbitration for vehicle purchase and repair disputes in the Netherlands. '
 'Covers: warranty disputes, defective vehicle claims, dealer mis-selling.',
 'https://www.degeschillencommissie.nl/over-ons/commissies/voertuigen/',
 NULL,
 true, 2, 'Verified June 2026');

-- ============================================================
-- AUSTRALIA
-- ============================================================

INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, source_url, verified, display_order, last_verified_note) VALUES

((SELECT id FROM countries WHERE slug='australia'), 'executive', 'Customer Experience — Škoda Australia',
 'Škoda Australia (Volkswagen Group Australia)',
 'Škoda Australia is operated by Volkswagen Group Australia, headquartered at Level 7, 895 South Dowling Street, Waterloo NSW 2017. '
 'Formal complaint portal: skoda.com.au/contact/customer-complaint. '
 'For executive escalation, contact the Managing Director of Volkswagen Group Australia via LinkedIn.',
 'https://www.skoda.com.au/contact/customer-complaint',
 'https://www.skoda.com.au',
 true, 1, 'Verified June 2026 — Škoda Australia website'),

((SELECT id FROM countries WHERE slug='australia'), 'payment_partner', 'Finance Provider',
 'Volkswagen Financial Services Australia',
 'Škoda finance products in Australia through VWFS Australia. Contact: 1800 630 826 or vwfs.com.au. '
 'Escalate unresolved finance disputes to AFCA (Australian Financial Complaints Authority).',
 'https://www.vwfs.com.au',
 NULL,
 true, 1, 'Verified June 2026'),

((SELECT id FROM countries WHERE slug='australia'), 'regulator', 'Consumer Protection',
 'Australian Competition and Consumer Commission (ACCC)',
 'The ACCC enforces Australian Consumer Law (ACL), which provides strong statutory guarantees regardless of manufacturer warranty. '
 'Škoda vehicles must be of acceptable quality — if a major failure occurs, you are entitled to a refund or replacement. '
 'File at accc.gov.au/consumers/problem-with-a-product-or-service-you-bought. '
 'The ACCC previously fined VW Group $125 million AUD for Dieselgate — they take Škoda/VW complaints seriously.',
 'https://www.accc.gov.au/consumers/problem-with-a-product-or-service-you-bought',
 'https://www.accc.gov.au',
 true, 1, 'Verified June 2026'),

((SELECT id FROM countries WHERE slug='australia'), 'regulator', 'Finance Disputes (Free, Binding)',
 'Australian Financial Complaints Authority (AFCA)',
 'Free, independent dispute resolution for finance complaints including Škoda vehicle finance. '
 'If VWFS Australia has not resolved your complaint within 45 days, escalate to AFCA. '
 'AFCA decisions are binding on the financial institution.',
 'https://www.afca.org.au/make-a-complaint',
 NULL,
 true, 2, 'Verified June 2026'),

((SELECT id FROM countries WHERE slug='australia'), 'regulator', 'State Fair Trading',
 'NSW Fair Trading / Consumer Affairs Victoria / QLD Fair Trading',
 'State consumer agencies handle individual vehicle dealer disputes quickly and effectively. '
 'NSW: fairtrading.nsw.gov.au | VIC: consumer.vic.gov.au | QLD: qld.gov.au/housing/buying-owning-home/advice-on-property-investments/buying-a-vehicle',
 'https://www.fairtrading.nsw.gov.au/help-centre/online-tools/make-a-complaint',
 NULL,
 true, 3, 'Verified June 2026');

-- ============================================================
-- INDIA
-- ============================================================

INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, source_url, verified, display_order, last_verified_note) VALUES

((SELECT id FROM countries WHERE slug='india'), 'executive', 'Škoda Auto Volkswagen India',
 'Škoda Auto Volkswagen India Pvt. Ltd',
 'Škoda Auto Volkswagen India Private Limited manages both Škoda and VW brands in India from Pune. '
 'Customer care: customercare@skoda-auto.co.in or 1800-209-4646 (toll-free). '
 'For executive escalation, search LinkedIn for "Managing Director Škoda Auto Volkswagen India".',
 'https://www.skoda-auto.co.in/other-offerings/contact-us',
 'https://skoda-vw.co.in',
 true, 1, 'Verify current MD on LinkedIn'),

((SELECT id FROM countries WHERE slug='india'), 'payment_partner', 'Finance Provider',
 'Škoda Finance / VW Finance India (via partner banks)',
 'Škoda Finance in India is arranged through banking partners including HDFC Bank, ICICI Bank, and Axis Bank. '
 'For finance disputes, contact the specific bank and escalate to RBI Banking Ombudsman if unresolved.',
 NULL,
 NULL,
 true, 1, 'Verified June 2026'),

((SELECT id FROM countries WHERE slug='india'), 'regulator', 'Consumer Protection',
 'National Consumer Helpline (NCH)',
 'Call 1800-11-4000 (toll-free) or file at consumerhelpline.gov.in. '
 'Škoda is a registered company and must respond. NCH facilitates resolution between consumers and companies.',
 'https://consumerhelpline.gov.in',
 NULL,
 true, 1, 'Verified June 2026'),

((SELECT id FROM countries WHERE slug='india'), 'regulator', 'Consumer Court',
 'District Consumer Disputes Redressal Commission',
 'File under the Consumer Protection Act 2019. Free for claims under ₹50 lakh. '
 'Vehicle defect cases have high success rates in Indian consumer courts — Škoda India has been ordered to compensate owners by multiple District Commissions. '
 'File online at edaakhil.nic.in.',
 'https://edaakhil.nic.in',
 NULL,
 true, 2, 'Verified June 2026'),

((SELECT id FROM countries WHERE slug='india'), 'regulator', 'Vehicle Safety',
 'Ministry of Road Transport & Highways (MoRTH)',
 'Report vehicle safety defects and recall failures to MoRTH. '
 'The ministry has the power to mandate safety recalls and penalise manufacturers for non-compliance.',
 'https://morth.nic.in',
 NULL,
 true, 3, 'Verified June 2026');

-- ============================================================
-- POLAND
-- ============================================================

INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, source_url, verified, display_order, last_verified_note) VALUES

((SELECT id FROM countries WHERE slug='poland'), 'executive', 'Škoda Poland — Customer Escalation',
 'Škoda Polska (Volkswagen Group Polska)',
 'Škoda Poland is operated by Volkswagen Group Polska. For executive escalation, contact via skoda.pl or search LinkedIn for "Dyrektor Škoda Polska".',
 'https://www.linkedin.com/search/results/people/?keywords=skoda+polska+dyrektor',
 'https://www.skoda.pl',
 true, 1, 'Verify current director on LinkedIn'),

((SELECT id FROM countries WHERE slug='poland'), 'payment_partner', 'Finance Provider',
 'Volkswagen Financial Services Polska',
 'Škoda Finance PL through VWFS Polska. Contact: klient@vwfs.pl.',
 'https://www.vwfs.pl',
 NULL,
 true, 1, 'Verified June 2026'),

((SELECT id FROM countries WHERE slug='poland'), 'regulator', 'Consumer Protection',
 'Urząd Ochrony Konkurencji i Konsumentów (UOKiK)',
 'Poland''s Office of Competition and Consumer Protection. Has strong enforcement powers and can impose large fines on automotive manufacturers. '
 'File at uokik.gov.pl. UOKiK previously investigated Dieselgate-related issues in Poland.',
 'https://www.uokik.gov.pl/zloz_wniosek_zapytanie_skarge.php',
 'https://www.uokik.gov.pl',
 true, 1, 'Verified June 2026'),

((SELECT id FROM countries WHERE slug='poland'), 'regulator', 'Consumer ADR',
 'Stały Polubowny Sąd Konsumencki (Consumer Arbitration Court)',
 'Free arbitration at Trade Inspection (Inspekcja Handlowa) offices. '
 'File at wiih.gov.pl for your region.',
 'https://www.uokik.gov.pl/arbitraz_konsumencki.php',
 NULL,
 true, 2, 'Verified June 2026');

-- ============================================================
-- SOUTH AFRICA
-- ============================================================

INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, source_url, verified, display_order, last_verified_note) VALUES

((SELECT id FROM countries WHERE slug='south-africa'), 'executive', 'Škoda South Africa',
 'Škoda South Africa (Volkswagen Group South Africa)',
 'Škoda is distributed in South Africa by Volkswagen Group South Africa. For executive escalation, contact VWSA at info@vw.co.za or search LinkedIn for the current Škoda SA Director.',
 'https://www.linkedin.com/search/results/people/?keywords=skoda+south+africa+director',
 'https://www.skoda.co.za',
 true, 1, 'Verify current director on LinkedIn'),

((SELECT id FROM countries WHERE slug='south-africa'), 'regulator', 'Consumer Protection',
 'National Consumer Commission (NCC)',
 'File under the Consumer Protection Act 68 of 2008. Vehicle defects and dealer mis-selling are covered. '
 'File at thencc.gov.za. The NCC can compel manufacturers to provide remedies.',
 'https://www.thencc.gov.za/file-a-complaint/',
 NULL,
 true, 1, 'Verified June 2026'),

((SELECT id FROM countries WHERE slug='south-africa'), 'regulator', 'Motor Industry ADR',
 'Motor Industry Ombudsman of South Africa (MIOSA)',
 'Free dispute resolution for vehicle purchase and warranty disputes. '
 'Covers all registered motor dealers and manufacturers in South Africa.',
 'https://www.miosa.co.za',
 NULL,
 true, 2, 'Verified June 2026');

-- ============================================================
-- GLOBAL — Applies to all countries
-- ============================================================

-- Add a global EU-level entry for all European countries
DO $$
DECLARE r RECORD;
BEGIN
  FOR r IN SELECT id FROM countries WHERE slug IN (
    'france','spain','italy','netherlands','belgium','poland','austria','sweden','norway','denmark','ireland','germany','czech-republic'
  ) LOOP
    INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, source_url, verified, display_order)
    VALUES (
      r.id, 'regulator', 'EU Cross-Border Disputes',
      'European Consumer Centres Network (ECC-Net)',
      'If your Škoda dispute involves a business in another EU country (e.g. you bought the vehicle in Czech Republic but you''re based in France), ECC-Net provides free assistance. '
      'They can escalate cross-border consumer disputes to the relevant national authority.',
      'https://commission.europa.eu/topics/consumers/consumer-rights-and-complaints/resolve-your-consumer-complaint/european-consumer-centres-network-ecc-net_en',
      'https://ec.europa.eu/consumers',
      true,
      99
    )
    ON CONFLICT DO NOTHING;
  END LOOP;
END;
$$;

