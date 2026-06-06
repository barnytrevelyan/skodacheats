-- ============================================================
-- Directory Expansion: 40+ countries
-- Run AFTER supabase-directory-migration.sql
-- ============================================================

-- ── Add new countries ────────────────────────────────────────
INSERT INTO countries (region_id, name, slug, flag_emoji, currency_code) VALUES
  -- Europe
  ((SELECT id FROM regions WHERE slug='europe'), 'Netherlands',    'netherlands',    '🇳🇱', 'EUR'),
  ((SELECT id FROM regions WHERE slug='europe'), 'Belgium',        'belgium',        '🇧🇪', 'EUR'),
  ((SELECT id FROM regions WHERE slug='europe'), 'Sweden',         'sweden',         '🇸🇪', 'SEK'),
  ((SELECT id FROM regions WHERE slug='europe'), 'Norway',         'norway',         '🇳🇴', 'NOK'),
  ((SELECT id FROM regions WHERE slug='europe'), 'Denmark',        'denmark',        '🇩🇰', 'DKK'),
  ((SELECT id FROM regions WHERE slug='europe'), 'Austria',        'austria',        '🇦🇹', 'EUR'),
  ((SELECT id FROM regions WHERE slug='europe'), 'Poland',         'poland',         '🇵🇱', 'PLN'),
  ((SELECT id FROM regions WHERE slug='europe'), 'Portugal',       'portugal',       '🇵🇹', 'EUR'),
  ((SELECT id FROM regions WHERE slug='europe'), 'Czech Republic', 'czech-republic', '🇨🇿', 'CZK'),
  ((SELECT id FROM regions WHERE slug='europe'), 'Romania',        'romania',        '🇷🇴', 'RON'),
  ((SELECT id FROM regions WHERE slug='europe'), 'Turkey',         'turkey',         '🇹🇷', 'TRY'),
  -- Asia Pacific
  ((SELECT id FROM regions WHERE slug='asia-pacific'), 'Philippines',    'philippines',    '🇵🇭', 'PHP'),
  ((SELECT id FROM regions WHERE slug='asia-pacific'), 'Thailand',       'thailand',       '🇹🇭', 'THB'),
  ((SELECT id FROM regions WHERE slug='asia-pacific'), 'Taiwan',         'taiwan',         '🇹🇼', 'TWD'),
  ((SELECT id FROM regions WHERE slug='asia-pacific'), 'Hong Kong',      'hong-kong',      '🇭🇰', 'HKD'),
  ((SELECT id FROM regions WHERE slug='asia-pacific'), 'Pakistan',       'pakistan',       '🇵🇰', 'PKR'),
  ((SELECT id FROM regions WHERE slug='asia-pacific'), 'Bangladesh',     'bangladesh',     '🇧🇩', 'BDT'),
  ((SELECT id FROM regions WHERE slug='asia-pacific'), 'Sri Lanka',      'sri-lanka',      '🇱🇰', 'LKR'),
  ((SELECT id FROM regions WHERE slug='asia-pacific'), 'Malaysia',       'malaysia',       '🇲🇾', 'MYR'),
  -- Latin America
  ((SELECT id FROM regions WHERE slug='latin-america'), 'Peru',      'peru',      '🇵🇪', 'PEN'),
  ((SELECT id FROM regions WHERE slug='latin-america'), 'Argentina', 'argentina', '🇦🇷', 'ARS'),
  ((SELECT id FROM regions WHERE slug='latin-america'), 'Ecuador',   'ecuador',   '🇪🇨', 'USD'),
  -- Middle East
  ((SELECT id FROM regions WHERE slug='middle-east'), 'Kuwait', 'kuwait', '🇰🇼', 'KWD'),
  ((SELECT id FROM regions WHERE slug='middle-east'), 'Qatar',  'qatar',  '🇶🇦', 'QAR'),
  ((SELECT id FROM regions WHERE slug='middle-east'), 'Jordan', 'jordan', '🇯🇴', 'JOD'),
  ((SELECT id FROM regions WHERE slug='middle-east'), 'Lebanon','lebanon','🇱🇧', 'LBP'),
  -- Africa
  ((SELECT id FROM regions WHERE slug='africa'), 'Tanzania',      'tanzania',      '🇹🇿', 'TZS'),
  ((SELECT id FROM regions WHERE slug='africa'), 'Uganda',        'uganda',        '🇺🇬', 'UGX'),
  ((SELECT id FROM regions WHERE slug='africa'), 'Ivory Coast',   'ivory-coast',   '🇨🇮', 'XOF'),
  ((SELECT id FROM regions WHERE slug='africa'), 'Senegal',       'senegal',       '🇸🇳', 'XOF')
ON CONFLICT (slug) DO NOTHING;


-- ============================================================
-- FILL GAPS IN EXISTING COUNTRIES
-- ============================================================

-- ── Ireland ─────────────────────────────────────────────────
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, display_order) VALUES
  ((SELECT id FROM countries WHERE slug='ireland'), 'payment_partner', 'Payment Processor',
   'Adyen',
   'Uber Eats Ireland processes card payments via Adyen. Contact your bank (AIB, Bank of Ireland, Ulster Bank) to initiate a chargeback for unresolved disputes.',
   'https://www.adyen.com', 1),
  ((SELECT id FROM countries WHERE slug='ireland'), 'regulator', 'Consumer Protection',
   'Competition and Consumer Protection Commission (CCPC)',
   'Ireland''s main consumer protection body. File complaints about misleading refund practices or unfair billing.',
   'https://www.ccpc.ie/consumers/how-to-complain/', 1),
  ((SELECT id FROM countries WHERE slug='ireland'), 'regulator', 'Financial Regulator',
   'Central Bank of Ireland',
   'Regulates payment service providers operating in Ireland. Report unresolved payment disputes.',
   'https://www.centralbank.ie/consumer-hub/consumer-protection', 2),
  ((SELECT id FROM countries WHERE slug='ireland'), 'regulator', 'Financial Ombudsman',
   'Financial Services and Pensions Ombudsman (FSPO)',
   'Free, independent dispute resolution. If your bank refuses to process a legitimate chargeback, escalate to the FSPO.',
   'https://www.fspo.ie/make-a-complaint/', 3),
  ((SELECT id FROM countries WHERE slug='ireland'), 'regulator', 'EU Dispute Resolution',
   'European Online Dispute Resolution (ODR) Platform',
   'EU consumers can use the ODR platform for cross-border e-commerce disputes against Uber.',
   'https://ec.europa.eu/consumers/odr/', 4);

