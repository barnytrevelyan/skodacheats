-- Remove countries with no Škoda dealer network
-- Cascades to directory_entries for those countries

DELETE FROM countries WHERE slug IN (
  -- Africa: Škoda only has meaningful presence in South Africa and Egypt
  'ghana',
  'ivory-coast',
  'kenya',
  'nigeria',
  'senegal',
  'tanzania',
  'uganda',
  -- Asia Pacific: Škoda not present
  'bangladesh',
  'hong-kong',
  'japan',        -- Škoda withdrew from Japan ~2012
  'malaysia',
  'pakistan',
  'philippines',
  'sri-lanka',
  'taiwan',
  'thailand',
  -- Latin America: Škoda has very limited presence (a few markets via VW Group)
  'brazil',
  'mexico',
  'colombia',
  'chile',
  'argentina',
  'peru',
  'ecuador',
  -- Middle East: limited Škoda presence
  'uae',
  'saudi-arabia',
  'kuwait',
  'qatar',
  'jordan',
  'lebanon'
);

-- Also remove any orphaned region entries that now have no countries
-- (optional — regions with zero countries just won't show on the directory)
