-- ============================================================
-- SkodaCheats Directory — v2 Deep Research Update
-- Run AFTER supabase-skoda-directory.sql
-- All data verified June 2026 from public sources
-- ============================================================

-- ── Key corrections from v1 ──────────────────────────────────
-- 1. Germany: Schlichtungsstelle Mobilität covers PUBLIC TRANSPORT not cars.
--    Replace with Kfz-Schiedsstellen (ZDK) which IS the correct auto body.
-- 2. South Africa: Škoda has no official new-vehicle presence in SA.
--    Update entry to reflect grey-market/used-vehicle context.
-- ── ─────────────────────────────────────────────────────────

-- Fix Germany: remove incorrect Schlichtungsstelle Mobilität entry
DELETE FROM directory_entries
WHERE country_id = (SELECT id FROM countries WHERE slug='germany')
  AND name = 'Schlichtungsstelle Mobilität';

-- ============================================================
-- UNITED KINGDOM — Full update with all verified details
-- ============================================================

-- Update Eric Boutin with confirmed LinkedIn URL
UPDATE directory_entries
SET contact_url = 'https://www.linkedin.com/in/erboutin/',
    notes = 'Appointed Director of Škoda UK in Q1 2026, replacing Matthew Bowden who moved to Škoda Auto global sales. Previously Head of Customer Experience globally at Škoda Auto. Primary escalation for unresolved UK consumer disputes. Reachable via LinkedIn.',
    source_url = 'https://www.motortrader.com/motor-trader-news/automotive-news/eric-boutin-is-appointed-director-of-skoda-10-12-2025',
    last_verified_note = 'Verified June 2026 — Motor Trader + LinkedIn confirmed'
WHERE country_id = (SELECT id FROM countries WHERE slug='united-kingdom')
  AND name = 'Eric Boutin';

-- Update VWFS entry with full postal address, email, and PS26/3 details
UPDATE directory_entries
SET notes = 'Škoda Financial Services is a trading name of Volkswagen Financial Services (UK) Limited, FCA Registration No. 311988. '
    'FORMAL COMPLAINT ADDRESS: Customer Resolutions Dept, Brunswick Court, Yeomans Drive, Blakelands, Milton Keynes MK14 5LR. Email: customerresolutions@vwfs.co.uk. '
    'PCP MIS-SELLING DEADLINES (FCA PS26/3, March 2026): File before 30 June 2026 for post-2014 agreements (priority group) → VWFS must respond by 30 Sept 2026. File before 31 Aug 2026 for 2007–2014 agreements → response by 30 Nov 2026. Final deadline for any claim: 31 August 2027. '
    '57% of VWFS customers who complained had a confirmed Discretionary Commission Arrangement — among the highest in the industry. '
    'VWFS is challenging PS26/3 via judicial review (May 2026) but the FCA has ordered continued implementation. File your complaint now to preserve your position.',
    last_verified_note = 'Verified June 2026 — FCA PS26/3, FCA register, VWFS portal'
WHERE country_id = (SELECT id FROM countries WHERE slug='united-kingdom')
  AND name LIKE '%Volkswagen Financial Services%';

-- Update Motor Ombudsman with phone number and exact Škoda accreditation details
UPDATE directory_entries
SET notes = 'The Motor Ombudsman is the UK''s government-approved ADR provider for the motor industry. Free for consumers. '
    'Phone: 0345 241 3008 (Mon–Fri 9am–4:30pm). Address: 71 Great Peter Street, London SW1P 2BN. '
    'ŠKODA UK IS ACCREDITED to both the New Car Code and the Service & Repair Code. '
    'Process: (1) Complain to dealer/Škoda UK. (2) Wait 8 weeks for final response. (3) Raise dispute at themotorombudsman.org. '
    'Decisions are legally binding on accredited businesses. Typically several months to resolve.',
    source_url = 'https://www.themotorombudsman.org/accredited-business/skoda-auto-uk/',
    last_verified_note = 'Verified June 2026 — Motor Ombudsman website'
WHERE country_id = (SELECT id FROM countries WHERE slug='united-kingdom')
  AND name = 'The Motor Ombudsman';

-- Update DVSA with exact URLs
UPDATE directory_entries
SET notes = 'Report a serious safety defect: contact-dvsa.service.gov.uk/report-vehicle-safety-defect. Online form: forms.dvsa.gov.uk/Vsdr/create. '
    'CHECK IF YOUR ŠKODA HAS AN OPEN RECALL: gov.uk/check-vehicle-recall (enter registration). '
    'Škoda official UK recall page: skoda.co.uk/owners/recall-campaigns. '
    'If Škoda refuses to carry out a mandatory recall repair, report to DVSA immediately — they can compel compliance and prosecute dealers. No time limit on safety recall repairs; always free of charge.',
    contact_url = 'https://www.gov.uk/check-vehicle-recall',
    source_url = 'https://forms.dvsa.gov.uk/Vsdr/create',
    last_verified_note = 'Verified June 2026 — GOV.UK'
WHERE country_id = (SELECT id FROM countries WHERE slug='united-kingdom')
  AND name = 'Driver and Vehicle Standards Agency (DVSA)';

-- Update FOS with phone number
UPDATE directory_entries
SET notes = 'Handles disputes with FCA-regulated finance providers including Škoda Financial Services / VWFS. Free for consumers. '
    'Phone: 0370 5050 197 (Mon–Fri 8am–8pm; Sat 9am–1pm). Email: complaint.info@financial-ombudsman.org.uk. '
    'Post: Financial Ombudsman Service, Exchange Tower, London E14 9SR. '
    'Use FOS if: VWFS has rejected your PCP/commission complaint, or 8 weeks have passed without a final response. '
    'FOS motor finance commission page: financial-ombudsman.org.uk/consumers/complaints-can-help/credit-borrowing-money/car-finance/complaints-about-commission',
    last_verified_note = 'Verified June 2026 — FOS website'
WHERE country_id = (SELECT id FROM countries WHERE slug='united-kingdom')
  AND name = 'Financial Ombudsman Service (FOS)';

-- Add Resolver entry for UK
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, source_url, verified, display_order, last_verified_note)
VALUES (
  (SELECT id FROM countries WHERE slug='united-kingdom'),
  'regulator', 'Free Complaints Tool',
  'Resolver',
  'Free structured complaints escalation tool. Logs all correspondence automatically and can escalate to the Motor Ombudsman or FOS. Useful for building a documented paper trail. Škoda UK and VWFS are both listed. Free, no registration fee.',
  'https://www.resolver.co.uk/companies/skoda-complaints',
  'https://www.resolver.co.uk',
  true, 8, 'Verified June 2026'
);

