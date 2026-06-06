import { createClient } from '@supabase/supabase-js'

const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL,
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY
)

export default async function handler(req, res) {
  if (req.method !== 'GET') return res.status(405).json({ error: 'Method not allowed' })

  const [countResult, amountResult, resolvedResult, recentResult] = await Promise.all([
    supabase.from('complaints').select('id', { count: 'exact', head: true }),
    supabase.from('complaints').select('order_amount_usd'),
    supabase.from('complaints').select('id', { count: 'exact', head: true }).eq('resolved', true),
    supabase.from('complaints').select('id, title, category, order_amount, order_currency, created_at')
      .order('created_at', { ascending: false }).limit(5),
  ])

  const totalUSD = (amountResult.data || [])
    .reduce((sum, r) => sum + (parseFloat(r.order_amount_usd) || 0), 0)

  res.setHeader('Cache-Control', 'public, s-maxage=60')
  res.status(200).json({
    totalCases: countResult.count || 0,
    totalUSD: Math.round(totalUSD),
    resolvedCases: resolvedResult.count || 0,
    recentCases: recentResult.data || [],
  })
}
