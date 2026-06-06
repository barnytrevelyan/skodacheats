import Head from 'next/head'
import Link from 'next/link'
import BRAND from '../config/brand.config'

const SITE_URL = process.env.NEXT_PUBLIC_SITE_URL || BRAND.domain
const PLATFORM_ICONS = { 'X / Twitter': '𝕏', 'Instagram': '📷', 'Facebook': '📘', 'TikTok': '🎵', 'LinkedIn': '💼', 'YouTube': '▶️' }

function AccountRow({ acc }) {
  return (
    <div className="flex items-start gap-3 py-3 border-b border-gray-100 last:border-0">
      <span className="text-xl w-6 text-center shrink-0">{PLATFORM_ICONS[acc.platform] || '🔗'}</span>
      <div className="flex-1 min-w-0">
        <div className="flex flex-wrap items-center gap-2">
          <a href={acc.url} target="_blank" rel="noopener noreferrer" className="font-semibold text-blue-700 hover:underline">{acc.handle}</a>
          <span className="text-xs text-gray-400">{acc.platform}</span>
          {acc.badge && <span className="text-xs bg-green-100 text-green-800 font-semibold px-2 py-0.5 rounded-full">{acc.badge}</span>}
        </div>
        {acc.note && <p className="text-xs text-gray-500 mt-0.5">{acc.note}</p>}
      </div>
      <a href={acc.url} target="_blank" rel="noopener noreferrer" className="shrink-0 text-xs bg-gray-100 hover:bg-gray-200 text-gray-700 px-2 py-1 rounded transition">Visit →</a>
    </div>
  )
}

export default function Contacts() {
  const { contacts } = BRAND
  return (
    <>
      <Head>
        <title>{BRAND.meta.contactsTitle}</title>
        <meta name="description" content={BRAND.meta.contactsDescription} />
        <link rel="canonical" href={`${SITE_URL}/${BRAND.contactsPageSlug}`} />
      </Head>

      <div className="min-h-screen bg-white">
        <nav className="bg-gray-900 text-white px-4 py-3 text-sm">
          <div className="max-w-4xl mx-auto flex items-center gap-2">
            <Link href="/" className="font-bold text-base hover:underline">{BRAND.name}</Link>
            <span className="text-gray-500">/</span>
            <span className="text-gray-300">Social Media Contacts</span>
          </div>
        </nav>

        <header className="bg-gray-900 text-white py-10 px-4">
          <div className="max-w-4xl mx-auto">
            <div className="text-4xl mb-3">📱</div>
            <h1 className="text-3xl font-bold mb-2">{contacts.headline}</h1>
            <p className="text-gray-300 max-w-2xl">{contacts.intro}</p>
          </div>
        </header>

        <main className="max-w-4xl mx-auto px-4 py-10 sm:px-6 space-y-10">
          <div className="p-4 bg-blue-50 border border-blue-200 rounded-lg text-sm text-blue-800">
            <strong>💡 Escalation strategy:</strong> {contacts.strategyTip}
          </div>

          {Object.values(contacts.globalAccounts).map(brand => (
            <section key={brand.label}>
              <div className="mb-3">
                <h2 className="text-xl font-bold text-gray-900">{brand.label}</h2>
                <p className="text-sm text-gray-500">{brand.note}</p>
              </div>
              <div className="bg-white border border-gray-200 rounded-lg px-4 divide-y divide-gray-100">
                {brand.accounts.map(acc => <AccountRow key={acc.handle} acc={acc} />)}
              </div>
            </section>
          ))}

          <section>
            <h2 className="text-xl font-bold text-gray-900 mb-4">Regional Accounts</h2>
            <div className="space-y-5">
              {contacts.regionalAccounts.map(region => (
                <div key={region.region} className="border border-gray-200 rounded-lg overflow-hidden">
                  <div className="bg-gray-50 px-4 py-2 font-semibold text-gray-700 text-sm border-b border-gray-200">{region.region}</div>
                  <div className="px-4 divide-y divide-gray-100">
                    {region.accounts.map(acc => <AccountRow key={acc.handle} acc={acc} />)}
                  </div>
                </div>
              ))}
            </div>
          </section>

          <section className="p-5 bg-yellow-50 border border-yellow-200 rounded-lg text-sm">
            <h3 className="font-bold text-gray-800 mb-1">Missing a regional account?</h3>
            <p className="text-gray-700">{contacts.missingText}</p>
          </section>

          <div className="text-center"><Link href="/directory" className="text-sm text-blue-600 hover:underline">← Back to Global Directory</Link></div>
        </main>

        <footer className="bg-gray-800 text-gray-300 text-center py-6 mt-12 text-sm">
          <p>{BRAND.name} &copy; {BRAND.foundedYear} &nbsp;|&nbsp; {BRAND.disclaimer.footer}</p>
        </footer>
      </div>
    </>
  )
}