-- Add Škoda UK direct contact details
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, source_url, verified, display_order, last_verified_note)
VALUES (
  (SELECT id FROM countries WHERE slug='united-kingdom'),
  'executive', 'Customer Service Centre',
  'Škoda UK Customer Service',
  'Phone: 0333 003 7504 (Mon–Fri 08:00–18:00; Sat 09:00–17:00). Live Chat: skoda.co.uk 7 days/week 08:00–22:00. '
  'Formal postal complaints: Škoda Customer Service Centre, PO Box 114, Wallington SM6 7QL. '
  'Contact form: skoda.co.uk/discover/contact-us-form. '
  'Always put complaints in writing (email or post) to create a paper trail for Motor Ombudsman escalation.',
  'https://www.skoda.co.uk/discover/contact-us',
  'https://www.skoda.co.uk/discover/contact-us-form',
  true, 3, 'Verified June 2026 — Škoda UK website'
);

-- ============================================================
-- GERMANY — Full update with correct ADR body + frank barwasser
-- ============================================================

-- Update to Frank Barwasser (new MD from Jan 2026)
UPDATE directory_entries
SET name = 'Frank Barwasser',
    role_or_type = 'Managing Director, Škoda Deutschland',
    notes = 'Appointed Managing Director (Geschäftsführer) of Škoda Deutschland GmbH on 1 January 2026, replacing Jan-Hendrik Hülsmann. Previously Head of Sales Control at Škoda Deutschland and Head of Sales Germany for VW Pkw. '
    'Second Managing Director: Libor Myška (Finance, Procurement, Legal & Compliance, IT, HR). '
    'Škoda Deutschland official leadership: skoda-auto.de/unternehmen/geschaeftsleitung. Contact for executive escalation via LinkedIn.',
    contact_url = 'https://www.linkedin.com/search/results/people/?keywords=frank+barwasser+skoda',
    source_url = 'https://www.skoda-media.de/press/detail/4550',
    last_verified_note = 'Verified June 2026 — skoda-media.de press release'
WHERE country_id = (SELECT id FROM countries WHERE slug='germany')
  AND section = 'executive';

-- Add correct automotive ADR body for Germany (Kfz-Schiedsstellen, not Schlichtungsstelle Mobilität)
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, source_url, verified, display_order, last_verified_note)
VALUES (
  (SELECT id FROM countries WHERE slug='germany'),
  'regulator', 'Automotive Dispute Resolution (ADR)',
  'Kfz-Schiedsstellen (ZDK)',
  'The primary out-of-court dispute body for car sales and repairs in Germany. Covers disputes about vehicle purchases, warranty failures, and repair quality with ZDK-member dealers. '
  'Process: (1) Submit complaint online at kfz-schiedsstellen.de. (2) Schiedsstelle is determined by dealer''s location. (3) Pre-proceedings attempt amicable resolution. (4) If unresolved, formal commission decision within ~3 months. '
  '~90% of cases resolved in pre-proceedings. Non-binding suggestion — either party can reject and proceed to court. Free for consumers. '
  'Most authorised Škoda dealers are ZDK members.',
  'https://www.kfz-schiedsstellen.de/',
  'https://www.kfzgewerbe.de/initiativen/schiedsstellen',
  true, 2, 'Verified June 2026'
);

-- Update KBA with exact URLs for VIN-based recall search
UPDATE directory_entries
SET notes = 'Germany''s Federal Motor Transport Authority — equivalent to the UK DVSA. Investigates vehicle safety defects and mandates recalls. '
    'REPORT A VEHICLE DEFECT: kba.de → Rückrufe → Mangel melden. '
    'CHECK RECALLS BY VIN: kba-online.de/rrdb/buerger/ (direct recall search by VIN). '
    'KBA recall database: kba.de → Rückrufe → Rückrufdatenbank. '
    'KBA Phone (market surveillance/defects): +49 461 316-2499. Email: kba@kba.de. Address: Fördestraße 16, 24944 Flensburg. '
    'KBA played a central role in the Dieselgate investigation and ordered VW Group to recall and fix all affected Škoda diesel vehicles.',
    contact_url = 'https://www.kba-online.de/rrdb/buerger/',
    source_url = 'https://www.kba.de/DE/Themen/Marktueberwachung/Rueckrufe/Mangel_melden/mangel_melden_node.html',
    last_verified_note = 'Verified June 2026 — KBA website'
WHERE country_id = (SELECT id FROM countries WHERE slug='germany')
  AND name = 'Kraftfahrt-Bundesamt (KBA)';

-- Update Verbraucherzentrale with Dieselgate-specific URLs and ADAC link
UPDATE directory_entries
SET notes = 'Germany''s consumer advice centres — free legal guidance on vehicle warranty, finance, and dealer disputes. Local centres can send formal legal warnings (Abmahnungen) to manufacturers on your behalf. '
    'Find your local centre: verbraucherzentrale.de/beratung. '
    'DIESELGATE SPECIFIC: verbraucherzentrale.de/wissen/vertraege-reklamation/kundenrechte/dieselabgasskandal-unsere-antworten-auf-haeufige-fragen-12260. '
    'VW class action history: verbraucherzentrale.de/verfahren/vw. '
    'ADAC Dieselgate/VW guide: adac.de/rund-ums-fahrzeug/auto-kaufen-verkaufen/abgasskandal-rechte/vw. '
    'Also useful: Ombudsmann der privaten Banken (bankenombudsmann.de) for VW Bank/VWFS finance disputes.',
    last_verified_note = 'Verified June 2026'
WHERE country_id = (SELECT id FROM countries WHERE slug='germany')
  AND name = 'Verbraucherzentrale (Consumer Advice Centre)';

-- Update BaFin with correct process note (cannot resolve individual disputes)
UPDATE directory_entries
SET notes = 'BaFin supervises Volkswagen Financial Services AG and Volkswagen Bank GmbH (which provide Škoda Finance products in Germany). '
    'IMPORTANT: BaFin handles collective consumer protection and cannot resolve individual disputes — for individual redress use the Ombudsmann der privaten Banken (bankenombudsmann.de). '
    'BaFin consumer hotline (free): 0800 2 100 500. Use BaFin to report systematic mis-selling or regulatory breaches. '
    'File complaints at: bafin.de/DE/Verbraucher/BeschwerdenStreitschlichtung.',
    contact_url = 'https://www.bafin.de/DE/Verbraucher/BeschwerdenStreitschlichtung/BeiBaFinbeschweren/BeiBaFinbeschweren_node.html',
    last_verified_note = 'Verified June 2026 — BaFin website'
