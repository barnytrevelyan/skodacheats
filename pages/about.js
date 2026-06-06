import Head from 'next/head'
import Link from 'next/link'
import BRAND from '../config/brand.config'

const SITE_URL = process.env.NEXT_PUBLIC_SITE_URL || BRAND.domain

export default function About() {
  const { about } = BRAND
  return (
    <>
      <Head>
        <title>{BRAND.meta.aboutTitle}</title>
        <meta name="description" content={BRAND.meta.aboutDescription} />
        <link rel="canonical" href={`${SITE_URL}/about`} />
        <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify({
          '@context': 'https://schema.org', '@type': 'AboutPage',
          url: `${SITE_URL}/about`, name: `About ${BRAND.name}`,
          description: BRAND.meta.aboutDescription,
          publisher: { '@type': 'Organization', name: BRAND.name, url: SITE_URL, foundingDate: BRAND.foundedYear, areaServed: 'Worldwide' },
        }) }} />
      </Head>

      <div className="min-h-screen bg-gray-50">
        <nav className="bg-gray-900 text-white px-4 py-3 text-sm">
          <div className="max-w-4xl mx-auto flex items-center gap-2">
            <Link href="/" className="font-black text-base hover:underline">{BRAND.name}</Link>
            <span className="text-gray-500">/</span>
            <span className="text-gray-300">About</span>
          </div>
        </nav>

        <div className="relative bg-gray-900 overflow-hidden" style={{height: '160px'}}>
          <img src={about.heroImage} alt={about.heroImageAlt} className="absolute inset-0 w-full h-full object-cover opacity-25" />
          <div className="absolute inset-0 flex items-center px-6">
            <div className="max-w-4xl mx-auto">
              <h1 className="text-2xl font-black text-white">About {BRAND.name}</h1>
              <p className="text-gray-400 text-sm mt-1">Independent consumer advocacy · Worldwide</p>
            </div>
          </div>
        </div>

        <main id="main-content" className="max-w-3xl mx-auto px-4 py-10 sm:px-6">
          <p className="text-gray-500 text-sm mb-10">Founded {BRAND.foundedYear}</p>

          <div className="space-y-8 text-gray-700 leading-relaxed">
            <section>
              <h2 className="text-xl font-bold text-gray-900 mb-3">What is {BRAND.name}?</h2>
              <p>{about.heading} is an independent, consumer-run platform that documents {BRAND.targetProduct} billing failures worldwide. Every case submitted becomes a permanent, searchable public record.</p>
              <p className="mt-3">{about.body.split('Use the')[0].trim()}</p>
            </section>

            <section>
              <h2 className="text-xl font-bold text-gray-900 mb-3">What we offer</h2>
              <ul className="space-y-2 list-none">
                {about.whatWeOffer.map(([title, desc]) => (
                  <li key={title} className="flex gap-3">
                    <span className="font-semibold text-gray-800 shrink-0">{title}:</span>
                    <span>{desc}</span>
                  </li>
                ))}
              </ul>
            </section>

            <section>
              <h2 className="text-xl font-bold text-gray-900 mb-3">Our principles</h2>
              <ul className="space-y-2">
                {about.principles.map(([title, desc]) => (
                  <li key={title}><strong>{title}</strong> {desc}</li>
                ))}
                <li><strong>User content.</strong> {BRAND.disclaimer.userContent}</li>
              </ul>
            </section>

            <section>
              <h2 className="text-xl font-bold text-gray-900 mb-3">Legal notice</h2>
              <p className="p-4 bg-gray-100 rounded-lg text-sm text-gray-600">{BRAND.disclaimer.legalNotice}</p>
            </section>
          </div>

          <div className="mt-10 flex flex-wrap gap-3">
            <Link href="/guide" className={`px-4 py-2 ${BRAND.theme.primaryBtn} text-white font-semibold rounded-lg text-sm transition`}>📖 Guide</Link>
            <Link href="/directory" className="px-4 py-2 bg-gray-800 text-white font-semibold rounded-lg text-sm hover:bg-gray-900 transition">🌍 Directory</Link>
            <Link href="/" className="px-4 py-2 border border-gray-300 text-gray-700 font-semibold rounded-lg text-sm hover:bg-gray-50 transition">📝 Report a case</Link>
          </div>
        </main>

        <footer className="bg-gray-900 text-gray-500 text-center py-6 mt-12 text-xs">
          <p>{BRAND.name} &copy; {BRAND.foundedYear} &nbsp;|&nbsp; {BRAND.disclaimer.footer}</p>
        </footer>
      </div>
    </>
  )
}