-- ── Italy ───────────────────────────────────────────────────
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, display_order) VALUES
  ((SELECT id FROM countries WHERE slug='italy'), 'payment_partner', 'Payment Processor',
   'Adyen / PayPal',
   'Uber Eats Italy uses Adyen for card transactions and accepts PayPal. For PayPal payments, open a dispute directly in the PayPal Resolution Centre. For card payments, contact your bank.',
   NULL, 1),
  ((SELECT id FROM countries WHERE slug='italy'), 'regulator', 'Consumer Protection',
   'Autorità Garante della Concorrenza e del Mercato (AGCM)',
   'Italy''s Antitrust and Consumer Protection Authority. File a complaint at agcm.it for systematic refund failures or deceptive practices.',
   'https://www.agcm.it', 1),
  ((SELECT id FROM countries WHERE slug='italy'), 'regulator', 'Consumer Association',
   'Codacons / Altroconsumo',
   'Major Italian consumer associations. Codacons has previously taken Uber to court. Contact them for legal support on systematic billing issues.',
   'https://www.codacons.it/segnalazioni/', 2),
  ((SELECT id FROM countries WHERE slug='italy'), 'regulator', 'Financial Ombudsman',
   'Arbitro Bancario Finanziario (ABF)',
   'Free banking ombudsman. If your bank refuses to reverse a disputed charge, escalate to ABF.',
   'https://arbitrobancariofinanziario.it', 3),
  ((SELECT id FROM countries WHERE slug='italy'), 'regulator', 'EU Dispute Resolution',
   'European ODR Platform',
   'EU consumers can raise cross-border disputes against Uber via the EU ODR platform.',
   'https://ec.europa.eu/consumers/odr/', 4);

-- ── Spain ───────────────────────────────────────────────────
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, display_order) VALUES
  ((SELECT id FROM countries WHERE slug='spain'), 'payment_partner', 'Payment Processor',
   'Adyen / Redsys',
   'Uber Eats Spain processes via Adyen and Redsys (the Spanish banking network). Contact your bank (CaixaBank, BBVA, Santander) to initiate a card dispute.',
   NULL, 1),
  ((SELECT id FROM countries WHERE slug='spain'), 'regulator', 'Consumer Protection',
   'Agencia Española de Consumo (AECOSAN / FACUA)',
   'File complaints at consumo.gob.es or via FACUA, Spain''s largest consumer advocacy group. FACUA has campaigned against Uber practices.',
   'https://www.facua.org/es/denuncia.php', 1),
  ((SELECT id FROM countries WHERE slug='spain'), 'regulator', 'Financial Regulator',
   'Banco de España — Servicio de Reclamaciones',
   'The Bank of Spain''s complaints service handles disputes involving payment service providers regulated in Spain.',
   'https://www.bde.es/bde/es/secciones/servicios/Particulares_y_e/Reclamaciones/', 2),
  ((SELECT id FROM countries WHERE slug='spain'), 'regulator', 'Regional Consumer Office',
   'Oficina Municipal de Información al Consumidor (OMIC)',
   'Every Spanish municipality has an OMIC. Visit your local OMIC to file a formal complaint — Uber must respond to government agencies.',
   'https://www.consumo.gob.es/es/cec/omic', 3);

-- ── Japan ───────────────────────────────────────────────────
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, display_order) VALUES
  ((SELECT id FROM countries WHERE slug='japan'), 'payment_partner', 'QR Code Payment',
   'PayPay',
   'PayPay is a major Uber Eats Japan payment method. Open a dispute in the PayPay app under "Transaction History." PayPay has a buyer protection policy.',
   'https://paypay.ne.jp', 1),
  ((SELECT id FROM countries WHERE slug='japan'), 'payment_partner', 'Credit Card Processing',
   'JCB / Visa / Mastercard via Stripe',
   'Card payments processed via Stripe. Contact your card issuer (JCB, MUFG, SMBC) to initiate a chargeback for unresolved disputes.',
   NULL, 2),
  ((SELECT id FROM countries WHERE slug='japan'), 'regulator', 'Consumer Protection',
   'National Consumer Affairs Center of Japan (NCAC)',
   'Japan''s national consumer complaints body. File complaints at kokusen.go.jp. NCAC advises on chargeback and legal remedies.',
   'https://www.kokusen.go.jp/ncac_index.html', 1),
  ((SELECT id FROM countries WHERE slug='japan'), 'regulator', 'Government Consumer Agency',
   'Consumer Affairs Agency (消費者庁)',
   'Japan''s cabinet-level consumer protection agency. Report systemic fraud, app deception, or systematic refusal to refund.',
   'https://www.caa.go.jp', 2),
  ((SELECT id FROM countries WHERE slug='japan'), 'regulator', 'Financial Regulator',
   'Financial Services Agency (金融庁)',
   'Regulates all payment service providers in Japan. Report unresolved payment processing disputes.',
   'https://www.fsa.go.jp/en/', 3);