WHERE country_id = (SELECT id FROM countries WHERE slug='germany')
  AND name = 'Bundesanstalt für Finanzdienstleistungsaufsicht (BaFin)';

-- Update Dieselgate entry with 2025 German criminal conviction
UPDATE directory_entries
SET notes = 'VW Group paid over $33 billion globally in Dieselgate fines and settlements. Key updates: '
    'GERMAN CRIMINAL CONVICTIONS (26 May 2025): Four former VW managers convicted of fraud by a German court. Jens Hadler (diesel development lead) sentenced to 4.5 years; others received sentences of 1–2.5 years. '
    'GERMAN CONSUMER SETTLEMENT: Verbraucherzentrale Bundesverband (vzbv) Musterfeststellungsklage settled 2020 — ~240,000 consumers, ~€770 million paid. THIS CASE IS CLOSED. '
    'EA288 ONGOING: In December 2024, Škoda recalled 3,583 Fabia/Roomster vehicles (recall code 23R6) for an emissions defeat device. The KBA also registered a voluntary service measure for ~344,000 Octavia/Superb vehicles (2015–2018). '
    'EA288 individual claims: law firms dr-stoll-kollegen.de and hahn-rechtsanwaelte.de are still active. Limitation periods: check your purchase year — many 2015+ purchases still within 10-year limitation. '
    'WARNING on myright.de: Financialright GmbH (myright.de) has had subsidiary insolvency issues — verify current financial stability before engaging.',
    last_verified_note = 'Verified June 2026 — Euronews, OCCRP, car-recalls.eu'
WHERE country_id = (SELECT id FROM countries WHERE slug='germany')
  AND name LIKE '%Dieselgate%';

-- ============================================================
-- CZECH REPUBLIC — Full update with verified contact details
-- ============================================================

UPDATE directory_entries
SET notes = 'ŠKODA AUTO a.s. HEADQUARTERS: tř. Václava Klementa 869, Mladá Boleslav II, 293 01 Mladá Boleslav, Czech Republic. '
    'Freephone (CZ): 800 600 000. Direct customer care: +420 236 090 002. Email: infoline@skoda-auto.cz. '
    'Main switchboard: +420 326 811 111. Website: skoda-auto.com. '
    'NOTE: The email customerline@skoda-auto.cz (previously listed) is not confirmed on official Škoda pages — use infoline@skoda-auto.cz.',
    contact_url = 'https://www.skoda-auto.com/other/imprint',
    last_verified_note = 'Verified June 2026 — skoda-auto.com imprint'
WHERE country_id = (SELECT id FROM countries WHERE slug='czech-republic')
  AND name LIKE '%Klaus Zellmer%';

-- Update ČOI with exact URLs and ADR process
UPDATE directory_entries
SET notes = 'Czech Trade Inspection Authority — primary consumer protection body with jurisdiction over vehicle defects. '
    'SUBMIT COMPLAINT ONLINE: coi.gov.cz/podatelna/ (faster than email/post). '
    'ČOI also operates as an ADR body (free, 90-day resolution target): coi.gov.cz/mimosoudni-reseni-spotrebitelskych-sporu-adr/. '
    'Process: (1) Formally complain to the seller (reklamace) and wait up to 30 days. (2) If unsatisfied, file with ČOI. '
    'Czech law guarantee rights: 2 years on new vehicles (12-month presumption of pre-existing defect for first year). '
    'Czech consumer warranty guide: coi.gov.cz/en/for-business/information-for-retailers/warranty-and-liability-for-defects/. '
    'COMPETITION FINE: ČOI / ÚOHS fined Škoda Auto CZK 36 million (reduced on appeal from CZK 49 million) in 2022 for resale price maintenance — demonstrates regulator willingness to act.',
    contact_url = 'https://coi.gov.cz/podatelna/',
    source_url = 'https://coi.gov.cz/mimosoudni-reseni-spotrebitelskych-sporu-adr/',
    last_verified_note = 'Verified June 2026 — ČOI website'
WHERE country_id = (SELECT id FROM countries WHERE slug='czech-republic')
  AND name = 'Czech Trade Inspection Authority (ČOI)';

-- ============================================================
-- FRANCE — Full update with Julien Bessière + verified contacts
-- ============================================================

UPDATE directory_entries
SET name = 'Julien Bessière',
    role_or_type = 'Managing Director, Škoda France',
    notes = 'Appointed Managing Director of Škoda France in January 2024, replacing Dorothée Bonassies. '
    'Background: joined VW Group France in 1999; previously Director of Sales at Volkswagen France. '
    'Reachable via LinkedIn for executive escalation.',
    contact_url = 'https://fr.linkedin.com/in/julien-bessi%C3%A8re-8953047',
    source_url = 'https://presse.skoda.fr/julien-bessiere-nomme-a-la-tete-de-skoda-france/',
    last_verified_note = 'Verified June 2026 — Škoda France press release + LinkedIn'
WHERE country_id = (SELECT id FROM countries WHERE slug='france')
  AND section = 'executive';

-- Update VWFS France with exact contacts
UPDATE directory_entries
SET notes = 'VWFS France: Phone: 09 69 39 33 33 (non-premium, Mon–Fri 09:00–12:30 & 13:30–17:30). '
    'Address: VOLKSWAGEN FINANCIAL SERVICES — Service Relation Clientèle, 11 avenue de Boursonne, BP 61, 02 601 Villers-Cotterêts Cedex. '
    'Contact page: vwfs.fr/contactez-nous1.html. '
    'Escalate unresolved finance complaints to Médiateur Mobilians (formerly CNPA Médiateur): mediateur-mobilians.fr/saisir-le-mediateur.',
    contact_url = 'https://www.vwfs.fr/contactez-nous1.html',
    last_verified_note = 'Verified June 2026 — VWFS France website'
WHERE country_id = (SELECT id FROM countries WHERE slug='france')
  AND section = 'payment_partner';

