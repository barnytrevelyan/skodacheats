-- Add resolved tracking to complaints
ALTER TABLE complaints ADD COLUMN IF NOT EXISTS resolved boolean DEFAULT false;
ALTER TABLE complaints ADD COLUMN IF NOT EXISTS resolved_at TIMESTAMPTZ;
ALTER TABLE complaints ADD COLUMN IF NOT EXISTS resolution_note TEXT;

-- Allow authenticated owners to mark their own complaint resolved
CREATE POLICY "Owner can mark resolved" ON complaints
  FOR UPDATE TO authenticated
  USING (email = (auth.jwt() ->> 'email'))
  WITH CHECK (email = (auth.jwt() ->> 'email'));
