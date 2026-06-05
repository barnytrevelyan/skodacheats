import { useState } from 'react'
import Head from 'next/head'
import ComplaintForm from '../components/ComplaintForm'
import ComplaintList from '../components/ComplaintList'

export default function Home() {
  const [activeTab, setActiveTab] = useState('report')
  const [refreshKey, setRefreshKey] = useState(0)

  const handleSubmitSuccess = () => {
    setRefreshKey((prev) => prev + 1)
    setTimeout(() => setActiveTab('view'), 1000)
  }

  return (
    <>
      <Head>
        <title>UberCheats - Uber Refund & Charge Issues Database</title>
        <meta name="description" content="Document and view complaints about Uber refund and charging issues" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <div className="min-h-screen bg-white">
        <header className="relative h-96 bg-gray-900 overflow-hidden">
          <img
            src="https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?w=1200&h=400&fit=crop"
            alt="Documentation and complaints"
            className="absolute inset-0 w-full h-full object-cover opacity-40"
          />
          <div className="absolute inset-0 bg-black opacity-40"></div>
          <div className="relative max-w-6xl mx-auto px-4 py-12 sm:px-6 lg:px-8 flex flex-col justify-center h-full">
            <h1 className="text-4xl md:text-5xl font-bold text-white mb-2">UberCheats</h1>
            <p className="text-lg text-gray-100 max-w-2xl">
              A public record of Uber refund and charging issues. Document your case and help others affected by the same problems.
            </p>
          </div>
        </header>

        <main className="max-w-6xl mx-auto px-4 py-12 sm:px-6 lg:px-8">
          <div className="mb-6 flex gap-2 border-b border-gray-300">
            <button
              onClick={() => setActiveTab('report')}
              className={`px-4 py-3 font-semibold transition duration-200 border-b-2 ${
                activeTab === 'report'
                  ? 'border-blue-600 text-blue-600'
                  : 'border-transparent text-gray-600 hover:text-gray-900'
              }`}
            >
              Report an Issue
            </button>
            <button
              onClick={() => setActiveTab('view')}
              className={`px-4 py-3 font-semibold transition duration-200 border-b-2 ${
                activeTab === 'view'
                  ? 'border-blue-600 text-blue-600'
                  : 'border-transparent text-gray-600 hover:text-gray-900'
              }`}
            >
              View Cases
            </button>
          </div>

          {activeTab === 'report' && (
            <div className="max-w-2xl">
              <div className="mb-4 p-4 bg-blue-50 border border-blue-200 rounded-lg">
                <h3 className="font-semibold text-blue-900 mb-2">Why Report Here?</h3>
                <ul className="text-sm text-blue-800 space-y-1">
                  <li>✓ Create a public record of Uber's refund failures</li>
                  <li>✓ Help others who face similar issues</li>
                  <li>✓ Build evidence for potential legal action</li>
                  <li>✓ Put pressure on Uber to fix these problems</li>
                </ul>
              </div>
              <ComplaintForm onSubmitSuccess={handleSubmitSuccess} />
            </div>
          )}

          {activeTab === 'view' && <ComplaintList key={refreshKey} />}

          <div className="mt-12 p-6 bg-gray-100 rounded-lg text-sm text-gray-700">
            <h3 className="font-semibold mb-2">About This Site</h3>
            <p>
              UberCheats is an independent documentation of Uber service failures related to refunds and billing.
              This site was created because Uber has failed to properly resolve these issues for countless customers.
              Your story matters and helps expose systemic problems.
            </p>
          </div>
        </main>

        <footer className="bg-gray-800 text-gray-300 text-center py-6 mt-12">
          <p>UberCheats © 2026 | Not affiliated with Uber</p>
        </footer>
      </div>
    </>
  )
}