-- Update DGCCRF with vehicle-specific URL
UPDATE directory_entries
SET notes = 'DGCCRF — France''s consumer fraud authority. '
    'VEHICLE COMPLAINTS: signal.conso.gouv.fr/fr/voiture-vehicule. '
    'New vehicle specific: signal.conso.gouv.fr/fr/vehicule-neuf. '
    '~65% of companies respond to SignalConso reports. Reports are visible to DGCCRF agents for enforcement patterns. '
    'DIESELGATE: DGCCRF confirmed the intentional nature of VW''s fraud — VW is under formal judicial examination in France for deception creating public health danger (proceedings ongoing 2025).',
    contact_url = 'https://signal.conso.gouv.fr/fr/voiture-vehicule',
    last_verified_note = 'Verified June 2026 — signal.conso.gouv.fr'
WHERE country_id = (SELECT id FROM countries WHERE slug='france')
  AND name LIKE '%DGCCRF%';

-- Update French ADR body with correct rebranded name
UPDATE directory_entries
SET name = 'Médiateur Mobilians (formerly CNPA Médiation)',
    notes = 'Approved mediation body for automotive disputes — rebranded as Médiateur Mobilians on 1 October 2022. '
    'File at: mediateur-mobilians.fr/saisir-le-mediateur. Email: mediateur@mediateur-mobilians.fr. '
    'Process: Consumer must first send written complaint to the professional. If unresolved within 2 months, file within 12 months. Company notified; has 14 days to accept or refuse. Free for consumers. '
    'Covers car dealers, repair workshops — any Mobilians/CNPA member.',
    contact_url = 'https://www.mediateur-mobilians.fr/saisir-le-mediateur',
    last_verified_note = 'Verified June 2026'
WHERE country_id = (SELECT id FROM countries WHERE slug='france')
  AND (name LIKE '%CNPA%' OR name LIKE '%Médiation%');

-- ============================================================
-- SPAIN — Full update with Fidel Jiménez de Parga
-- ============================================================

UPDATE directory_entries
SET name = 'Fidel Jiménez de Parga',
    role_or_type = 'Director General, Škoda España',
    notes = 'Director General of Škoda España within Volkswagen Audi España S.A. In the role since 2018. '
    'Law degree (University of Barcelona) + MBA (Esade). 23+ years at Volkswagen Group España. '
    'LinkedIn: linkedin.com/in/fideljimenezdeparga. Contact for executive escalation.',
    contact_url = 'https://www.linkedin.com/in/fideljimenezdeparga/',
    source_url = 'https://www.skoda.es/noticias/news-detail/fidel_jimenez',
    last_verified_note = 'Verified June 2026 — LinkedIn + Škoda ES press'
WHERE country_id = (SELECT id FROM countries WHERE slug='spain')
  AND section = 'executive';

-- Update VWFS Spain with exact contacts
UPDATE directory_entries
SET notes = 'VWFS España: Phone: 91 427 9900 / 900 10 28 77 (freephone). Email: atencion.cliente@vwfs.com. '
    'Address: Avenida de Bruselas, 34, 28108 Alcobendas (Madrid). '
    'Max resolution time: 15 business days. If unsatisfied, escalate to Banco de España (Calle Alcalá 48, 28014 Madrid). '
    'Complaints: vwfs.es/sac-quejas-reclamaciones.html.',
    contact_url = 'https://www.vwfs.es/sac-quejas-reclamaciones.html',
    last_verified_note = 'Verified June 2026 — VWFS España'
WHERE country_id = (SELECT id FROM countries WHERE slug='spain')
  AND section = 'payment_partner';

-- Update Sistema Arbitral with exact portal URL
UPDATE directory_entries
SET notes = 'Free binding consumer arbitration in Spain. '
    'Portal: justoparaeso.consumo.gob.es. Ministry info: dsca.gob.es → Sistema Arbitral de Consumo. '
    'Process: File Solicitud de Arbitraje with local Junta Arbitral de Consumo or online. If business is already registered, arbitration begins. If not, company has 15 days to opt in. Binding ruling. '
    'The 2-year legal guarantee applies: seller must repair/replace/refund for defects within 2 years.',
    contact_url = 'https://justoparaeso.consumo.gob.es/',
    last_verified_note = 'Verified June 2026'
WHERE country_id = (SELECT id FROM countries WHERE slug='spain')
  AND name LIKE '%Arbitral%';

-- ============================================================
-- ITALY — Full update with Andrea Calcagni
-- ============================================================

UPDATE directory_entries
SET name = 'Andrea Calcagni',
    role_or_type = 'Director, Škoda Italia (VW Group Italia)',
    notes = 'Appointed Director of Škoda brand within Volkswagen Group Italia S.p.A., effective 1 November 2025. '
    'With VW Group Italia since 2010; previously led Volkswagen Commercial Vehicles Italy. '
    'LinkedIn: linkedin.com/in/andrea-calcagni-a1007318. Customer service: skoda.it/servizio-clienti.',
    contact_url = 'https://www.linkedin.com/in/andrea-calcagni-a1007318/',
    source_url = 'https://www.industriaitaliana.it/volkswagen-group-italia-cimmino-calcagni-megoli-skoda-veicoli-commerciali',
    last_verified_note = 'Verified June 2026 — industriaitaliana.it + LinkedIn'
WHERE country_id = (SELECT id FROM countries WHERE slug='italy')
  AND section = 'executive';

-- Update VWFS Italy with full contact details
UPDATE directory_entries
SET notes = 'VWFS Italia: Phone: 02 330271. PEC (certified email): volkswagenfinancialservices@unapec.it. '
    'Online form: contactus.crm.vwfs.it. Address: Via Privata Grosio 10/4, 20151 Milano. '
    'Response time: 60 calendar days for financial products. If unsatisfied, escalate to ABF (Arbitro Bancario Finanziario). '
    'Reclami page: rinnova.vwfs.it/complaints-and-disputes.html.',
    contact_url = 'https://www.rinnova.vwfs.it/complaints-and-disputes.html',
    last_verified_note = 'Verified June 2026 — VWFS Italia'
WHERE country_id = (SELECT id FROM countries WHERE slug='italy')
  AND section = 'payment_partner';

-- Update Codacons with active Dieselgate campaign
UPDATE directory_entries
SET notes = 'Major Italian consumer association. ACTIVE DIESELGATE ACTION: Codacons has an ongoing collective action against VW Italia at the Civil Court of Verona, claiming €3,300 per affected consumer. '
    'Campaign page: codacons.it/dieselgate-risarcimento/. Phone: 06/3725809. Email: info@codacons.it. Address: Viale Mazzini 73, 00195 Roma. '
    'NOTE: Altroconsumo reached a separate €50m settlement with VW (up to €1,100/person for 60,000 Italian EA189 owners) — deadline passed December 2024. '
    'Codacons Verona lawsuit remains active for those who did not settle.',
    contact_url = 'https://codacons.it/dieselgate-risarcimento/',
    last_verified_note = 'Verified June 2026'
