import type { Metadata } from 'next'
import { Syne, JetBrains_Mono, Inter } from 'next/font/google'
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
  title: 'ABOULABS — Engineering the Future',
  description: 'SaaS solutions and digital consulting for Morocco\'s businesses — built to world-class standards.',
  keywords: ['SaaS', 'Morocco', 'Digital Transformation', 'Web Development', 'Consulting'],
  authors: [{ name: 'ABOULABS' }],
  openGraph: {
    title: 'ABOULABS — Engineering the Future',
    description: 'SaaS solutions and digital consulting for Morocco\'s businesses.',
    type: 'website',
    locale: 'en_US',
  },
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html
      lang="en"
      className={`${syne.variable} ${jetbrains.variable} ${inter.variable}`}
    >
      <body className="font-inter antialiased">
        {children}
      </body>
    </html>
  )
}