-- ── Singapore ───────────────────────────────────────────────
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, display_order) VALUES
  ((SELECT id FROM countries WHERE slug='singapore'), 'payment_partner', 'Card & Digital Payments',
   'Stripe / PayNow',
   'Uber Eats Singapore processes via Stripe. PayNow transfers can be disputed via your bank. For card payments, initiate a chargeback through your bank (DBS, OCBC, UOB, Standard Chartered).',
   NULL, 1),
  ((SELECT id FROM countries WHERE slug='singapore'), 'regulator', 'Consumer Protection',
   'Consumers Association of Singapore (CASE)',
   'File a complaint at case.org.sg. CASE can mediate disputes and escalate to the Small Claims Tribunal on your behalf.',
   'https://www.case.org.sg/file_a_complaint.aspx', 1),
  ((SELECT id FROM countries WHERE slug='singapore'), 'regulator', 'Competition Authority',
   'Competition and Consumer Commission of Singapore (CCCS)',
   'Reports systematic unfair trade practices to CCCS at cccs.gov.sg.',
   'https://www.cccs.gov.sg/consumers/other-ways-to-seek-help', 2),
  ((SELECT id FROM countries WHERE slug='singapore'), 'regulator', 'Financial Regulator',
   'Monetary Authority of Singapore (MAS)',
   'Regulates all payment service providers in Singapore. File complaints about unresolved payment disputes at mas.gov.sg.',
   'https://www.mas.gov.sg/consumer-protection', 3),
  ((SELECT id FROM countries WHERE slug='singapore'), 'regulator', 'Small Claims Tribunal',
   'Small Claims Tribunals',
   'Fast, low-cost resolution for claims up to SGD $20,000. No lawyer needed. Uber must appear or settle.',
   'https://www.statecourts.gov.sg/cws/SmallClaims/Pages/Overview.aspx', 4);

-- ── New Zealand ─────────────────────────────────────────────
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, display_order) VALUES
  ((SELECT id FROM countries WHERE slug='new-zealand'), 'payment_partner', 'Card Processing',
   'Adyen / Stripe',
   'Uber Eats NZ processes via Adyen and Stripe. Under NZ Consumer Guarantees Act, you''re entitled to a refund for services not provided. Contact your bank (ANZ, ASB, BNZ, Westpac) for a chargeback.',
   NULL, 1),
  ((SELECT id FROM countries WHERE slug='new-zealand'), 'regulator', 'Consumer Protection',
   'Consumer Protection NZ (MBIE)',
   'File complaints at consumerprotection.govt.nz. Under the Consumer Guarantees Act and Fair Trading Act, Uber must provide remedies for service failures.',
   'https://www.consumerprotection.govt.nz/how-we-can-help/make-a-complaint/', 1),
  ((SELECT id FROM countries WHERE slug='new-zealand'), 'regulator', 'Commerce Commission',
   'Commerce Commission New Zealand',
   'Investigates systemic fair trading violations. File complaints for misleading refund policies or deceptive app behaviour.',
   'https://comcom.govt.nz/make-a-complaint', 2),
  ((SELECT id FROM countries WHERE slug='new-zealand'), 'regulator', 'Banking Ombudsman',
   'Banking Ombudsman Scheme',
   'If your bank refuses to process a chargeback, escalate free of charge to the Banking Ombudsman. Legally binding decisions.',
   'https://www.bankomb.org.nz/make-a-complaint/', 3),
  ((SELECT id FROM countries WHERE slug='new-zealand'), 'regulator', 'Disputes Tribunal',
   'Disputes Tribunal',
   'NZ''s small claims court for disputes up to NZD $30,000. Fast, informal, no lawyers required. Uber must respond.',
   'https://www.disputestribunal.govt.nz', 4);

-- ── Brazil ──────────────────────────────────────────────────
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, display_order) VALUES
  ((SELECT id FROM countries WHERE slug='brazil'), 'payment_partner', 'Instant Payment (PIX)',
   'PIX (Banco Central do Brasil)',
   'PIX transfers can be disputed via the "Mecanismo Especial de Devolução" (MED). Contact your bank and cite the transaction''s EndToEndId. Banks must investigate within 7 business days.',
   NULL, 1),
  ((SELECT id FROM countries WHERE slug='brazil'), 'payment_partner', 'Credit Card / Boleto',
   'Adyen / PagSeguro / Cielo',
   'Card disputes: contact your bank (Itaú, Bradesco, Nubank, BTG) to initiate a chargeback (contestação). Boleto issues: open a dispute with the issuing bank directly.',
   NULL, 2),
  ((SELECT id FROM countries WHERE slug='brazil'), 'regulator', 'Consumer Protection',
   'Procon / SENACON',
   'File at consumidor.gov.br — Uber is a registered company and must respond within 10 days. SENACON can apply administrative penalties.',
   'https://www.consumidor.gov.br', 1),
  ((SELECT id FROM countries WHERE slug='brazil'), 'regulator', 'Consumer Court',
   'Juizado Especial do Consumidor (JEC)',
   'Brazil''s small claims consumer court. Free for claims up to 20 minimum wages (~BRL 28,000). High success rate for delivery app refund cases.',
   NULL, 2),
  ((SELECT id FROM countries WHERE slug='brazil'), 'regulator', 'Financial Regulator',
   'Banco Central do Brasil (BACEN)',
   'Regulates all payment service providers. File payment disputes at bcb.gov.br/registrarreclamacao.',
   'https://www.bcb.gov.br/registrarreclamacao', 3),
  ((SELECT id FROM countries WHERE slug='brazil'), 'regulator', 'Antitrust',
   'Conselho Administrativo de Defesa Econômica (CADE)',
   'Brazil''s antitrust authority. Report systemic anti-consumer practices by dominant platform operators like Uber.',
   'https://www.cade.gov.br', 4);

-- ── Mexico ──────────────────────────────────────────────────
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, display_order) VALUES
  ((SELECT id FROM countries WHERE slug='mexico'), 'payment_partner', 'SPEI Bank Transfer',
   'SPEI (Banco de México)',
   'SPEI transfers can be disputed via CONDUSEF. Contact your bank and file a "reclamación" citing the SPEI transaction reference number.',
   NULL, 1),
  ((SELECT id FROM countries WHERE slug='mexico'), 'payment_partner', 'Card & OXXO Pay',
   'Conekta / Stripe',
   'Card payments and OXXO cash vouchers processed via Conekta or Stripe. Dispute card payments with your bank (BBVA, Santander, Banorte, HSBC).',
   NULL, 2),
  ((SELECT id FROM countries WHERE slug='mexico'), 'regulator', 'Consumer Protection',
   'PROFECO (Procuraduría Federal del Consumidor)',
   'Mexico''s federal consumer protection agency. File at profeco.gob.mx. PROFECO can compel Uber to respond and issue refunds.',
   'https://www.profeco.gob.mx/Atencion_Ciudadana/Formulario_AtencionCiudadana.aspx', 1),
  ((SELECT id FROM countries WHERE slug='mexico'), 'regulator', 'Financial Regulator',
   'CONDUSEF (Comisión Nacional para la Protección y Defensa de los Usuarios de Servicios Financieros)',
   'File payment disputes at condusef.gob.mx. CONDUSEF mediates between consumers and financial institutions.',
   'https://www.condusef.gob.mx', 2),
  ((SELECT id FROM countries WHERE slug='mexico'), 'regulator', 'Competition Authority',
   'Comisión Federal de Competencia Económica (COFECE)',
   'Report anti-competitive or abusive practices by dominant digital platforms.',
   'https://www.cofece.mx', 3);

