import { createClient } from '@supabase/supabase-js'

// Uses service role key — server-side only, never exposed to client
function getAdminClient() {
  return createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL,
    process.env.SUPABASE_SERVICE_ROLE_KEY
  )
}

function isAdmin(email) {
  const adminEmail = process.env.ADMIN_EMAIL
  return adminEmail && email === adminEmail
}

export default async function handler(req, res) {
  // Verify caller is authenticated admin
  const authHeader = req.headers.authorization
  if (!authHeader) return res.status(401).json({ error: 'Unauthorized' })

  // Verify the JWT with anon client
  const anonClient = createClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
  )
  const { data: { user }, error: authError } = await anonClient.auth.getUser(
    authHeader.replace('Bearer ', '')
  )
  if (authError || !user || !isAdmin(user.email)) {
    return res.status(403).json({ error: 'Forbidden' })
  }

  const supabase = getAdminClient()

  // GET — list pending contributions
  if (req.method === 'GET') {
    const { data, error } = await supabase
      .from('directory_contributions')
      .select('*, countries(name, slug, flag_emoji)')
      .eq('status', 'pending')
      .order('created_at', { ascending: true })

    if (error) return res.status(500).json({ error: error.message })
    return res.status(200).json({ contributions: data })
  }

  // PATCH — approve or reject a contribution
  if (req.method === 'PATCH') {
    const { id, action } = req.body // action: 'approve' | 'reject'
    if (!id || !['approve', 'reject'].includes(action)) {
      return res.status(400).json({ error: 'id and action (approve|reject) required' })
    }

    if (action === 'reject') {
      const { error } = await supabase
        .from('directory_contributions')
        .update({ status: 'rejected' })
        .eq('id', id)
      if (error) return res.status(500).json({ error: error.message })
      return res.status(200).json({ message: 'Rejected' })
    }

    // Approve: fetch contribution, insert into directory_entries, mark approved
    const { data: contrib, error: fetchErr } = await supabase
      .from('directory_contributions')
      .select('*')
      .eq('id', id)
      .single()

    if (fetchErr || !contrib) return res.status(404).json({ error: 'Contribution not found' })

    const { error: insertErr } = await supabase
      .from('directory_entries')
      .insert([{
        country_id:   contrib.country_id,
        section:      contrib.section,
        role_or_type: contrib.role_or_type,
        name:         contrib.name,
        notes:        contrib.notes,
        contact_url:  contrib.contact_url,
        source_url:   contrib.source_url,
        verified:     true,
        display_order: 99,
      }])

    if (insertErr) return res.status(500).json({ error: insertErr.message })

    await supabase
      .from('directory_contributions')
      .update({ status: 'approved' })
      .eq('id', id)

    return res.status(200).json({ message: 'Approved and published' })
  }

  res.status(405).json({ error: 'Method not allowed' })
}
