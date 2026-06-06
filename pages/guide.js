import Head from 'next/head'
import Link from 'next/link'
import BRAND from '../config/brand.config'

const SITE_URL = process.env.NEXT_PUBLIC_SITE_URL || BRAND.domain

const COLOR_MAP = {
  blue: 'bg-blue-600', orange: 'bg-orange-500', purple: 'bg-purple-600',
  green: 'bg-green-600', red: 'bg-red-600', gray: 'bg-gray-700',
}

export default function Guide() {
  const { guide } = BRAND
  return (
    <>
      <Head>
        <title>{BRAND.meta.guideTitle}</title>
        <meta name="description" content={BRAND.meta.guideDescription} />
        <link rel="canonical" href={`${SITE_URL}/guide`} />
        <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify({
          '@context': 'https://schema.org',
          '@type': 'TechArticle',
          headline: BRAND.meta.guideTitle,
          description: BRAND.meta.guideDescription,
          url: `${SITE_URL}/guide`,
          datePublished: '2026-01-01',
          dateModified: '2026-06-06',
          author: { '@type': 'Organization', name: BRAND.name, url: SITE_URL },
          publisher: { '@type': 'Organization', name: BRAND.name, url: SITE_URL },
          breadcrumb: { '@type': 'BreadcrumbList', itemListElement: [
            { '@type': 'ListItem', position: 1, name: 'Home', item: SITE_URL },
            { '@type': 'ListItem', position: 2, name: 'Guide', item: `${SITE_URL}/guide` },
          ]},
        }) }} />
        <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify({
          '@context': 'https://schema.org',
          '@type': 'HowTo',
          name: guide.headline,
          description: guide.intro,
          step: guide.steps.map((s, i) => ({ '@type': 'HowToStep', position: i + 1, name: s.title, text: s.content[0] })),
        }) }} />
      </Head>

      <div className="min-h-screen bg-gray-50">
        <nav className="bg-gray-900 text-white px-4 py-3 text-sm">
          <div className="max-w-4xl mx-auto flex items-center gap-2">
            <Link href="/" className="font-black text-base hover:underline">{BRAND.name}</Link>
            <span className="text-gray-500">/</span>
            <span className="text-gray-300">Refund Guide</span>
          </div>
        </nav>

        <header className="relative bg-gray-900 text-white py-14 px-4 overflow-hidden">
          <img src={guide.heroImage} alt={guide.heroImageAlt} className="absolute inset-0 w-full h-full object-cover opacity-30" />
          <div className="relative max-w-4xl mx-auto">
            <div className="text-sm text-gray-400 mb-2">Last updated June 2026</div>
            <h1 className="text-3xl md:text-4xl font-black mb-3">{guide.headline}<br />{guide.subheadline}</h1>
            <p className="text-gray-300 text-lg max-w-2xl">{guide.intro}</p>
          </div>
        </header>

        {/* Step progress nav */}
        <div className="bg-white border-b border-gray-200 px-4 py-4 sticky top-0 z-10 shadow-sm">
          <div className="max-w-4xl mx-auto flex items-center gap-2 overflow-x-auto">
            {guide.steps.map((s, i) => (
              <a key={s.n} href={`#step-${s.n}`} className="shrink-0 flex items-center gap-1.5 text-xs text-gray-500 hover:text-gray-800 transition">
                <span className={`w-6 h-6 rounded-full ${COLOR_MAP[s.color]} text-white text-xs font-bold flex items-center justify-center shrink-0`}>{parseInt(s.n)}</span>
                <span className="hidden sm:inline whitespace-nowrap">{s.title.split('(')[0].trim()}</span>
              </a>
            )).reduce((acc, el, i, arr) => [...acc, el, i < arr.length - 1 ? <span key={`sep-${i}`} className="text-gray-300 shrink-0">›</span> : null], [])}
          </div>
        </div>

        <main id="main-content" className="max-w-4xl mx-auto px-4 py-12 sm:px-6 space-y-12">
          {guide.steps.map(step => (
            <section key={step.n} id={`step-${step.n}`} className="scroll-mt-16">
              <div className="flex items-start gap-4">
                <div className={`${COLOR_MAP[step.color]} text-white rounded-2xl w-14 h-14 flex flex-col items-center justify-center shrink-0 shadow-lg`}>
                  <div className="text-xs font-bold opacity-70">Step</div>
                  <div className="text-xl font-black leading-none">{parseInt(step.n)}</div>
                </div>
                <div className="flex-1 min-w-0">
                  <div className="flex items-center gap-3 mb-1">
                    <h2 className="text-xl font-black text-gray-900">{step.icon} {step.title}</h2>
                  </div>
                  <div className="inline-block text-xs font-semibold text-gray-500 bg-gray-100 px-2 py-1 rounded mb-4">{step.time}</div>
                  <div className="space-y-3">
                    {step.content.map((para, i) => <p key={i} className="text-gray-700 leading-relaxed">{para}</p>)}
                  </div>
                  {step.tip && (
                    <div className="mt-4 flex gap-2 p-3 bg-amber-50 border border-amber-200 rounded-lg text-sm text-amber-800">
                      <span className="shrink-0">💡</span><span>{step.tip}</span>
                    </div>
                  )}
                  {step.action && (
                    <div className="mt-4">
                      <Link href={step.action.href} className="inline-flex items-center gap-2 text-sm font-semibold text-white bg-gray-800 hover:bg-gray-900 px-4 py-2 rounded-lg transition">
                        {step.action.label} →
                      </Link>
                    </div>
                  )}
                </div>
              </div>
            </section>
          ))}

          {/* Country tips */}
          <section>
            <h2 className="text-2xl font-black text-gray-900 mb-6">Country-Specific Tips</h2>
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
              {guide.countryTips.map(c => (
                <div key={c.country} className="bg-white border border-gray-200 rounded-xl p-5">
                  <h3 className="font-bold text-gray-800 mb-3">{c.flag} {c.country}</h3>
                  <ul className="space-y-2">
                    {c.tips.map((tip, i) => (
                      <li key={i} className="text-sm text-gray-600 flex gap-2">
                        <span className="text-green-500 shrink-0 mt-0.5">✓</span>{tip}
                      </li>
                    ))}
                  </ul>
                  <Link href="/directory" className="mt-3 inline-block text-xs text-blue-600 hover:underline">
                    Full {c.country} directory →
                  </Link>
                </div>
              ))}
            </div>
          </section>

          <section className="grid grid-cols-1 sm:grid-cols-3 gap-4 pt-4">
            {[
              { icon: '🌍', label: 'Global Directory', sub: 'Regulators & contacts for 40+ countries', href: '/directory' },
              { icon: '⚖️', label: 'Legal Tracker', sub: 'Regulatory actions against the company', href: '/legal' },
              { icon: '📱', label: 'Contacts', sub: 'All verified social media handles', href: `/${BRAND.contactsPageSlug}` },
            ].map(l => (
              <Link key={l.label} href={l.href} className="flex items-center gap-3 p-4 bg-white border border-gray-200 rounded-xl hover:border-red-300 hover:shadow-sm transition">
                <span className="text-2xl">{l.icon}</span>
                <div>
                  <div className="font-semibold text-gray-800 text-sm">{l.label}</div>
                  <div className="text-xs text-gray-500">{l.sub}</div>
                </div>
              </Link>
            ))}
          </section>

          <p className="text-xs text-gray-400 text-center pt-4">{guide.notLegalAdvice}</p>
        </main>

        <footer className="bg-gray-900 text-gray-500 text-center py-6 mt-12 text-xs">
          <p>{BRAND.name} &copy; {BRAND.foundedYear} &nbsp;|&nbsp; {BRAND.disclaimer.footer}</p>
        </footer>
      </div>
    </>
  )
}