-- ── Colombia ────────────────────────────────────────────────
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, display_order) VALUES
  ((SELECT id FROM countries WHERE slug='colombia'), 'payment_partner', 'PSE / Digital Wallets',
   'PSE / Nequi / Daviplata',
   'Uber Eats Colombia accepts PSE bank transfers, Nequi and Daviplata mobile wallets. For PSE disputes, contact ACH Colombia. For Nequi/Daviplata, contact your bank''s app support.',
   NULL, 1),
  ((SELECT id FROM countries WHERE slug='colombia'), 'payment_partner', 'Card Processing',
   'PayU Colombia',
   'Card transactions processed via PayU. Contact your bank (Bancolombia, Davivienda, BBVA Colombia) for a chargeback.',
   'https://payulatam.com', 2),
  ((SELECT id FROM countries WHERE slug='colombia'), 'regulator', 'Consumer Protection',
   'Superintendencia de Industria y Comercio (SIC)',
   'Colombia''s consumer protection and competition authority. File complaints at sic.gov.co. SIC has direct jurisdiction over e-commerce consumer rights.',
   'https://www.sic.gov.co/atencion-al-ciudadano', 1),
  ((SELECT id FROM countries WHERE slug='colombia'), 'regulator', 'Financial Regulator',
   'Superintendencia Financiera de Colombia',
   'Regulates all payment service providers and banks in Colombia. Report unresolved payment disputes.',
   'https://www.superfinanciera.gov.co/jsp/loader.jsf?lServicio=PublicacionesAtencionAlCiudadano&lTipo=publicaciones&lFuncion=loadContenidoPublicacion&id=61447', 2);

-- ── Chile ───────────────────────────────────────────────────
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, display_order) VALUES
  ((SELECT id FROM countries WHERE slug='chile'), 'payment_partner', 'Card / WebPay',
   'WebPay Plus / Transbank',
   'Uber Eats Chile uses WebPay (Transbank), Chile''s main payment network. Dispute via your bank (BancoEstado, Santander, BCI). Transbank mediates bank-side disputes.',
   'https://www.transbank.cl', 1),
  ((SELECT id FROM countries WHERE slug='chile'), 'regulator', 'Consumer Protection',
   'SERNAC (Servicio Nacional del Consumidor)',
   'Chile''s national consumer service. File claims at sernac.cl. SERNAC can negotiate with Uber and refer cases to consumer courts.',
   'https://www.sernac.cl/portal/604/w3-channel.html', 1),
  ((SELECT id FROM countries WHERE slug='chile'), 'regulator', 'Financial Regulator',
   'Comisión para el Mercado Financiero (CMF)',
   'Regulates payment processors and financial service providers. File disputes for unresolved payment issues.',
   'https://www.cmfchile.cl/portal/principal/605/w3-channel.html', 2),
  ((SELECT id FROM countries WHERE slug='chile'), 'regulator', 'Consumer Court',
   'Juzgado de Policía Local',
   'File a consumer protection complaint at your local Juzgado de Policía Local. Low cost, fast resolution for e-commerce disputes.',
   NULL, 3);

-- ── Ghana ───────────────────────────────────────────────────
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, display_order) VALUES
  ((SELECT id FROM countries WHERE slug='ghana'), 'payment_partner', 'Mobile Money',
   'MTN Mobile Money (MoMo)',
   'MTN MoMo is the primary payment method for Uber Eats Ghana. Call MTN on 0244300000 or dial *170# to raise a merchant dispute. Provide the transaction reference number.',
   'https://mtn.com.gh/mtn-momo/', 1),
  ((SELECT id FROM countries WHERE slug='ghana'), 'payment_partner', 'Alternative Mobile Money',
   'Vodafone Cash / AirtelTigo Money',
   'If you paid via Vodafone Cash or AirtelTigo Money, contact your provider directly to initiate a merchant refund dispute.',
   NULL, 2),
  ((SELECT id FROM countries WHERE slug='ghana'), 'regulator', 'Consumer Protection',
   'Ghana Standards Authority (GSA) / Fair Wages',
   'File consumer complaints with the GSA Consumer Protection Division. The Commission on Human Rights (CHRAJ) can also assist with consumer rights violations.',
   'https://www.gsa.gov.gh', 1),
  ((SELECT id FROM countries WHERE slug='ghana'), 'regulator', 'Financial Regulator',
   'Bank of Ghana',
   'Regulates all mobile money operators in Ghana. Report unresolved MoMo payment disputes to the Bank of Ghana Consumer Protection Unit.',
   'https://www.bog.gov.gh', 2);

-- ── Egypt ───────────────────────────────────────────────────
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, display_order) VALUES
  ((SELECT id FROM countries WHERE slug='egypt'), 'payment_partner', 'Fawry / Vodafone Cash',
   'Fawry Pay / Vodafone Cash',
   'Uber Eats Egypt accepts Fawry Pay and Vodafone Cash. For Fawry disputes, call 16655. For Vodafone Cash, call 888. Provide the transaction reference number.',
   'https://www.fawry.com', 1),
  ((SELECT id FROM countries WHERE slug='egypt'), 'payment_partner', 'Card / InstaPay',
   'Visa / Mastercard / InstaPay',
   'Card payments and InstaPay transfers can be disputed via your bank (CIB, NBE, Banque Misr, HSBC Egypt). InstaPay disputes go through the Central Bank of Egypt framework.',
   NULL, 2),
  ((SELECT id FROM countries WHERE slug='egypt'), 'regulator', 'Consumer Protection',
   'Consumer Protection Agency (CPA) Egypt',
   'Egypt''s official consumer protection body. File complaints at cpa.gov.eg. The CPA has direct jurisdiction over e-commerce consumer disputes.',
   'https://cpa.gov.eg', 1),
  ((SELECT id FROM countries WHERE slug='egypt'), 'regulator', 'Financial Regulator',
   'Central Bank of Egypt (CBE)',
   'Regulates all payment service providers in Egypt. File complaints about unresolved electronic payment disputes via the CBE consumer complaint portal.',
   'https://www.cbe.org.eg/en/Pages/Complaint.aspx', 2);

