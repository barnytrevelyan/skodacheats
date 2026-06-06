import BRAND from '../../config/brand.config'
import { useState, useEffect } from 'react'
import Head from 'next/head'
import Link from 'next/link'
import { supabase } from '../../lib/supabase'

const SECTION_LABELS = {
  executive: '👔 Executive',
  payment_partner: '💳 Payment',
  regulator: '🏛️ Regulator',
}

const SECTION_COLORS = {
  executive: 'bg-purple-100 text-purple-800',
  payment_partner: 'bg-green-100 text-green-700',
  regulator: 'bg-blue-100 text-blue-800',
}

function ContributionRow({ contrib, onAction }) {
  const [loading, setLoading] = useState(null)

  const act = async (action) => {
    setLoading(action)
    await onAction(contrib.id, action)
    setLoading(null)
  }

  return (
    <tr className="border-b border-gray-100 hover:bg-gray-50 align-top">
      <td className="px-4 py-3 text-sm">
        <span className="font-semibold">{contrib.countries?.flag_emoji} {contrib.countries?.name}</span>
        <div className="text-xs text-gray-400 mt-0.5">{new Date(contrib.created_at).toLocaleDateString()}</div>
      </td>
      <td className="px-4 py-3">
        <span className={`text-xs font-semibold px-2 py-1 rounded-full ${SECTION_COLORS[contrib.section]}`}>
          {SECTION_LABELS[contrib.section]}
        </span>
      </td>
      <td className="px-4 py-3 text-sm">
        <div className="font-semibold text-gray-900">{contrib.name}</div>
        {contrib.role_or_type && <div className="text-xs text-gray-500">{contrib.role_or_type}</div>}
      </td>
      <td className="px-4 py-3 text-sm text-gray-600 max-w-xs">
        {contrib.notes && <p className="text-xs leading-relaxed mb-1">{contrib.notes}</p>}
        {contrib.contact_url && (
          <a href={contrib.contact_url} target="_blank" rel="noopener noreferrer"
            className="text-xs text-blue-600 hover:underline block truncate">
            🔗 {contrib.contact_url}
          </a>
        )}
        {contrib.source_url && (
          <a href={contrib.source_url} target="_blank" rel="noopener noreferrer"
            className="text-xs text-gray-400 hover:underline block truncate">
            📎 Source: {contrib.source_url}
          </a>
        )}
        {contrib.submitted_by_email && (
          <div className="text-xs text-gray-400 mt-1">From: {contrib.submitted_by_email}</div>
        )}
      </td>
      <td className="px-4 py-3">
        <div className="flex flex-col gap-2">
          <button
            onClick={() => act('approve')}
            disabled={!!loading}
            className="px-3 py-1.5 bg-green-600 hover:bg-green-700 disabled:bg-gray-300 text-white text-xs font-semibold rounded transition"
          >
            {loading === 'approve' ? '…' : '✅ Approve'}
          </button>
          <button
            onClick={() => act('reject')}
            disabled={!!loading}
            className="px-3 py-1.5 bg-red-100 hover:bg-red-200 disabled:bg-gray-100 text-red-700 text-xs font-semibold rounded transition"
          >
            {loading === 'reject' ? '…' : '✕ Reject'}
          </button>
        </div>
      </td>
    </tr>
  )
}