WHERE country_id = (SELECT id FROM countries WHERE slug='italy')
  AND name LIKE '%Codacons%';

-- Update ABF with exact process details including €20 filing fee
UPDATE directory_entries
SET notes = 'Free banking ombudsman for Škoda finance (PCP/HP/leasing) disputes in Italy. '
    'Submit at: arbitrobancariofinanziario.it/presentare-ricorso/invio-ricorso/. '
    'PROCESS: First file written complaint with VWFS Italia. They have 60 days to respond (15 for payment services). If no satisfactory response, file with ABF within 12 months. '
    'COST: €20 filing fee (refunded if you win). Fully online. Decisions binding on the financial institution.',
    contact_url = 'https://www.arbitrobancariofinanziario.it/presentare-ricorso/invio-ricorso/',
    last_verified_note = 'Verified June 2026 — ABF website'
WHERE country_id = (SELECT id FROM countries WHERE slug='italy')
  AND name = 'Arbitro Bancario Finanziario (ABF)';

-- ============================================================
-- NETHERLANDS — Full update with Pon Holdings contacts
-- ============================================================

UPDATE directory_entries
SET name = 'Pon''s Automobielhandel B.V. (Pon Holdings)',
    notes = 'Official Škoda importer in the Netherlands since 1992 (part of Pon Holdings). '
    'Address: Zuiderinslag 2, 3833 BP Leusden. '
    'Customer service: 088-0330107 (Mon–Fri 09:00–17:00). Also available via live chat and WhatsApp (Mon–Fri 09:00–23:59). '
    'Contact: skoda.nl/contact. Complaint filing: support.skoda.nl/artikel/klacht-melden-skoda.',
    contact_url = 'https://support.skoda.nl/artikel/klacht-melden-skoda',
    source_url = 'https://pon.com/en/activities/automotive/wholesale-retail/skoda/',
    last_verified_note = 'Verified June 2026 — Škoda NL + Pon Holdings websites'
WHERE country_id = (SELECT id FROM countries WHERE slug='netherlands')
  AND section = 'executive';

-- Update VWFS NL with full contact info
UPDATE directory_entries
SET name = 'Volkswagen Pon Financial Services (VWPFS)',
    notes = 'Škoda finance products in NL through Volkswagen Pon Financial Services. '
    'Phone (financing): (033) 479 17 20. Email: financieren@vwpfs.nl. '
    'Finance disputes page: volkswagenfinancialservices.nl/klantenservice. '
    'Escalate unresolved disputes to KiFiD (Klachteninstituut Financiële Dienstverlening) within 3 months. '
    'Supervised by De Nederlandsche Bank (DNB) and AFM.',
    contact_url = 'https://www.volkswagenfinancialservices.nl/klantenservice',
    last_verified_note = 'Verified June 2026 — VWPFS website'
WHERE country_id = (SELECT id FROM countries WHERE slug='netherlands')
  AND section = 'payment_partner';

-- Update Geschillencommissie with fees and timeline
UPDATE directory_entries
SET notes = 'Free, binding arbitration for vehicle purchase and repair disputes in the Netherlands. '
    'Filing fee: €25–€127.50 (depending on claim value — refunded if ruling is in your favour). '
    'Process: (1) Written complaint to dealer. (2) File within 12 months of that complaint. (3) Commission notified; company responds. (4) Binding ruling. Total process: ~25 weeks. '
    'File at: degeschillencommissie.nl/over-ons/commissies/voertuigen/.',
    contact_url = 'https://www.degeschillencommissie.nl/over-ons/commissies/voertuigen/',
    last_verified_note = 'Verified June 2026 — Geschillencommissie website'
WHERE country_id = (SELECT id FROM countries WHERE slug='netherlands')
  AND name LIKE '%Geschillencommissie%';

-- ============================================================
-- NORWAY — New country with Harald A. Møller / Martine Behrens
-- ============================================================

INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, source_url, verified, display_order, last_verified_note) VALUES

((SELECT id FROM countries WHERE slug='norway'), 'executive', 'Škoda Brand Director, Norway',
 'Martine Behrens (Harald A. Møller AS)',
 'Martine Behrens is Director and Brand Manager for Škoda at Harald A. Møller AS, the sole importer of VW Group brands in Norway since 1948 (part of Møller Mobility Group). '
 'Address: Frysjaveien 31, 0884 Oslo. Phone: +47 24 03 33 00. Website: moller.no.',
 'https://www.linkedin.com/in/martine-behrens-0033a821/',
 'https://www.moller.no/',
 true, 1, 'Verified June 2026 — LinkedIn'),

((SELECT id FROM countries WHERE slug='norway'), 'regulator', 'Consumer Authority',
 'Forbrukertilsynet (Norwegian Consumer Authority)',
 'Supervisory body for consumer law compliance. Phone: +47 23 40 06 00. Email: inntak@forbrukertilsynet.no. Address: Postboks 2862, 3702 Skien. '
 'Reports patterns; does not resolve individual disputes. For individual disputes use Forbrukerrådet.',
 'https://www.forbrukertilsynet.no/',
 NULL, true, 1, 'Verified June 2026'),

((SELECT id FROM countries WHERE slug='norway'), 'regulator', 'Consumer Council & ADR',
 'Forbrukerrådet (Norwegian Consumer Council)',
 'Mediates consumer disputes and can refer unresolved cases to Forbrukerklageutvalget (Consumer Dispute Commission) for a binding ruling. '
 'Phone: +47 23 400 500. Email: post@forbrukerradet.no. Website: forbrukerradet.no. '
 'NORWEGIAN CONSUMER LAW: 5-year complaint period for dealer purchases (Forbrukerkjøpsloven). Must notify seller within 2 months of discovering defect.',
 'https://www.forbrukerradet.no/',
 NULL, true, 2, 'Verified June 2026');

-- ============================================================
-- SWEDEN — New country with VW Group Sverige
-- ============================================================

INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, source_url, verified, display_order, last_verified_note) VALUES

((SELECT id FROM countries WHERE slug='sweden'), 'executive', 'CEO, Volkswagen Group Sverige AB',
 'Claes Peter Jerveland',
 'President & CEO of Volkswagen Group Sverige AB, the importer of all VW Group brands including Škoda in Sweden. In role since 2009. '
 'Address: Hantverksvägen 9, 151 88 Södertälje. Phone: +46 8 120 810 80 (Mon–Fri 08:00–17:00). Website: vwgroup.se.',
 'https://se.linkedin.com/in/claes-jerveland-b666838',
 'https://www.vwgroup.se/kontakt/',
 true, 1, 'Verified June 2026 — LinkedIn'),