-- ── Saudi Arabia ─────────────────────────────────────────────
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, display_order) VALUES
  ((SELECT id FROM countries WHERE slug='saudi-arabia'), 'payment_partner', 'mada / Apple Pay / STC Pay',
   'mada (Saudi Payment Network)',
   'Most Uber Eats SA payments go via mada debit cards or STC Pay. Contact your bank (Al Rajhi, SNB, Riyad Bank) for a mada chargeback. STC Pay disputes: call 920000444.',
   NULL, 1),
  ((SELECT id FROM countries WHERE slug='saudi-arabia'), 'payment_partner', 'STC Pay',
   'STC Pay (Digital Wallet)',
   'Contact STC Pay support at stcpay.com.sa or call 920000444 to raise a merchant payment dispute with your transaction reference.',
   'https://stcpay.com.sa', 2),
  ((SELECT id FROM countries WHERE slug='saudi-arabia'), 'regulator', 'Consumer Protection',
   'Ministry of Commerce — Consumer Protection',
   'File complaints at mc.gov.sa or call 1900. Saudi Arabia''s Consumer Protection Law gives consumers rights against defective digital services.',
   'https://mc.gov.sa/en/pages/complaint.aspx', 1),
  ((SELECT id FROM countries WHERE slug='saudi-arabia'), 'regulator', 'Financial Regulator',
   'Saudi Central Bank (SAMA)',
   'SAMA regulates all payment service providers. File payment disputes at centralbank.gov.sa. SAMA mandates PSP response within 30 days.',
   'https://www.sama.gov.sa/en-US/Pages/complaint.aspx', 2),
  ((SELECT id FROM countries WHERE slug='saudi-arabia'), 'regulator', 'E-Commerce Regulator',
   'Communications, Space & Technology Commission (CST)',
   'Regulates e-commerce platforms in Saudi Arabia. Report app-based consumer rights violations.',
   'https://cst.gov.sa/en/pages/complaints.aspx', 3);

-- ============================================================
-- NEW COUNTRY DATA
-- ============================================================

-- ── Netherlands ─────────────────────────────────────────────
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, display_order) VALUES
  ((SELECT id FROM countries WHERE slug='netherlands'), 'payment_partner', 'iDEAL / Card',
   'iDEAL / Adyen',
   'Uber Eats NL accepts iDEAL (Netherlands'' dominant bank transfer), processed via Adyen. For iDEAL disputes, contact your bank directly (ING, ABN AMRO, Rabobank). Card disputes via standard chargeback.',
   NULL, 1),
  ((SELECT id FROM countries WHERE slug='netherlands'), 'regulator', 'Consumer Protection',
   'Autoriteit Consument & Markt (ACM)',
   'Netherlands'' consumer and market authority. File complaints about unfair commercial practices at acm.nl. ACM can investigate and sanction digital platforms.',
   'https://www.acm.nl/nl/consumenten/klacht-melden', 1),
  ((SELECT id FROM countries WHERE slug='netherlands'), 'regulator', 'Consumer Disputes Committee',
   'Geschillencommissie (Consumer Disputes Committee)',
   'Binding arbitration for consumer disputes. Uber must participate. Fast alternative to court.',
   'https://www.degeschillencommissie.nl', 2),
  ((SELECT id FROM countries WHERE slug='netherlands'), 'regulator', 'Financial Regulator',
   'Autoriteit Financiële Markten (AFM)',
   'Regulates payment service providers. Report unresolved payment disputes.',
   'https://www.afm.nl/nl-nl/consumenten/contact/een-klacht-indienen', 3);

-- ── Belgium ─────────────────────────────────────────────────
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, display_order) VALUES
  ((SELECT id FROM countries WHERE slug='belgium'), 'payment_partner', 'Bancontact / Card',
   'Bancontact / Adyen',
   'Uber Eats Belgium primarily uses Bancontact (Belgium''s national debit network) and card payments via Adyen. Dispute via your bank (KBC, BNP Paribas Fortis, Belfius, ING Belgium).',
   NULL, 1),
  ((SELECT id FROM countries WHERE slug='belgium'), 'regulator', 'Consumer Protection',
   'Direction Générale de l''Inspection Économique / Test-Achats',
   'File at economie.fgov.be. Test-Achats (consumer organisation) also offers mediation and legal support for app-related billing disputes.',
   'https://www.economie.fgov.be/fr/themes/consommateurs/protection-des-consommateurs/faire-une-plainte', 1),
  ((SELECT id FROM countries WHERE slug='belgium'), 'regulator', 'Ombudsman',
   'Ombudsman des Assurances / Ombudsfin',
   'Belgium''s financial ombudsman. Escalate if your bank refuses to process a valid chargeback.',
   'https://www.ombudsfin.be/en/individuals/submit-complaint/', 2);

-- ── Sweden ──────────────────────────────────────────────────
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, display_order) VALUES
  ((SELECT id FROM countries WHERE slug='sweden'), 'payment_partner', 'Swish / Card',
   'Swish / Adyen',
   'Uber Eats Sweden accepts Swish (mobile payment) and card via Adyen. Contact your bank (SEB, Nordea, Swedbank, Handelsbanken) for card chargebacks.',
   NULL, 1),
  ((SELECT id FROM countries WHERE slug='sweden'), 'regulator', 'Consumer Protection',
   'Konsumentverket (Swedish Consumer Agency)',
   'File at konsumentverket.se. Konsumentverket can instruct businesses to change practices and impose injunctions.',
   'https://www.konsumentverket.se/en/contact-us/', 1),
  ((SELECT id FROM countries WHERE slug='sweden'), 'regulator', 'Dispute Resolution',
   'Allmänna Reklamationsnämnden (ARN)',
   'Sweden''s National Board for Consumer Disputes. Free, binding recommendations. Very high compliance rate from companies.',
   'https://www.arn.se/en/', 2);

