-- Migration: Add new fields for Uber order number and file uploads

-- Add uber_order_number column
ALTER TABLE complaints ADD COLUMN uber_order_number VARCHAR(255);

-- Add file_urls column (array of URLs)
ALTER TABLE complaints ADD COLUMN file_urls TEXT[] DEFAULT NULL;

-- Create Supabase Storage bucket for complaints if needed
-- (This needs to be done in the Supabase UI or via CLI)
-- To create via SQL, use: SELECT storage.create_bucket('complaints', false);

-- Grant public access to the complaints bucket files
-- (Do this in the Supabase UI: Storage → complaints → Edit bucket → Public bucket)