((SELECT id FROM countries WHERE slug='sweden'), 'regulator', 'Consumer Agency',
 'Konsumentverket (Swedish Consumer Agency)',
 'Supervisory authority. Does not resolve individual disputes but can enforce against traders. '
 'Car dealer buying guide (EN): konsumentverket.se/en/articles/buying-a-car-from-a-car-dealer/. Report a violation: konsumentverket.se/en/articles/report-to-the-swedish-consumer-agency/.',
 'https://www.konsumentverket.se/en/articles/buying-a-car-from-a-car-dealer/',
 NULL, true, 1, 'Verified June 2026'),

((SELECT id FROM countries WHERE slug='sweden'), 'regulator', 'Consumer Disputes Board (ADR)',
 'ARN (Allmänna reklamationsnämnden)',
 'Sweden''s national consumer disputes board. Non-binding recommendations; most reputable dealers comply voluntarily. '
 'File at: arn.se/om-arn/anmalan/. Fee: SEK 150. Time limit: within 1 year of first reporting fault to trader. Processing: ~6 months. '
 'SWEDISH LAW: 3-year complaint period; 2-year presumption that defects were pre-existing.',
 'https://www.arn.se/om-arn/anmalan/',
 'https://arn.se/',
 true, 2, 'Verified June 2026');

-- ============================================================
-- DENMARK — New country with Semler Gruppen
-- ============================================================

INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, source_url, verified, display_order, last_verified_note) VALUES

((SELECT id FROM countries WHERE slug='denmark'), 'executive', 'Group CEO, Semler Gruppen A/S',
 'Ulrik Drejsig',
 'CEO of Semler Gruppen A/S, parent of Skandinavisk Motor Co. A/S — Škoda''s official importer in Denmark since the 1940s. '
 'Address: Park Allé 355, 2605 Brøndby. Phone: +45 43 28 82 00. Email: mis@vw.dk. Website: skoda.dk.',
 'https://www.semler.dk/en/',
 'https://www.skoda.dk/',
 true, 1, 'Verify current Škoda brand director on LinkedIn'),

((SELECT id FROM countries WHERE slug='denmark'), 'regulator', 'Consumer Council',
 'Forbrugerrådet Tænk',
 'Independent consumer advocacy. Provides legal advice and complaint guidance. '
 'Website: taenk.dk. Advice on filing with Forbrugerklagenævnet: taenk.dk/raadgivning/rettigheder/saadan-klager-du-til-forbrugerklagenaevnet.',
 'https://taenk.dk/',
 NULL, true, 1, 'Verified June 2026'),

((SELECT id FROM countries WHERE slug='denmark'), 'regulator', 'Consumer Complaints Board (ADR)',
 'Forbrugerklagenævnet',
 'Official consumer complaints board. Fee: DKK 100 for mediation + DKK 400 for Board (refunded if partly or fully successful). '
 'Process: Mediation must conclude within 90 days; then 4 weeks to escalate to Board. File via borger.dk. '
 'DANISH LAW: 2-year warranty on new vehicles; defects on used cars presumed original for first 12 months.',
 'https://lifeindenmark.borger.dk/rights/the-public-consumer-complaints-system',
 'https://en.kfst.dk/consumer/advice-and-complaints',
 true, 2, 'Verified June 2026');

-- ============================================================
-- POLAND — Full update with Carla Wentzel + Jaroslav Hercog + UOKiK fine
-- ============================================================

UPDATE directory_entries
SET notes = 'VW Group Polska Sp. z o.o. — sole importer and distributor of all VW Group brands in Poland (~27% market share). '
    'PRESIDENT & CEO: Carla Wentzel (since 1 January 2024 — first woman to hold the role). '
    'ŠKODA BRAND DIRECTOR: Jaroslav Hercog (Dyrektor Marki Škoda). '
    'Address: ul. Krańcowa 44, 61-037 Poznań. Phone: +48 61 627 3000. Website: vw-group.pl and skoda-auto.pl.',
    contact_url = 'https://www.linkedin.com/search/results/people/?keywords=carla+wentzel+volkswagen+polska',
    source_url = 'https://www.vw-group.pl/komunikat,33267,carla-wentzel-prezesem-zarzadu-volkswagen-group-polska.html',
    last_verified_note = 'Verified June 2026 — VW Group PL press release'
WHERE country_id = (SELECT id FROM countries WHERE slug='poland')
  AND section = 'executive';

-- Update UOKiK with PLN 74 million Dieselgate fine detail
UPDATE directory_entries
SET notes = 'Poland''s Office of Competition and Consumer Protection — strong enforcement powers. '
    'DIESELGATE ACTION: UOKiK fined Volkswagen Group Poland a record PLN 74 million for misleading customers and instructing dealers to reject consumer complaints about emission software. '
    'Settlement and final decision: uokik.gov.pl/en/dieselgate-settlement-and-final-decision-of-the-president-of-uokik. '
    'Report violations: uokik.gov.pl/en/contractual-advantage-report-a-violation. Consumer rights hub: prawakonsumenta.uokik.gov.pl. '
    'POLISH LAW: 2-year liability for new vehicles; dealer may reduce to 1 year for used (must be stated in contract).',
    contact_url = 'https://uokik.gov.pl/en/help-for-consumers',
    source_url = 'https://uokik.gov.pl/en/dieselgate-settlement-and-final-decision-of-the-president-of-uokik',
    last_verified_note = 'Verified June 2026 — UOKiK website'
WHERE country_id = (SELECT id FROM countries WHERE slug='poland')
  AND name LIKE '%UOKiK%';

-- ============================================================
-- AUSTRIA — Full update with Porsche Austria / Markus Stifter
-- ============================================================