-- ── Norway ──────────────────────────────────────────────────
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, display_order) VALUES
  ((SELECT id FROM countries WHERE slug='norway'), 'payment_partner', 'Vipps / Card',
   'Vipps MobilePay / Adyen',
   'Uber Eats Norway accepts Vipps and card payments. For card disputes, contact your bank (DNB, Nordea, SpareBank). Vipps disputes: contact Vipps customer support.',
   NULL, 1),
  ((SELECT id FROM countries WHERE slug='norway'), 'regulator', 'Consumer Protection',
   'Forbrukertilsynet (Norwegian Consumer Authority)',
   'File complaints at forbrukertilsynet.no. The Consumer Authority enforces the Marketing Control Act against deceptive digital platform practices.',
   'https://www.forbrukertilsynet.no/tips-og-klager', 1),
  ((SELECT id FROM countries WHERE slug='norway'), 'regulator', 'Dispute Resolution',
   'Forbrukerrådet (Consumer Council of Norway)',
   'Free mediation service for consumer disputes. Can escalate to Forbrukertvistutvalget (Consumer Disputes Committee) for binding resolution.',
   'https://www.forbrukerradet.no/klage', 2);

-- ── Denmark ─────────────────────────────────────────────────
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, display_order) VALUES
  ((SELECT id FROM countries WHERE slug='denmark'), 'payment_partner', 'MobilePay / Card',
   'MobilePay / Adyen',
   'Uber Eats Denmark accepts MobilePay and card payments via Adyen. Card disputes via your bank (Danske Bank, Nordea, Jyske Bank).',
   NULL, 1),
  ((SELECT id FROM countries WHERE slug='denmark'), 'regulator', 'Consumer Protection',
   'Forbrugerrådet Tænk',
   'Denmark''s main consumer advocacy organisation. Free legal advice and mediation for app billing disputes.',
   'https://taenk.dk/klagemuligheder', 1),
  ((SELECT id FROM countries WHERE slug='denmark'), 'regulator', 'Dispute Board',
   'Forbrugerklagenævnet (Consumer Complaints Board)',
   'Official dispute resolution body. File complaints at forbrug.dk. Binding decisions. Uber must comply.',
   'https://www.forbrug.dk/klageportalen/', 2);

-- ── Poland ──────────────────────────────────────────────────
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, display_order) VALUES
  ((SELECT id FROM countries WHERE slug='poland'), 'payment_partner', 'BLIK / Card',
   'BLIK / Adyen',
   'Uber Eats Poland uses BLIK (Poland''s instant mobile payment) and card payments. BLIK disputes: contact your bank. Card disputes via Visa/Mastercard chargeback through your bank (PKO, Pekao, mBank).',
   NULL, 1),
  ((SELECT id FROM countries WHERE slug='poland'), 'regulator', 'Consumer Protection',
   'Urząd Ochrony Konkurencji i Konsumentów (UOKiK)',
   'Poland''s Office of Competition and Consumer Protection. File complaints at uokik.gov.pl. UOKiK has strong enforcement powers and has fined digital platforms.',
   'https://www.uokik.gov.pl/zloz_wniosek_zapytanie_skarge.php', 1),
  ((SELECT id FROM countries WHERE slug='poland'), 'regulator', 'Dispute Resolution',
   'Stały Polubowny Sąd Konsumencki (Permanent Consumer Arbitration Court)',
   'Free arbitration at Trade Inspection offices. File at wiih.gov.pl for your region.',
   'https://www.uokik.gov.pl/arbitraz_konsumencki.php', 2);

-- ── Portugal ────────────────────────────────────────────────
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, display_order) VALUES
  ((SELECT id FROM countries WHERE slug='portugal'), 'payment_partner', 'MB Way / Card',
   'MB Way / Adyen',
   'Uber Eats Portugal accepts MB Way (Multibanco mobile payment) and card payments. Dispute via your bank (CGD, BCP Millennium, Novobanco, Santander PT).',
   NULL, 1),
  ((SELECT id FROM countries WHERE slug='portugal'), 'regulator', 'Consumer Protection',
   'Direção-Geral do Consumidor (DGC)',
   'Portugal''s consumer directorate. File complaints at consumidor.gov.pt or via Centro de Arbitragem.',
   'https://www.consumidor.gov.pt/contactos.aspx', 1),
  ((SELECT id FROM countries WHERE slug='portugal'), 'regulator', 'Dispute Resolution',
   'CIAB — Consumer Arbitration Centre',
   'Free online arbitration for disputes up to €5,000. Fast, binding resolution without court.',
   'https://www.ciab.pt', 2);

-- ── Turkey ──────────────────────────────────────────────────
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, display_order) VALUES
  ((SELECT id FROM countries WHERE slug='turkey'), 'payment_partner', 'Credit Card / BKM Express',
   'iyzico / Stripe',
   'Uber Eats Turkey processes via iyzico and Stripe. Contact your bank (İşbank, Garanti BBVA, Yapı Kredi, Akbank) for a chargeback using your Mastercard/Visa rights.',
   NULL, 1),
  ((SELECT id FROM countries WHERE slug='turkey'), 'regulator', 'Consumer Protection',
   'Tüketici Hakem Heyeti (Consumer Arbitration Committee)',
   'File at e-devlet.gov.tr. Mandatory free arbitration for disputes under a threshold (set annually). Companies must comply with decisions.',
   'https://tuketici.ticaret.gov.tr', 1),
  ((SELECT id FROM countries WHERE slug='turkey'), 'regulator', 'Consumer Rights Ministry',
   'T.C. Ticaret Bakanlığı (Ministry of Trade)',
   'Report e-commerce consumer rights violations to the Ministry of Trade''s consumer protection directorate.',
   'https://tuketici.ticaret.gov.tr/soru-sikayet', 2);

