import Head from 'next/head'
import Link from 'next/link'
import BRAND from '../config/brand.config'

const SITE_URL = process.env.NEXT_PUBLIC_SITE_URL || BRAND.domain
const STATUS_COLORS = {
  red: 'bg-red-100 text-red-800 border-red-200',
  green: 'bg-green-100 text-green-800 border-green-200',
}

export default function Legal() {
  const { legal } = BRAND
  return (
    <>
      <Head>
        <title>{BRAND.meta.legalTitle}</title>
        <meta name="description" content={BRAND.meta.legalDescription} />
        <link rel="canonical" href={`${SITE_URL}/legal`} />
        <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify({
          '@context': 'https://schema.org', '@type': 'NewsArticle',
          headline: BRAND.meta.legalTitle,
          url: `${SITE_URL}/legal`,
          datePublished: '2025-04-01', dateModified: '2026-06-06',
          author: { '@type': 'Organization', name: BRAND.name, url: SITE_URL },
          publisher: { '@type': 'Organization', name: BRAND.name, url: SITE_URL },
        }) }} />
      </Head>

      <div className="min-h-screen bg-gray-50">
        <nav className="bg-gray-900 text-white px-4 py-3 text-sm">
          <div className="max-w-4xl mx-auto flex items-center gap-2">
            <Link href="/" className="font-black text-base hover:underline">{BRAND.name}</Link>
            <span className="text-gray-500">/</span>
            <span className="text-gray-300">Legal & Regulatory Tracker</span>
          </div>
        </nav>

        <header className="relative bg-gray-900 text-white py-14 px-4 overflow-hidden">
          <img src={legal.heroImage} alt={legal.heroImageAlt} className="absolute inset-0 w-full h-full object-cover opacity-25" />
          <div className="relative max-w-4xl mx-auto">
            <h1 className="text-3xl md:text-4xl font-black mb-3">{legal.headline}</h1>
            <p className="text-gray-300 text-lg max-w-2xl">{legal.intro}</p>
          </div>
        </header>

        <main id="main-content" className="max-w-4xl mx-auto px-4 py-12 sm:px-6 space-y-8">
          <div className="p-4 bg-blue-50 border border-blue-200 rounded-xl text-sm text-blue-800">
            <strong>Why this matters for your dispute:</strong> Regulators track patterns across thousands of complaints. Your individual report contributes to the aggregate evidence that triggers investigations, fines, and legislation.
          </div>

          {legal.cases.map(c => (
            <article key={c.id} className="bg-white border border-gray-200 rounded-xl overflow-hidden">
              <div className="p-6">
                <div className="flex items-start justify-between gap-4 mb-4">
                  <div className="flex-1">
                    <div className="flex flex-wrap items-center gap-2 mb-2">
                      <span className="text-lg">{c.flag}</span>
                      <span className="text-xs text-gray-500 font-medium">{c.jurisdiction}</span>
                      <span className={`text-xs font-bold px-2 py-0.5 rounded-full border ${STATUS_COLORS[c.statusColor]}`}>{c.statusLabel}</span>
                    </div>
                    <h2 className="text-lg font-black text-gray-900">{c.title}</h2>
                    <p className="text-sm text-gray-500 mt-1">{c.authority} · Filed: {c.filed}{c.updated !== c.filed && ` · Updated: ${c.updated}`}</p>
                  </div>
                </div>
                <p className="text-gray-700 text-sm leading-relaxed mb-4">{c.summary}</p>
                {c.allegations.length > 0 && (
                  <div className="mb-4">
                    <div className="text-xs font-bold text-gray-500 uppercase tracking-wide mb-2">Key allegations</div>
                    <ul className="space-y-1">
                      {c.allegations.map((a, i) => <li key={i} className="text-sm text-gray-600 flex gap-2"><span className="text-red-500 shrink-0 mt-0.5">•</span>{a}</li>)}
                    </ul>
                  </div>
                )}
                <div className="mb-4 p-3 bg-gray-50 rounded-lg text-sm">
                  <span className="font-semibold text-gray-700">Outcome: </span>
                  <span className="text-gray-600">{c.outcome}</span>
                </div>
                <div className="p-3 bg-green-50 border border-green-200 rounded-lg text-sm text-green-800">
                  <span className="font-semibold">What this means for you: </span>{c.relevance}
                </div>
                {c.sources.length > 0 && (
                  <div className="mt-4 flex flex-wrap gap-2">
                    {c.sources.map((s, i) => (
                      <a key={i} href={s.url} target="_blank" rel="noopener noreferrer"
                        className="text-xs text-blue-600 hover:underline bg-blue-50 border border-blue-100 px-3 py-1.5 rounded-full">
                        📄 {s.label}
                      </a>
                    ))}
                  </div>
                )}
              </div>
            </article>
          ))}

          <section className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <Link href="/guide" className="flex items-center gap-4 p-5 bg-white border border-gray-200 rounded-xl hover:border-red-300 transition">
              <span className="text-3xl">📖</span>
              <div><div className="font-bold text-gray-800">Step-by-step guide</div><div className="text-sm text-gray-500">How to escalate your dispute effectively</div></div>
            </Link>
            <Link href="/directory" className="flex items-center gap-4 p-5 bg-white border border-gray-200 rounded-xl hover:border-red-300 transition">
              <span className="text-3xl">🌍</span>
              <div><div className="font-bold text-gray-800">Your country&apos;s regulators</div><div className="text-sm text-gray-500">Direct links to file complaints in 40+ countries</div></div>
            </Link>
          </section>

          <p className="text-xs text-gray-400 text-center">{legal.sourceNote}</p>
        </main>

        <footer className="bg-gray-900 text-gray-500 text-center py-6 mt-12 text-xs">
          <p>{BRAND.name} &copy; {BRAND.foundedYear} &nbsp;|&nbsp; {BRAND.disclaimer.footer}</p>
        </footer>
      </div>
    </>
  )
}