export default function AdminContributions() {
  const [session, setSession] = useState(null)
  const [isAdmin, setIsAdmin] = useState(false)
  const [contributions, setContributions] = useState([])
  const [loading, setLoading] = useState(true)
  const [stats, setStats] = useState({ pending: 0, approved: 0, rejected: 0 })
  const [toast, setToast] = useState(null)

  useEffect(() => {
    supabase.auth.getSession().then(({ data: { session } }) => {
      setSession(session)
      if (session) checkAdminAndLoad(session)
      else setLoading(false)
    })
  }, [])

  const checkAdminAndLoad = async (sess) => {
    // Hit the API — it will 403 if not admin
    const res = await fetch('/api/admin/contributions', {
      headers: { Authorization: `Bearer ${sess.access_token}` },
    })
    if (res.status === 403) {
      setIsAdmin(false)
      setLoading(false)
      return
    }
    setIsAdmin(true)
    const data = await res.json()
    setContributions(data.contributions || [])
    setLoading(false)
  }

  const handleAction = async (id, action) => {
    const res = await fetch('/api/admin/contributions', {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${session.access_token}`,
      },
      body: JSON.stringify({ id, action }),
    })
    const data = await res.json()
    if (res.ok) {
      setContributions(prev => prev.filter(c => c.id !== id))
      showToast(action === 'approve' ? '✅ Approved and published' : '✕ Rejected', action === 'approve' ? 'green' : 'red')
    } else {
      showToast(`Error: ${data.error}`, 'red')
    }
  }

  const showToast = (msg, color) => {
    setToast({ msg, color })
    setTimeout(() => setToast(null), 3000)
  }

  // Sign in flow
  const [email, setEmail] = useState('')
  const [sent, setSent] = useState(false)
  const [sending, setSending] = useState(false)

  const handleSignIn = async (e) => {
    e.preventDefault()
    setSending(true)
    const { error } = await supabase.auth.signInWithOtp({
      email,
      options: {
        emailRedirectTo: `${typeof window !== 'undefined' ? window.location.origin : ''}/auth/callback`,
      },
    })
    setSending(false)
    if (!error) setSent(true)
  }

  return (
    <>
      <Head>
        <title>Admin — Contributions Review | {BRAND.name}</title>
        <meta name="robots" content="noindex, nofollow" />
      </Head>

      {/* Toast */}
      {toast && (
        <div className={`fixed top-4 right-4 z-50 px-4 py-3 rounded-lg shadow-lg text-white text-sm font-semibold ${toast.color === 'green' ? 'bg-green-600' : 'bg-red-600'}`}>
          {toast.msg}
        </div>
      )}

      <div className="min-h-screen bg-gray-50">
        <nav className="bg-gray-900 text-white px-4 py-3 text-sm flex justify-between items-center">
          <div className="flex items-center gap-2">
            <Link href="/" className="font-bold text-base hover:underline">{BRAND.name}</Link>
            <span className="text-gray-500">/</span>
            <span className="text-gray-300">Admin</span>
            <span className="text-gray-500">/</span>
            <span className="text-gray-300">Contributions</span>
          </div>
          {session && (
            <div className="flex items-center gap-3 text-xs">
              <span className="text-gray-400">{session.user.email}</span>
              <button
                onClick={() => supabase.auth.signOut().then(() => { setSession(null); setIsAdmin(false) })}
                className="text-gray-300 hover:text-white underline"
              >Sign out</button>
            </div>
          )}
        </nav>

        <div className="max-w-6xl mx-auto px-4 py-10 sm:px-6">

          {!session ? (
            // Sign-in gate
            <div className="max-w-md mx-auto bg-white rounded-xl shadow-sm p-8 mt-8">
              <h1 className="text-xl font-bold text-gray-800 mb-1">Admin sign in</h1>
              <p className="text-sm text-gray-500 mb-5">Use your admin email address to get a login link.</p>
              {sent ? (
                <p className="text-green-700 text-sm">Check your email for a login link.</p>
              ) : (
                <form onSubmit={handleSignIn}>
                  <input
                    type="email"
                    value={email}
                    onChange={e => setEmail(e.target.value)}
                    required
                    placeholder="admin@email.com"
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg mb-3 text-sm focus:ring-2 focus:ring-blue-500 focus:outline-none"
                  />
                  <button
                    type="submit"
                    disabled={sending}
                    className="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-2 rounded-lg text-sm"
                  >
                    {sending ? 'Sending…' : 'Send login link'}
                  </button>
                </form>
              )}
            </div>
          ) : !isAdmin ? (
            <div className="text-center py-20">
              <p className="text-gray-600">You are not authorised to access this page.</p>
              <p className="text-sm text-gray-400 mt-2">Logged in as {session.user.email}</p>
            </div>
          ) : loading ? (
            <div className="text-center py-20 text-gray-500">Loading contributions…</div>
          ) : (
            <>
              <div className="flex items-center justify-between mb-6">
                <div>
                  <h1 className="text-2xl font-bold text-gray-900">Pending contributions</h1>
                  <p className="text-sm text-gray-500 mt-0.5">
                    {contributions.length} submission{contributions.length !== 1 ? 's' : ''} awaiting review
                  </p>
                </div>
                <Link href="/directory" className="text-sm text-blue-600 hover:underline">
                  View directory →
                </Link>
              </div>

              {contributions.length === 0 ? (
                <div className="bg-white rounded-xl shadow-sm p-12 text-center">
                  <div className="text-4xl mb-3">✅</div>
                  <p className="text-gray-600 font-medium">All clear — no pending contributions.</p>
                </div>
              ) : (
                <div className="bg-white rounded-xl shadow-sm overflow-hidden">
                  <table className="w-full">
                    <thead className="bg-gray-50 border-b border-gray-200">
                      <tr className="text-xs font-semibold text-gray-500 uppercase tracking-wide">
                        <th className="px-4 py-3 text-left">Country</th>
                        <th className="px-4 py-3 text-left">Section</th>
                        <th className="px-4 py-3 text-left">Name / Role</th>
                        <th className="px-4 py-3 text-left">Details</th>
                        <th className="px-4 py-3 text-left w-28">Action</th>
                      </tr>
                    </thead>
                    <tbody>
                      {contributions.map(c => (
                        <ContributionRow key={c.id} contrib={c} onAction={handleAction} />
                      ))}
                    </tbody>
                  </table>
                </div>
              )}

              <div className="mt-8 p-4 bg-blue-50 border border-blue-100 rounded-lg text-xs text-blue-700">
                <strong>How this works:</strong> Approving a contribution instantly publishes it to the live directory.
                Rejecting hides it permanently. All approved data is sourced from public records only.
              </div>
            </>
          )}
        </div>
      </div>
    </>
  )
}