-- ── Philippines ─────────────────────────────────────────────
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, display_order) VALUES
  ((SELECT id FROM countries WHERE slug='philippines'), 'payment_partner', 'GCash / Maya',
   'GCash / Maya (formerly PayMaya)',
   'Uber Eats PH accepts GCash and Maya. Dispute via in-app support: GCash Help Centre, Maya Customer Support. Provide the transaction reference number for faster resolution.',
   'https://help.gcash.com', 1),
  ((SELECT id FROM countries WHERE slug='philippines'), 'payment_partner', 'Card Processing',
   'PayMongo / Stripe',
   'Card payments via PayMongo or Stripe. Contact your card issuer (BDO, BPI, UnionBank, Metrobank) for a chargeback.',
   NULL, 2),
  ((SELECT id FROM countries WHERE slug='philippines'), 'regulator', 'Consumer Protection',
   'Department of Trade and Industry (DTI)',
   'File complaints at dti.gov.ph. DTI has direct jurisdiction over e-commerce consumer rights and can compel merchants to refund.',
   'https://www.dti.gov.ph/konsyumer/file-a-complaint/', 1),
  ((SELECT id FROM countries WHERE slug='philippines'), 'regulator', 'Financial Regulator',
   'Bangko Sentral ng Pilipinas (BSP)',
   'Regulates e-money issuers (GCash, Maya). File disputes at bsp.gov.ph for unresolved digital payment issues.',
   'https://www.bsp.gov.ph/Pages/CONSUMER-PROTECTION/consumer-assist.aspx', 2);

-- ── Malaysia ────────────────────────────────────────────────
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, display_order) VALUES
  ((SELECT id FROM countries WHERE slug='malaysia'), 'payment_partner', 'Touch ''n Go / DuitNow',
   'Touch ''n Go eWallet / DuitNow',
   'Uber Eats Malaysia accepts Touch ''n Go eWallet and DuitNow QR. For TNG disputes, use in-app support or call 1300-88-8228. DuitNow disputes go via your bank.',
   'https://www.touchngo.com.my/support', 1),
  ((SELECT id FROM countries WHERE slug='malaysia'), 'payment_partner', 'Card Processing',
   'Visa / Mastercard via Stripe / MOLPay',
   'Card payments processed via Stripe or MOLPay. Contact your bank (Maybank, CIMB, Public Bank, RHB) for a chargeback.',
   NULL, 2),
  ((SELECT id FROM countries WHERE slug='malaysia'), 'regulator', 'Consumer Protection',
   'Tribunal for Consumer Claims Malaysia (TTPM)',
   'File claims at ttpm.kpdnhep.gov.my. Fast, free resolution for claims up to RM 50,000. High success rate for delivery app disputes.',
   'https://ttpm.kpdnhep.gov.my', 1),
  ((SELECT id FROM countries WHERE slug='malaysia'), 'regulator', 'Consumer Affairs',
   'Ministry of Domestic Trade and Cost of Living (KPDN)',
   'Report deceptive practices or systemic refund failures by e-commerce operators.',
   'https://www.kpdnhep.gov.my/en/consumer/complaint.html', 2),
  ((SELECT id FROM countries WHERE slug='malaysia'), 'regulator', 'Financial Regulator',
   'Bank Negara Malaysia',
   'Regulates e-money service providers. Report unresolved digital payment disputes to BNM''s BNMLINK portal.',
   'https://bnmlink.bnm.gov.my', 3);

-- ── Argentina ───────────────────────────────────────────────
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, display_order) VALUES
  ((SELECT id FROM countries WHERE slug='argentina'), 'payment_partner', 'Mercado Pago',
   'Mercado Pago',
   'Uber Eats Argentina processes through Mercado Pago. Raise a dispute directly in the Mercado Pago app — buyer protection covers undelivered orders.',
   'https://www.mercadopago.com.ar/ayuda', 1),
  ((SELECT id FROM countries WHERE slug='argentina'), 'payment_partner', 'Credit Card',
   'Visa / Mastercard via Stripe',
   'Card chargebacks via your bank (Banco Galicia, Santander Argentina, BBVA Argentina, Banco Macro). File within 60 days of the transaction.',
   NULL, 2),
  ((SELECT id FROM countries WHERE slug='argentina'), 'regulator', 'Consumer Protection',
   'Defensa del Consumidor (CABA) / COPREC',
   'File at Argentina''s e-government portal argentina.gob.ar/consumidor. COPREC (mandatory online conciliation) must be attempted before court.',
   'https://www.argentina.gob.ar/produccion/defensadelconsumidor/formulario', 1),
  ((SELECT id FROM countries WHERE slug='argentina'), 'regulator', 'Financial Regulator',
   'Banco Central de la República Argentina (BCRA)',
   'Regulates all payment service providers. File complaints about unresolved digital payment disputes via the BCRA user portal.',
   'https://www.bcra.gob.ar/BCRAyVos/Usuarios_Financieros.asp', 2);

-- ── Peru ────────────────────────────────────────────────────
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, display_order) VALUES
  ((SELECT id FROM countries WHERE slug='peru'), 'payment_partner', 'Yape / Plin',
   'Yape (BCP) / Plin (BBVA / Interbank)',
   'Digital wallet payments via Yape or Plin. Dispute via your bank''s app: BCP (Yape), BBVA / Interbank / Scotiabank (Plin).',
   NULL, 1),
  ((SELECT id FROM countries WHERE slug='peru'), 'payment_partner', 'Card Processing',
   'Niubiz / Visa Net',
   'Card payments via Niubiz (formerly VisaNet Peru). Contact your bank (BCP, BBVA, Interbank, Scotiabank) for a chargeback.',
   NULL, 2),
  ((SELECT id FROM countries WHERE slug='peru'), 'regulator', 'Consumer Protection',
   'INDECOPI (Instituto Nacional de Defensa de la Competencia y de la Protección de la Propiedad Intelectual)',
   'Peru''s main consumer protection authority. File at indecopi.gob.pe. INDECOPI can impose sanctions and compel refunds.',
   'https://www.indecopi.gob.pe/web/atencion-al-ciudadano/en-linea', 1),
  ((SELECT id FROM countries WHERE slug='peru'), 'regulator', 'Financial Regulator',
   'Superintendencia de Banca, Seguros y AFP (SBS)',
   'Regulates payment service providers and banks. File payment disputes via the SBS consumer protection portal.',
   'https://www.sbs.gob.pe/usuarios-sistema-financiero/atencion-al-usuario/como-presentar-un-reclamo', 2);