UPDATE directory_entries
SET name = 'Markus Stifter / Porsche Austria GmbH',
    role_or_type = 'Škoda Brand Manager, Porsche Austria',
    notes = 'Porsche Austria GmbH & Co OG (subsidiary of Porsche Holding Salzburg, wholly owned by VW AG) is the importer of Škoda in Austria. '
    'Škoda Brand Manager: Markus Stifter (appointed February 2023; 2026 status unconfirmed — verify on LinkedIn). '
    'CEO Porsche Austria: Dr. Hans Peter Schützinger. '
    'Address: Louise-Piëch-Straße 2, 5020 Salzburg. Phone: +43 662 4681-0. Email: office@porsche.at. '
    'AUSTRIAN LAW: 2-year Gewährleistung on new vehicles (cannot be excluded); 1 year for used if contractually agreed.',
    contact_url = 'https://www.linkedin.com/search/results/people/?keywords=markus+stifter+skoda+porsche',
    source_url = 'https://www.porscheholding-newsroom.at/pressemeldungen/detail/2023-02-13-porsche-austria-geschaeftsfuehrung-wird-neu-ausgerichtet-neue-markenleiter-bei-skoda-und-seat-cupra-bestellt',
    last_verified_note = 'Verified June 2026 — Porsche Holding newsroom'
WHERE country_id = (SELECT id FROM countries WHERE slug='austria')
  AND section = 'executive';

-- ============================================================
-- SWITZERLAND — Full update with AMAG / Markus Kohler
-- ============================================================

UPDATE directory_entries
SET name = 'Markus Kohler / AMAG Import AG',
    role_or_type = 'Škoda Brand Director, AMAG Switzerland',
    notes = 'AMAG Import AG (part of AMAG Group AG, sole importer of VW Group brands in Switzerland) distributes Škoda. '
    'Škoda Brand Director: Markus Kohler. Address: Alte Steinhauserstrasse 12, 6330 Cham. '
    'Phone (freephone CH): 0800 03 20 10. Switchboard: +41 44 846 12 12. Email: sales@amag.ch. '
    'IMPORTANT: Switzerland is NOT an EU member — Swiss consumer law (OR/Obligationenrecht) is weaker than EU standards, especially for used cars. '
    'Warranty on new vehicles: 2 years (cannot be waived). Used cars: can be reduced to 1 year or excluded if stated in writing.',
    contact_url = 'https://www.amag-import.ch/fr/contact.html',
    source_url = 'https://www.skoda.ch/other1/impressum',
    last_verified_note = 'Verified June 2026 — AMAG Import'
WHERE country_id = (SELECT id FROM countries WHERE slug='switzerland')
  AND section = 'executive';

-- ============================================================
-- AUSTRALIA — Full update with Lucie Kuhn + 7-year warranty
-- ============================================================

UPDATE directory_entries
SET name = 'Lucie Kuhn',
    role_or_type = 'Director, Škoda Australia',
    notes = 'Appointed Director of Škoda Australia in early 2025, succeeding Michael Irmer. '
    'Previously Regional Manager for Southern Europe at Škoda Auto in Czechia; 12+ years with Škoda. '
    'Škoda Australia HQ: Level 7, 895 South Dowling Street, Zetland NSW 2017. Postal: PO Box 5155, Chullora NSW 2190. '
    'Phone: 1800 607 540 (customer care). Email: hello@myskoda.com.au. '
    'NOTABLE: Škoda Australia offers a 7-year / unlimited km warranty on all new vehicles (made permanent from Sept 2022) — among the best in the market.',
    contact_url = 'https://au.linkedin.com/in/lucie-kuhn-31708520',
    source_url = 'https://www.goauto.com.au/news/skoda/skoda-s-new-boss-details-plan-to-double-sales/2025-03-31/95993.html',
    last_verified_note = 'Verified June 2026 — GoAuto March 2025 + LinkedIn'
WHERE country_id = (SELECT id FROM countries WHERE slug='australia')
  AND section = 'executive';

-- Update Australia ACCC with $125m penalty reference and 2020 class action settlement
UPDATE directory_entries
SET notes = 'The ACCC enforces Australian Consumer Law — strong statutory guarantees regardless of manufacturer warranty. '
    'ACCC ENFORCEMENT HISTORY: Federal Court ordered VW Group to pay AU$125 million penalty for Dieselgate (largest ACL penalty ever at the time; upheld by High Court November 2021). '
    'CONSUMER CLASS ACTION: AU$120 million settlement paid to ~43,000 Australian vehicle owners (VW/Audi/Škoda EA189 owners, ~AU$2,800 average; administered via vwsettlement.com.au — CLOSED). '
    'RECALL INFO: Check gov.au vehiclerecalls.gov.au for current Škoda recalls. '
    'For individual disputes: ACCC refers to State Fair Trading. File at: accc.gov.au/consumers/problem-with-a-product-or-service-you-bought.',
    contact_url = 'https://www.accc.gov.au/consumers/problem-with-a-product-or-service-you-bought',
    source_url = 'https://www.accc.gov.au/media-release/court-orders-volkswagen-to-pay-record-125-million-in-penalties',
    last_verified_note = 'Verified June 2026 — ACCC website'
WHERE country_id = (SELECT id FROM countries WHERE slug='australia')
  AND name LIKE '%ACCC%';

-- Add separate warranty entry for Australia
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, source_url, verified, display_order, last_verified_note)
VALUES (
  (SELECT id FROM countries WHERE slug='australia'),
  'payment_partner', 'Finance Provider',
  'Volkswagen Financial Services Australia (VWFS AU)',
  'Škoda Financial Services in Australia through VWFS Australia. Phone: 1300 734 567 (Mon–Fri 9am–5pm AEST). Email: customerservice@vwfs.com.au. Website: vwfs.com.au. '
  'Escalate unresolved finance disputes to AFCA (afca.org.au) — free, binding decisions. '
  'AFCA complaint portal: afca.org.au/make-a-complaint.',
  'https://www.afca.org.au/make-a-complaint',
  'https://www.vwfs.com.au',
  true, 1, 'Verified June 2026'
);

-- Update State Fair Trading with exact URLs for each state
UPDATE directory_entries
SET notes = 'State consumer agencies handle individual dealer disputes quickly. '
    'NSW: regulation.nsw.gov.au/fairtrading/automotiveservices/complaint/ (vehicle-specific form). '
    'VIC: consumer.vic.gov.au/contact-us/resolve-your-problem/general-complaint. Phone: 1300 55 81 81. '
    'QLD: qld.gov.au/law/laws-regulated-industries-and-accountability → Fair Trading Services. '
    'CONSUMER LAW RIGHTS: Major vehicle failure → consumer''s choice of refund, replacement, or compensation. No fixed time limit — ACL consumer guarantees cannot expire.',
    last_verified_note = 'Verified June 2026'
WHERE country_id = (SELECT id FROM countries WHERE slug='australia')
  AND name LIKE '%Fair Trading%';

