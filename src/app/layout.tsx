import type { Metadata } from 'next'
import { Syne, JetBrains_Mono, Inter } from 'next/font/google'
import { Analytics } from '@vercel/analytics/react'
import { LanguageProvider } from '@/lib/LanguageContext'
import './globals.css'

const syne = Syne({
  subsets: ['latin'],
  weight: ['400', '500', '600', '700', '800'],
  variable: '--font-syne',
})
const jetbrains = JetBrains_Mono({
  subsets: ['latin'],
  weight: ['300', '400', '500'],
  variable: '--font-jetbrains',
})
const inter = Inter({
  subsets: ['latin'],
  weight: ['300', '400', '500'],
  variable: '--font-inter',
})

export const metadata: Metadata = {
  title: 'ABOULABS — Solutions SaaS & Conseil Digital au Maroc',
  description: "ABOULABS est une société marocaine de conseil digital et de développement SaaS. Logiciels ERP pour garages, cabinets d'avocats et écoles privées. Basée à Ifrane, Maroc.",
  keywords: ['ERP Maroc', 'logiciel gestion garage Maroc', 'logiciel cabinet avocat Maroc', 'SaaS Maroc', 'conseil digital Maroc', 'digitalisation PME Maroc', 'ABOULABS'],
  openGraph: {
    title: 'ABOULABS — Solutions SaaS & Conseil Digital au Maroc',
    description: 'Logiciels ERP et conseil digital pour les PME marocaines.',
    url: 'https://aboulabs.ma',
    siteName: 'ABOULABS',
    locale: 'fr_MA',
    type: 'website',
  },
}

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="fr" className={`${syne.variable} ${jetbrains.variable} ${inter.variable}`}>
      <body className="font-inter antialiased">
        <LanguageProvider>
          {children}
        </LanguageProvider>
        <Analytics />
      </body>
    </html>
  )
}