-- ── Kuwait ──────────────────────────────────────────────────
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, display_order) VALUES
  ((SELECT id FROM countries WHERE slug='kuwait'), 'payment_partner', 'KNET / Card',
   'KNET (Kuwait''s national payment network)',
   'Most Uber Eats Kuwait payments process via KNET debit. Dispute via your bank (NBK, CBK, Gulf Bank, Burgan Bank). Card disputes: standard Visa/Mastercard chargeback.',
   NULL, 1),
  ((SELECT id FROM countries WHERE slug='kuwait'), 'regulator', 'Consumer Protection',
   'Public Authority for Consumer Protection (PACP)',
   'Kuwait''s consumer protection authority. File complaints at e.gov.kw or call 1880088.',
   'https://e.gov.kw', 1),
  ((SELECT id FROM countries WHERE slug='kuwait'), 'regulator', 'Financial Regulator',
   'Central Bank of Kuwait (CBK)',
   'Regulates payment service providers. Report unresolved digital payment disputes to CBK Consumer Protection.',
   'https://www.cbk.gov.kw/en/consumer-protection', 2);

-- ── Qatar ───────────────────────────────────────────────────
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, display_order) VALUES
  ((SELECT id FROM countries WHERE slug='qatar'), 'payment_partner', 'Card / NAPS',
   'Visa / Mastercard / NAPS (Qatar network)',
   'Uber Eats Qatar uses international card networks. Dispute via your bank (QNB, Commercial Bank, Doha Bank, Masraf Al Rayan). Card chargeback standard process applies.',
   NULL, 1),
  ((SELECT id FROM countries WHERE slug='qatar'), 'regulator', 'Consumer Protection',
   'Ministry of Commerce and Industry (MOCI)',
   'File consumer complaints at moci.gov.qa or call 16001. MOCI enforces Qatar''s consumer protection law against digital service providers.',
   'https://www.moci.gov.qa/en/Pages/ConsumerComplaints.aspx', 1),
  ((SELECT id FROM countries WHERE slug='qatar'), 'regulator', 'Financial Regulator',
   'Qatar Central Bank (QCB)',
   'Regulates payment services in Qatar. Report unresolved payment disputes via QCB Consumer Protection.',
   'https://www.qcb.gov.qa/en/consumer-protection', 2);

-- ── Tanzania ────────────────────────────────────────────────
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, display_order) VALUES
  ((SELECT id FROM countries WHERE slug='tanzania'), 'payment_partner', 'M-Pesa / Tigo Pesa / Airtel Money',
   'M-Pesa Tanzania / Tigo Pesa / Airtel Money',
   'Mobile money is the dominant Uber Eats payment method in Tanzania. For disputes: M-Pesa call 150, Tigo Pesa call 111, Airtel Money call 100. Provide the transaction code.',
   NULL, 1),
  ((SELECT id FROM countries WHERE slug='tanzania'), 'regulator', 'Consumer Protection',
   'Competition Fair Trading Commission (CFTC)',
   'Tanzania''s consumer and competition authority. File complaints at cftc.go.tz.',
   'https://www.cftc.go.tz', 1),
  ((SELECT id FROM countries WHERE slug='tanzania'), 'regulator', 'Financial Regulator',
   'Bank of Tanzania (BOT)',
   'Regulates mobile money operators and payment systems. File disputes via the BOT Consumer Protection Unit.',
   'https://www.bot.go.tz', 2);

-- ── Uganda ──────────────────────────────────────────────────
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, display_order) VALUES
  ((SELECT id FROM countries WHERE slug='uganda'), 'payment_partner', 'MTN Mobile Money / Airtel Money',
   'MTN MoMo Uganda / Airtel Money',
   'Mobile money is the primary Uber Eats Uganda payment method. MTN disputes: call 100 or *165#. Airtel Money: call 175. Provide the transaction reference.',
   NULL, 1),
  ((SELECT id FROM countries WHERE slug='uganda'), 'regulator', 'Consumer Protection',
   'Uganda Consumer Protection Unit (MTIC)',
   'File consumer complaints with the Ministry of Trade, Industry and Cooperatives (MTIC).',
   'https://www.mtic.go.ug', 1),
  ((SELECT id FROM countries WHERE slug='uganda'), 'regulator', 'Financial Regulator',
   'Bank of Uganda (BoU)',
   'Regulates mobile money operators. File unresolved digital payment disputes with Bank of Uganda Consumer Education and Financial Literacy.',
   'https://www.bou.or.ug', 2);

-- ── Pakistan ────────────────────────────────────────────────
INSERT INTO directory_entries (country_id, section, role_or_type, name, notes, contact_url, display_order) VALUES
  ((SELECT id FROM countries WHERE slug='pakistan'), 'payment_partner', 'JazzCash / EasyPaisa',
   'JazzCash / EasyPaisa',
   'Uber Eats Pakistan processes via JazzCash and EasyPaisa mobile wallets. Disputes: JazzCash call 786, EasyPaisa call 3737. Card disputes via your bank (HBL, MCB, UBL, Meezan).',
   NULL, 1),
  ((SELECT id FROM countries WHERE slug='pakistan'), 'regulator', 'Consumer Protection',
   'Competition Commission of Pakistan (CCP)',
   'Report anti-competitive and anti-consumer practices by digital platforms to the CCP at cc.gov.pk.',
   'https://www.cc.gov.pk', 1),
  ((SELECT id FROM countries WHERE slug='pakistan'), 'regulator', 'Financial Regulator',
   'State Bank of Pakistan (SBP)',
   'Regulates all payment service providers. File payment disputes via SBP''s consumer complaint portal.',
   'https://www.sbp.org.pk/departments/csrd.asp', 2);