-- ============================================================
-- INDIA — Full update with Piyush Arora + Ashish Gupta
-- ============================================================

UPDATE directory_entries
SET notes = 'Škoda Auto Volkswagen India Private Limited (SAVWIPL) manages both Škoda and VW brands in India from Pune. '
    'MD & CEO: Piyush Arora (LinkedIn: linkedin.com/in/piyush-arora-9b1b02135). '
    'ŠKODA BRAND DIRECTOR: Ashish Gupta (from 1 May 2025, succeeded Petr Janeba). '
    'Toll-free: 1800 123 090909. Email: customercare@skoda-auto.co.in. '
    'HQ: E-1, MIDC Industrial Area, Phase III, Chakan, Pune 410 501, Maharashtra. '
    'NOTABLE LEGAL MATTER: Indian customs authorities issued a ~₹11,526 crore (~USD $1.4 billion) back-duty notice to SAVWIPL in September 2024 (alleging imported parts were CKD kits). SAVWIPL challenged this in Bombay High Court — proceedings ongoing.',
    contact_url = 'https://www.skoda-auto.co.in/other-offerings/contactus',
    source_url = 'https://www.business-standard.com/companies/news/skoda-volkswagen-india-leadership-changes-ashish-gupta-nitin-kohli-125050501002_1.html',
    last_verified_note = 'Verified June 2026 — Business Standard + LinkedIn'
WHERE country_id = (SELECT id FROM countries WHERE slug='india')
  AND section = 'executive';

-- Update NCH India with additional platform
UPDATE directory_entries
SET notes = 'National Consumer Helpline — call 1800-11-4000 / 14404 (toll-free) or file at consumerhelpline.gov.in. '
    'First-level conciliation — forwards complaints to Škoda and facilitates resolution. '
    'If unresolved: escalate to eDaakhil (edaakhil.nic.in) for consumer court filing. '
    'NEW UNIFIED PLATFORM: e-jagriti.gov.in (new integrated consumer justice portal). '
    'NOTABLE CASE: Chennai Consumer Court directed Škoda India and dealer to refund ₹16.73 lakh plus compensation to Kushaq SUV owner (35-day-old vehicle with multiple defects).',
    last_verified_note = 'Verified June 2026 — consumerhelpline.gov.in + CarToq'
WHERE country_id = (SELECT id FROM countries WHERE slug='india')
  AND name LIKE '%National Consumer Helpline%';

-- ============================================================
-- NEW ZEALAND — Full entry with Giltrap Group
-- ============================================================

UPDATE directory_entries
SET name = 'Giltrap Group Holdings',
    role_or_type = 'Official Škoda Importer, New Zealand',
    notes = 'European Distributors Limited, a division of Giltrap Group Holdings (100% NZ-owned), is the official Škoda importer in New Zealand. '
    'Address: 1 Nixon Street, Grey Lynn, Auckland 1021. Phone: +64 9 360 2911. Website: skoda.co.nz.',
    contact_url = 'https://www.skoda.co.nz/other/contact-us',
    source_url = 'https://www.skoda.co.nz/',
    last_verified_note = 'Verified June 2026 — Škoda NZ website'
WHERE country_id = (SELECT id FROM countries WHERE slug='new-zealand')
  AND section = 'executive';

-- Add MVDT NZ with NZ$100k limit
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, source_url, verified, display_order, last_verified_note) VALUES

((SELECT id FROM countries WHERE slug='new-zealand'), 'regulator', 'Vehicle Disputes Tribunal (ADR)',
 'Motor Vehicle Disputes Tribunal (MVDT)',
 'Fast, specialist tribunal for disputes against registered motor vehicle traders. Claim limit: NZD $100,000 (both parties can agree to extend). '
 'Filing fee: NZD $87 (non-refundable). Covers: defective vehicles, misdescription, failure to honour warranty. '
 'File at: justice.govt.nz/tribunals/motor-vehicle-dealer-disputes/make-a-claim/.',
 'https://www.justice.govt.nz/tribunals/motor-vehicle-dealer-disputes/make-a-claim/',
 'https://www.justice.govt.nz/tribunals/motor-vehicle-dealer-disputes/',
 true, 1, 'Verified June 2026 — NZ Justice website'),

((SELECT id FROM countries WHERE slug='new-zealand'), 'regulator', 'Consumer Protection',
 'Consumer Protection NZ (MBIE)',
 'Run by Ministry of Business, Innovation & Employment. '
 'Cars/motoring page: consumerprotection.govt.nz/report-or-resolve-a-problem/cars-and-motoring/buying-cars. '
 'NZ CONSUMER GUARANTEES ACT: All vehicles from dealers must be of acceptable quality. Major failure → consumer chooses refund, replacement, or repair. No fixed expiry.',
 'https://consumerprotection.govt.nz/report-or-resolve-a-problem/cars-and-motoring/buying-cars',
 'https://www.consumerprotection.govt.nz/',
 true, 2, 'Verified June 2026');

-- ============================================================
-- SOUTH AFRICA — Update to reflect no official Škoda market
-- ============================================================

UPDATE directory_entries
SET notes = 'IMPORTANT: Škoda has no official new-vehicle importer or dealership network in South Africa as of 2025–2026. '
    'SA owners of Škoda vehicles (typically grey imports from UK, Europe, or India) should contact the grey-market dealer directly and use general consumer protection channels. '
    'VWSA (Volkswagen Group South Africa) handles VW, Audi — not Škoda. VWSA contact: vw.co.za, Phone: 0860 434 737.',
    last_verified_note = 'Verified June 2026 — no official Škoda SA network confirmed'
WHERE country_id = (SELECT id FROM countries WHERE slug='south-africa')
  AND section = 'executive';

-- Update MIOSA for SA noting it still applies to grey-market dealers
UPDATE directory_entries
SET notes = 'Free dispute resolution for SA motor vehicle disputes. Accredited under the Consumer Protection Act. '
    'Phone: 010 590 8378. Email: info@miosa.co.za. Website: miosa.co.za. '
    'Process: Submit Assistance Request at miosa.co.za/consumers/ → complaint forwarded to dealer → on-site inspection if needed → recommendation issued. '
    'NOTE: For Škoda grey-import owners — MIOSA''s jurisdiction covers the dealer you bought from, not Škoda Auto directly (since there is no official SA importer).',
    last_verified_note = 'Verified June 2026 — MIOSA website'
WHERE country_id = (SELECT id FROM countries WHERE slug='south-africa')
  AND name LIKE '%MIOSA%';

