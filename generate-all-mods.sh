#!/bin/bash

echo "🚀 Building all 10 ABOULABS modifications..."
echo ""

# ── 1. WhatsApp Floating Button ────────────────────────────────
cat > src/components/ui/WhatsAppButton.tsx << 'ENDOFFILE'
'use client'

import { useState } from 'react'

export default function WhatsAppButton() {
  const [hovered, setHovered] = useState(false)
  // TODO: replace with real number
  const phone = '212600000000'

  return (
    <a
      href={`https://wa.me/${phone}`}
      target="_blank"
      rel="noopener noreferrer"
      style={{
        position: 'fixed',
        bottom: '24px',
        right: '24px',
        zIndex: 200,
        width: '52px',
        height: '52px',
        borderRadius: '50%',
        background: 'linear-gradient(135deg, #25D366, #128C7E)',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        textDecoration: 'none',
        boxShadow: hovered
          ? '0 0 0 4px rgba(37,211,102,0.2), 0 8px 32px rgba(37,211,102,0.4)'
          : '0 0 0 0px rgba(37,211,102,0), 0 4px 20px rgba(0,0,0,0.4)',
        transform: hovered ? 'scale(1.08)' : 'scale(1)',
        transition: 'all 0.3s cubic-bezier(0.23,1,0.32,1)',
      }}
      onMouseEnter={() => setHovered(true)}
      onMouseLeave={() => setHovered(false)}
      aria-label="Chat on WhatsApp"
    >
      <svg width="26" height="26" viewBox="0 0 24 24" fill="white">
        <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 00-3.48-8.413z"/>
      </svg>
    </a>
  )
}
ENDOFFILE
echo "✅ 1. WhatsAppButton.tsx created"

# ── 2. Language Context ────────────────────────────────────────
cat > src/lib/LanguageContext.tsx << 'ENDOFFILE'
'use client'

import { createContext, useContext, useState, ReactNode } from 'react'

type Lang = 'en' | 'fr'

interface LangCtx {
  lang: Lang
  setLang: (l: Lang) => void
  t: (en: string, fr: string) => string
}

const LanguageContext = createContext<LangCtx>({
  lang: 'en',
  setLang: () => {},
  t: (en) => en,
})

export function LanguageProvider({ children }: { children: ReactNode }) {
  const [lang, setLang] = useState<Lang>('en')
  const t = (en: string, fr: string) => lang === 'fr' ? fr : en
  return (
    <LanguageContext.Provider value={{ lang, setLang, t }}>
      {children}
    </LanguageContext.Provider>
  )
}

export function useLang() {
  return useContext(LanguageContext)
}
ENDOFFILE
echo "✅ 2. LanguageContext.tsx created"

# ── 3. layout.tsx — provider + analytics + SEO ────────────────
cat > src/app/layout.tsx << 'ENDOFFILE'
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
ENDOFFILE
echo "✅ 3. layout.tsx updated (SEO + Analytics + LanguageProvider)"

# ── 4. Navbar — FR/EN toggle ───────────────────────────────────
cat > src/components/layout/Navbar.tsx << 'ENDOFFILE'
'use client'

import { useEffect, useState } from 'react'
import Link from 'next/link'
import Image from 'next/image'
import { useLang } from '@/lib/LanguageContext'

const navLinks = [
  { labelEn: 'About',    labelFr: 'À propos', href: '#about'    },
  { labelEn: 'Products', labelFr: 'Produits',  href: '#products' },
  { labelEn: 'Services', labelFr: 'Services',  href: '#services' },
  { labelEn: 'Process',  labelFr: 'Processus', href: '#process'  },
  { labelEn: 'Contact',  labelFr: 'Contact',   href: '#contact'  },
]

function NavLink(props: { href: string; label: string }) {
  const [hovered, setHovered] = useState(false)
  return (
    <a
      href={props.href}
      style={{ color: hovered ? '#00f5c4' : '#7ba3b8', transition: 'color 0.3s', fontFamily: 'var(--font-jetbrains)', fontSize: '0.72rem', letterSpacing: '0.12em', textTransform: 'uppercase', textDecoration: 'none', position: 'relative', display: 'block' }}
      onMouseEnter={() => setHovered(true)}
      onMouseLeave={() => setHovered(false)}
    >
      {props.label}
      <span style={{ position: 'absolute', bottom: '-4px', left: 0, right: 0, height: '1px', background: '#00f5c4', transform: hovered ? 'scaleX(1)' : 'scaleX(0)', transformOrigin: 'left', transition: 'transform 0.3s' }} />
    </a>
  )
}

function LangToggle() {
  const { lang, setLang } = useLang()
  return (
    <div style={{ display: 'flex', alignItems: 'center', gap: '2px', border: '1px solid rgba(0,245,196,0.2)', padding: '4px 6px', background: 'rgba(0,245,196,0.03)' }}>
      {(['en', 'fr'] as const).map((l) => (
        <button
          key={l}
          onClick={() => setLang(l)}
          style={{
            fontFamily: 'var(--font-jetbrains)',
            fontSize: '0.62rem',
            letterSpacing: '0.1em',
            textTransform: 'uppercase',
            background: lang === l ? 'rgba(0,245,196,0.15)' : 'transparent',
            color: lang === l ? '#00f5c4' : '#3d6070',
            border: 'none',
            padding: '3px 8px',
            cursor: 'none',
            transition: 'all 0.2s',
          }}
        >
          {l}
        </button>
      ))}
    </div>
  )
}

function CtaButton(props: { label: string; onClick?: () => void }) {
  const [hovered, setHovered] = useState(false)
  return (
    <a
      href="#contact"
      onClick={props.onClick}
      style={{ background: 'linear-gradient(135deg,#00f5c4,#39ff9a)', color: '#020d14', fontFamily: 'var(--font-jetbrains)', fontSize: '0.72rem', letterSpacing: '0.1em', fontWeight: '500', padding: '10px 24px', textDecoration: 'none', display: 'inline-block', clipPath: 'polygon(10px 0%,100% 0%,calc(100% - 10px) 100%,0% 100%)', boxShadow: hovered ? '0 0 24px rgba(0,245,196,0.45)' : 'none', transition: 'box-shadow 0.3s' }}
      onMouseEnter={() => setHovered(true)}
      onMouseLeave={() => setHovered(false)}
    >
      {props.label}
    </a>
  )
}

export default function Navbar() {
  const [scrolled, setScrolled] = useState(false)
  const [menuOpen, setMenuOpen] = useState(false)
  const { lang, t } = useLang()

  useEffect(() => {
    const onScroll = () => setScrolled(window.scrollY > 50)
    window.addEventListener('scroll', onScroll)
    return () => window.removeEventListener('scroll', onScroll)
  }, [])

  return (
    <nav style={{ position: 'fixed', top: 0, left: 0, right: 0, zIndex: 100, padding: '0 5%', height: '70px', display: 'flex', alignItems: 'center', justifyContent: 'space-between', background: scrolled ? 'rgba(2,13,20,0.95)' : 'rgba(2,13,20,0.8)', backdropFilter: 'blur(20px)', borderBottom: '1px solid rgba(0,245,196,0.12)', transition: 'background 0.3s' }}>

      <Link href="/" style={{ display: 'flex', alignItems: 'center', gap: '12px', textDecoration: 'none' }}>
        <div style={{ width: '48px', height: '48px', filter: 'drop-shadow(0 0 8px rgba(0,245,196,0.5))' }}>
          <Image src="/logos/logo-mark.png" alt="ABOULABS" width={48} height={48} style={{ objectFit: 'contain', width: '100%', height: '100%' }} />
        </div>
        <span style={{ fontFamily: 'var(--font-syne)', fontWeight: '800', fontSize: '1.35rem', letterSpacing: '0.08em', background: 'linear-gradient(135deg,#00f5c4,#39ff9a)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent', backgroundClip: 'text' }}>
          ABOULABS
        </span>
      </Link>

      <ul className="hidden md:flex" style={{ alignItems: 'center', gap: '36px', listStyle: 'none', margin: 0, padding: 0 }}>
        {navLinks.map((link) => (
          <li key={link.href}>
            <NavLink href={link.href} label={lang === 'fr' ? link.labelFr : link.labelEn} />
          </li>
        ))}
      </ul>

      <div className="hidden md:flex" style={{ alignItems: 'center', gap: '12px' }}>
        <LangToggle />
        <CtaButton label={t('Get in Touch', 'Nous Contacter')} />
      </div>

      <button className="md:hidden" style={{ background: 'none', border: 'none', cursor: 'none', display: 'flex', flexDirection: 'column', gap: '5px', padding: '8px' }} onClick={() => setMenuOpen(!menuOpen)}>
        <span style={{ display: 'block', height: '1px', width: '24px', background: '#00f5c4', transform: menuOpen ? 'rotate(45deg) translate(4px,4px)' : 'none', transition: 'transform 0.3s' }} />
        <span style={{ display: 'block', height: '1px', width: '24px', background: '#00f5c4', opacity: menuOpen ? 0 : 1, transition: 'opacity 0.3s' }} />
        <span style={{ display: 'block', height: '1px', width: '24px', background: '#00f5c4', transform: menuOpen ? 'rotate(-45deg) translate(4px,-4px)' : 'none', transition: 'transform 0.3s' }} />
      </button>

      {menuOpen && (
        <div className="md:hidden" style={{ position: 'absolute', top: '70px', left: 0, right: 0, background: 'rgba(2,13,20,0.98)', borderBottom: '1px solid rgba(0,245,196,0.12)', display: 'flex', flexDirection: 'column' }}>
          {navLinks.map((link) => (
            <a key={link.href} href={link.href} onClick={() => setMenuOpen(false)} style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.75rem', letterSpacing: '0.15em', textTransform: 'uppercase', padding: '20px 5%', textDecoration: 'none', color: '#7ba3b8', borderBottom: '1px solid rgba(0,245,196,0.06)' }}>
              {lang === 'fr' ? link.labelFr : link.labelEn}
            </a>
          ))}
          <div style={{ padding: '16px 5%', display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
            <LangToggle />
            <CtaButton label={t('Get in Touch', 'Nous Contacter')} onClick={() => setMenuOpen(false)} />
          </div>
        </div>
      )}
    </nav>
  )
}
ENDOFFILE
echo "✅ 4. Navbar.tsx updated with FR/EN toggle"

# ── 5. Hero.tsx — translations + stat fix ─────────────────────
cat > src/components/sections/Hero.tsx << 'ENDOFFILE'
'use client'

import { motion } from 'framer-motion'
import { useLang } from '@/lib/LanguageContext'

const fadeUp = (delay = 0) => ({
  initial: { opacity: 0, y: 24 },
  animate: { opacity: 1, y: 0 },
  transition: { duration: 0.8, delay, ease: [0.23, 1, 0.32, 1] },
})

export default function Hero() {
  const { t } = useLang()

  const stats = [
    { num: '4+',   labelEn: 'SaaS Products',      labelFr: 'Produits SaaS'       },
    { num: '100%', labelEn: 'Online Delivery',     labelFr: 'Livraison en ligne'  },
    { num: '2025', labelEn: 'Founded',             labelFr: 'Fondée'              },
    { num: '∞',    labelEn: 'Scalable Solutions',  labelFr: 'Solutions scalables' },
  ]

  return (
    <section style={{ minHeight: '100vh', display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', padding: '120px 5% 80px', position: 'relative', overflow: 'hidden' }}>
      <div className="grid-bg" style={{ position: 'absolute', inset: 0, pointerEvents: 'none' }} />
      <div style={{ position: 'absolute', width: '600px', height: '600px', borderRadius: '50%', background: 'radial-gradient(circle,rgba(0,245,196,0.08) 0%,transparent 70%)', filter: 'blur(100px)', top: '-100px', left: '50%', transform: 'translateX(-50%)', pointerEvents: 'none' }} />
      <div style={{ position: 'absolute', width: '400px', height: '400px', borderRadius: '50%', background: 'radial-gradient(circle,rgba(57,255,154,0.06) 0%,transparent 70%)', filter: 'blur(100px)', bottom: 0, right: '10%', pointerEvents: 'none' }} />

      <motion.div {...fadeUp(0.1)}>
        <div style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.68rem', letterSpacing: '0.2em', color: '#00f5c4', border: '1px solid rgba(0,245,196,0.35)', padding: '6px 18px', marginBottom: '32px', background: 'rgba(0,245,196,0.04)', textTransform: 'uppercase' }}>
          {t('// Morocco\'s Premier Tech Studio //', '// Le Studio Tech de Référence au Maroc //')}
        </div>
      </motion.div>

      <motion.h1
        {...fadeUp(0.2)}
        style={{ fontFamily: 'var(--font-syne)', fontWeight: 800, fontSize: 'clamp(3rem,7vw,6.5rem)', lineHeight: 1.0, textAlign: 'center', maxWidth: '900px', marginBottom: '12px' }}
      >
        <span style={{ display: 'block', color: '#e8f4f8' }}>
          {t('We Engineer', 'Nous Façonnons')}
        </span>
        <span className="glitch" data-text={t('Digital Futures', "L'Avenir Numérique")} style={{ display: 'block', background: 'linear-gradient(135deg,#00f5c4 0%,#39ff9a 50%,#00e5ff 100%)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent', backgroundClip: 'text' }}>
          {t('Digital Futures', "L'Avenir Numérique")}
        </span>
      </motion.h1>

      <motion.p
        {...fadeUp(0.35)}
        style={{ fontFamily: 'var(--font-inter)', fontWeight: 300, fontSize: 'clamp(1rem,1.5vw,1.15rem)', color: '#7ba3b8', textAlign: 'center', maxWidth: '520px', lineHeight: 1.7, marginBottom: '48px' }}
      >
        {t(
          "SaaS solutions and digital consulting designed for Morocco's businesses — built to world-class standards, engineered for real impact.",
          "Des solutions SaaS et du conseil digital conçus pour les entreprises marocaines — des standards internationaux, un impact concret."
        )}
      </motion.p>

      <motion.div {...fadeUp(0.45)} style={{ display: 'flex', gap: '16px', alignItems: 'center', flexWrap: 'wrap', justifyContent: 'center' }}>
        <a href="#products" style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.8rem', letterSpacing: '0.1em', color: '#020d14', background: 'linear-gradient(135deg,#00f5c4,#39ff9a)', padding: '14px 32px', textDecoration: 'none', clipPath: 'polygon(10px 0%,100% 0%,calc(100% - 10px) 100%,0% 100%)', fontWeight: 600 }}>
          {t('Explore Products', 'Découvrir nos produits')}
        </a>
        <a href="#contact" style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.8rem', letterSpacing: '0.1em', color: '#00f5c4', border: '1px solid rgba(0,245,196,0.35)', padding: '14px 32px', textDecoration: 'none', background: 'transparent' }}>
          {t('Start a Project', 'Démarrer un projet')}
        </a>
      </motion.div>

      <motion.div {...fadeUp(0.6)} style={{ display: 'flex', gap: '60px', marginTop: '80px', paddingTop: '40px', borderTop: '1px solid rgba(0,245,196,0.12)', flexWrap: 'wrap', justifyContent: 'center' }}>
        {stats.map((stat) => (
          <div key={stat.labelEn} style={{ textAlign: 'center' }}>
            <span style={{ display: 'block', fontFamily: 'var(--font-syne)', fontWeight: 800, fontSize: '2rem', background: 'linear-gradient(135deg,#00f5c4,#39ff9a)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent', backgroundClip: 'text' }}>
              {stat.num}
            </span>
            <span style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.65rem', letterSpacing: '0.15em', color: '#3d6070', textTransform: 'uppercase', marginTop: '4px', display: 'block' }}>
              {t(stat.labelEn, stat.labelFr)}
            </span>
          </div>
        ))}
      </motion.div>
    </section>
  )
}
ENDOFFILE
echo "✅ 5. Hero.tsx updated (translations + 2025 Founded stat)"

# ── 6. products.ts — status field + anchors ───────────────────
cat > src/data/products.ts << 'ENDOFFILE'
export type ProductType = 'web' | 'mobile'
export type ProductStatus = 'beta' | 'coming-soon'

export interface Product {
  id: string
  num: string
  icon: string
  name: string
  tagline: string
  description: string
  features: string[]
  type: ProductType
  logo?: string
  screenshot?: string
  status?: ProductStatus
  anchor: string
}

export const products: Product[] = [
  {
    id: 'pcs',
    num: '01',
    icon: '🚗',
    name: 'PCS',
    tagline: 'Premium Car Service',
    description: 'Full-spectrum ERP for garages and automotive businesses. Repair workflows, invoicing, and customer tracking unified in one intelligent platform.',
    features: ['Garage Management', 'Repair Workflow', 'Invoicing', 'Customer Tracking', 'Analytics'],
    type: 'web',
    logo: '/logos/pcs-logo.png',
    status: 'beta',
    anchor: 'product-pcs',
  },
  {
    id: 'cabinet',
    num: '02',
    icon: '⚖️',
    name: 'Cabi.NET',
    tagline: 'Legal Practice Management',
    description: 'Modern management system built exclusively for Moroccan law offices. Cases, clients, and documents organized with precision.',
    features: ['Case Management', 'Client Profiles', 'Document Hub', 'Billing', 'Deadlines'],
    type: 'web',
    logo: '/logos/cabinet-logo.png',
    status: 'beta',
    anchor: 'product-cabinet',
  },
  {
    id: 'edupath',
    num: '03',
    icon: '📚',
    name: 'EduPath',
    tagline: 'LMS for Moroccan Schools',
    description: 'Learning management for private schools from primaire to lycée. Curriculum building, progress tracking, and parent engagement unified.',
    features: ['Curriculum Builder', 'Progress Tracking', 'Parent Portal', 'Assignments', 'Gradebook'],
    type: 'web',
    logo: '/logos/edupath-logo.png',
    status: 'coming-soon',
    anchor: 'product-edupath',
  },
  {
    id: 'maw9if',
    num: '04',
    icon: '📍',
    name: 'Maw9if',
    tagline: 'Craftsman Marketplace',
    description: 'Mobile-first marketplace connecting Moroccan craftsmen with customers. Browse professionals, book services, and discover authentic local craft.',
    features: ['Artisan Profiles', 'Service Booking', 'Reviews', 'Location-Based', 'Messaging'],
    type: 'mobile',
    logo: '/logos/maw9if-logo.png',
    status: 'coming-soon',
    anchor: 'product-maw9if',
  },
]
ENDOFFILE
echo "✅ 6. products.ts updated (status + anchor fields)"

# ── 7. Products.tsx — anchors + status badges + learn more fix ─
cat > src/components/sections/Products.tsx << 'ENDOFFILE'
'use client'

import { useState } from 'react'
import Image from 'next/image'
import RevealWrapper from '@/components/ui/RevealWrapper'
import { products } from '@/data/products'

function StatusBadge({ status }: { status: 'beta' | 'coming-soon' }) {
  const isBeta = status === 'beta'
  return (
    <div style={{
      position: 'absolute',
      top: '16px',
      right: '16px',
      fontFamily: 'var(--font-jetbrains)',
      fontSize: '0.58rem',
      letterSpacing: '0.15em',
      padding: '3px 10px',
      border: `1px solid ${isBeta ? 'rgba(0,245,196,0.4)' : 'rgba(245,158,11,0.4)'}`,
      color: isBeta ? '#00f5c4' : '#f59e0b',
      background: isBeta ? 'rgba(0,245,196,0.06)' : 'rgba(245,158,11,0.06)',
      textTransform: 'uppercase',
      zIndex: 2,
    }}>
      {isBeta ? 'BETA' : 'COMING SOON'}
    </div>
  )
}

function PhoneMockup() {
  return (
    <div style={{ display: 'flex', justifyContent: 'center', gap: '16px', alignItems: 'flex-end' }}>
      {[
        { rotate: '-4deg', scale: '0.92', opacity: '0.75' },
        { rotate: '0deg',  scale: '1',    opacity: '1'    },
        { rotate: '4deg',  scale: '0.92', opacity: '0.75' },
      ].map((s, i) => (
        <div key={i} style={{ width: '110px', aspectRatio: '9/19', border: '2px solid rgba(0,245,196,0.35)', borderRadius: '16px', background: '#071826', overflow: 'hidden', transform: `rotate(${s.rotate}) scale(${s.scale})`, opacity: s.opacity, boxShadow: i === 1 ? '0 0 30px rgba(0,245,196,0.15)' : 'none', display: 'flex', flexDirection: 'column' }}>
          <div style={{ background: 'linear-gradient(135deg,rgba(0,245,196,0.18),rgba(57,255,154,0.08))', height: '28%', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '6px' }}>
            <Image src="/logos/maw9if-logo.png" alt="Maw9if" width={20} height={20} style={{ objectFit: 'contain' }} />
            <span style={{ fontFamily: 'var(--font-syne)', fontSize: '0.38rem', color: '#00f5c4', letterSpacing: '0.1em', fontWeight: 700 }}>MAW9IF</span>
          </div>
          <div style={{ flex: 1, padding: '4px', display: 'flex', flexDirection: 'column', gap: '3px' }}>
            {[80, 55, 75, 60, 85, 50].map((w, j) => (
              <div key={j} style={{ height: '10px', background: 'rgba(0,245,196,0.07)', borderRadius: '2px', borderLeft: '2px solid rgba(0,245,196,0.3)', width: `${w}%` }} />
            ))}
          </div>
        </div>
      ))}
    </div>
  )
}

function ProductCard({ product, index }: { product: typeof products[0]; index: number }) {
  const [hovered, setHovered] = useState(false)
  const isMobile = product.type === 'mobile'

  return (
    <RevealWrapper delay={index * 0.1} className={isMobile ? 'col-span-full' : ''}>
      <div
        id={product.anchor}
        style={{ background: '#0a1e2e', padding: '48px 40px', position: 'relative', overflow: 'hidden', transition: 'all 0.4s cubic-bezier(0.23,1,0.32,1)', transform: hovered ? 'translateY(-4px)' : 'translateY(0)', boxShadow: hovered ? '0 20px 60px rgba(0,0,0,0.5)' : 'none', display: isMobile ? 'grid' : 'flex', gridTemplateColumns: isMobile ? 'repeat(auto-fit,minmax(280px,1fr))' : undefined, flexDirection: isMobile ? undefined : 'column', gap: isMobile ? '48px' : '0', alignItems: isMobile ? 'center' : undefined, height: '100%' }}
        onMouseEnter={() => setHovered(true)}
        onMouseLeave={() => setHovered(false)}
      >
        {product.status && <StatusBadge status={product.status} />}
        <div style={{ position: 'absolute', top: 0, left: 0, right: 0, height: '2px', background: 'linear-gradient(90deg,#00f5c4,#39ff9a)', transform: hovered ? 'scaleX(1)' : 'scaleX(0)', transformOrigin: 'left', transition: 'transform 0.4s cubic-bezier(0.23,1,0.32,1)' }} />
        <div style={{ position: 'absolute', inset: 0, background: 'linear-gradient(135deg,rgba(0,245,196,0.05) 0%,transparent 60%)', opacity: hovered ? 1 : 0, transition: 'opacity 0.4s', pointerEvents: 'none' }} />

        <div style={{ position: 'relative', display: 'flex', flexDirection: 'column', flex: 1 }}>
          <div style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.65rem', letterSpacing: '0.2em', color: '#00f5c4', marginBottom: '28px', opacity: 0.7 }}>
            PRODUCT / {product.num}{product.type === 'mobile' ? ' — MOBILE APP' : ''}
          </div>

          <div style={{ width: '88px', height: '88px', border: '1px solid rgba(0,245,196,0.35)', display: 'flex', alignItems: 'center', justifyContent: 'center', marginBottom: '24px', background: hovered ? 'rgba(0,245,196,0.08)' : 'rgba(0,245,196,0.03)', clipPath: 'polygon(6px 0%,100% 0%,calc(100% - 6px) 100%,0% 100%)', transition: 'background 0.3s', padding: '14px' }}>
            {product.logo ? (
              <Image src={product.logo} alt={product.name} width={64} height={64} style={{ objectFit: 'contain', width: '100%', height: '100%' }} />
            ) : (
              <span style={{ fontSize: '1.5rem' }}>{product.icon}</span>
            )}
          </div>

          <div style={{ fontFamily: 'var(--font-syne)', fontWeight: 800, fontSize: '1.6rem', color: '#e8f4f8', marginBottom: '4px', lineHeight: 1 }}>{product.name}</div>
          <div style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.7rem', letterSpacing: '0.1em', color: '#00c4a7', marginBottom: '16px', textTransform: 'uppercase' }}>{product.tagline}</div>
          <p style={{ fontSize: '0.9rem', color: '#7ba3b8', lineHeight: 1.65, marginBottom: '24px', flex: 1 }}>{product.description}</p>

          <div style={{ display: 'flex', flexWrap: 'wrap', gap: '8px', marginBottom: '24px' }}>
            {product.features.map((f) => (
              <span key={f} style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.62rem', letterSpacing: '0.08em', color: hovered ? '#7ba3b8' : '#3d6070', border: `1px solid ${hovered ? 'rgba(0,245,196,0.25)' : 'rgba(0,245,196,0.12)'}`, padding: '4px 10px', background: 'rgba(0,245,196,0.02)', transition: 'all 0.3s' }}>
                {f}
              </span>
            ))}
          </div>

          <a href={`#${product.anchor}`} style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.72rem', letterSpacing: '0.12em', color: '#00f5c4', textDecoration: 'none', display: 'flex', alignItems: 'center', gap: '8px' }}>
            Learn more →
          </a>
        </div>

        {isMobile && (
          <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
            <PhoneMockup />
          </div>
        )}
      </div>
    </RevealWrapper>
  )
}

export default function Products() {
  return (
    <section id="products" style={{ padding: '120px 5%', maxWidth: '1200px', margin: '0 auto' }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-end', marginBottom: '64px', flexWrap: 'wrap', gap: '24px' }}>
        <RevealWrapper>
          <div style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.65rem', letterSpacing: '0.25em', color: '#00f5c4', textTransform: 'uppercase', marginBottom: '16px', display: 'flex', alignItems: 'center', gap: '12px' }}>
            <span style={{ width: '30px', height: '1px', background: '#00f5c4', display: 'inline-block' }} />
            Our Ecosystem
          </div>
          <h2 style={{ fontFamily: 'var(--font-syne)', fontWeight: 800, fontSize: 'clamp(2rem,4vw,3.2rem)', lineHeight: 1.15, color: '#e8f4f8' }}>
            The{' '}
            <span style={{ background: 'linear-gradient(135deg,#00f5c4,#39ff9a)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent', backgroundClip: 'text' }}>ABOULABS</span>
            <br />Product Suite
          </h2>
        </RevealWrapper>
        <RevealWrapper delay={0.1}>
          <p style={{ fontSize: '0.9rem', color: '#7ba3b8', maxWidth: '300px', lineHeight: 1.7 }}>
            Four vertical SaaS solutions built to digitalize and scale Moroccan industries.
          </p>
        </RevealWrapper>
      </div>
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit,minmax(340px,1fr))', gap: '2px', background: 'rgba(0,245,196,0.12)' }}>
        {products.map((product, i) => (
          <ProductCard key={product.id} product={product} index={i} />
        ))}
      </div>
    </section>
  )
}
ENDOFFILE
echo "✅ 7. Products.tsx updated (anchors + status badges + learn more fix)"

# ── 8. CTA.tsx — contact form + translations ──────────────────
cat > src/components/sections/CTA.tsx << 'ENDOFFILE'
'use client'

import { useState } from 'react'
import { useLang } from '@/lib/LanguageContext'

function InputField({ label, name, type = 'text', value, onChange }: { label: string; name: string; type?: string; value: string; onChange: (v: string) => void }) {
  const [focused, setFocused] = useState(false)
  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
      <label style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.65rem', letterSpacing: '0.15em', color: '#3d6070', textTransform: 'uppercase' }}>{label}</label>
      <input
        type={type}
        name={name}
        value={value}
        onChange={e => onChange(e.target.value)}
        onFocus={() => setFocused(true)}
        onBlur={() => setFocused(false)}
        style={{ background: 'rgba(0,245,196,0.03)', border: `1px solid ${focused ? 'rgba(0,245,196,0.5)' : 'rgba(0,245,196,0.15)'}`, color: '#e8f4f8', fontFamily: 'var(--font-inter)', fontSize: '0.9rem', padding: '12px 16px', outline: 'none', transition: 'border-color 0.3s', boxShadow: focused ? '0 0 0 3px rgba(0,245,196,0.06)' : 'none', width: '100%', boxSizing: 'border-box' }}
      />
    </div>
  )
}

function TextareaField({ label, name, value, onChange, placeholder }: { label: string; name: string; value: string; onChange: (v: string) => void; placeholder?: string }) {
  const [focused, setFocused] = useState(false)
  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
      <label style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.65rem', letterSpacing: '0.15em', color: '#3d6070', textTransform: 'uppercase' }}>{label}</label>
      <textarea
        name={name}
        value={value}
        placeholder={placeholder}
        onChange={e => onChange(e.target.value)}
        onFocus={() => setFocused(true)}
        onBlur={() => setFocused(false)}
        rows={4}
        style={{ background: 'rgba(0,245,196,0.03)', border: `1px solid ${focused ? 'rgba(0,245,196,0.5)' : 'rgba(0,245,196,0.15)'}`, color: '#e8f4f8', fontFamily: 'var(--font-inter)', fontSize: '0.9rem', padding: '12px 16px', outline: 'none', transition: 'border-color 0.3s', resize: 'vertical', boxShadow: focused ? '0 0 0 3px rgba(0,245,196,0.06)' : 'none', width: '100%', boxSizing: 'border-box' }}
      />
    </div>
  )
}

export default function CTA() {
  const { t } = useLang()
  const [form, setForm] = useState({ name: '', company: '', message: '' })
  const [submitted, setSubmitted] = useState(false)
  const [btnHovered, setBtnHovered] = useState(false)

  const handleSubmit = () => {
    if (!form.name || !form.message) return
    setSubmitted(true)
  }

  return (
    <section id="contact" style={{ padding: '140px 5%', position: 'relative', overflow: 'hidden' }}>
      <div style={{ position: 'absolute', width: '800px', height: '800px', borderRadius: '50%', background: 'radial-gradient(circle,rgba(0,245,196,0.06) 0%,transparent 70%)', top: '50%', left: '50%', transform: 'translate(-50%,-50%)', pointerEvents: 'none' }} />

      <div style={{ maxWidth: '700px', margin: '0 auto', position: 'relative' }}>
        {/* Headline */}
        <div style={{ textAlign: 'center', marginBottom: '56px' }}>
          <div style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.7rem', letterSpacing: '0.2em', color: '#00f5c4', textTransform: 'uppercase', marginBottom: '24px' }}>
            {t('// Ready to build?', '// Prêt à construire ?')}
          </div>
          <h2 style={{ fontFamily: 'var(--font-syne)', fontWeight: 800, fontSize: 'clamp(2.2rem,4vw,3.8rem)', lineHeight: 1.1, color: '#e8f4f8', marginBottom: '24px' }}>
            {t('Your Digital ', 'Votre ')}
            <span style={{ background: 'linear-gradient(135deg,#00f5c4,#39ff9a)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent', backgroundClip: 'text' }}>
              {t('Transformation', 'Transformation Digitale')}
            </span>
            {t(' Starts Here.', ' Commence Ici.')}
          </h2>
          <p style={{ fontSize: '1rem', color: '#7ba3b8', lineHeight: 1.7 }}>
            {t(
              "Whether you're exploring a new product idea, need to digitalize your operations, or want to integrate our SaaS solutions — let's talk.",
              "Que vous explorez une nouvelle idée de produit, souhaitez digitaliser vos opérations, ou intégrer nos solutions SaaS — parlons-en."
            )}
          </p>
        </div>

        {/* Form */}
        {submitted ? (
          <div style={{ border: '1px solid rgba(0,245,196,0.35)', background: 'rgba(0,245,196,0.05)', padding: '40px', textAlign: 'center' }}>
            <div style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.7rem', letterSpacing: '0.15em', color: '#00f5c4', marginBottom: '12px', textTransform: 'uppercase' }}>
              {t('// Message Sent', '// Message Envoyé')}
            </div>
            <p style={{ color: '#7ba3b8', fontSize: '0.95rem', lineHeight: 1.7 }}>
              {t("Thank you! We'll be in touch very soon.", "Merci ! Nous vous répondrons très prochainement.")}
            </p>
          </div>
        ) : (
          <div style={{ display: 'flex', flexDirection: 'column', gap: '20px', border: '1px solid rgba(0,245,196,0.12)', background: 'rgba(0,245,196,0.02)', padding: '40px' }}>
            <InputField
              label={t('Full Name', 'Nom complet')}
              name="name"
              value={form.name}
              onChange={v => setForm(f => ({ ...f, name: v }))}
            />
            <InputField
              label={t('Company / Organization', 'Entreprise / Organisation')}
              name="company"
              value={form.company}
              onChange={v => setForm(f => ({ ...f, company: v }))}
            />
            <TextareaField
              label={t('What do you need?', 'De quoi avez-vous besoin ?')}
              name="message"
              value={form.message}
              onChange={v => setForm(f => ({ ...f, message: v }))}
              placeholder={t('Tell us about your project...', 'Parlez-nous de votre projet...')}
            />
            <button
              onClick={handleSubmit}
              style={{ alignSelf: 'flex-start', fontFamily: 'var(--font-jetbrains)', fontSize: '0.8rem', letterSpacing: '0.1em', color: '#020d14', background: 'linear-gradient(135deg,#00f5c4,#39ff9a)', padding: '14px 36px', border: 'none', clipPath: 'polygon(10px 0%,100% 0%,calc(100% - 10px) 100%,0% 100%)', fontWeight: 600, cursor: 'none', transition: 'all 0.3s', boxShadow: btnHovered ? '0 0 24px rgba(0,245,196,0.4)' : 'none' }}
              onMouseEnter={() => setBtnHovered(true)}
              onMouseLeave={() => setBtnHovered(false)}
            >
              {t('Send Message', 'Envoyer')}
            </button>
          </div>
        )}

        {/* Secondary email link */}
        <div style={{ textAlign: 'center', marginTop: '28px' }}>
          <span style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.7rem', color: '#3d6070', letterSpacing: '0.08em' }}>
            {t('or email us directly at ', 'ou écrivez-nous à ')}
          </span>
          <a href="mailto:contact@aboulabs.com" style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.7rem', color: '#00f5c4', textDecoration: 'none', letterSpacing: '0.08em' }}>
            contact@aboulabs.com
          </a>
        </div>
      </div>
    </section>
  )
}
ENDOFFILE
echo "✅ 8. CTA.tsx updated (contact form + translations)"

# ── 9. Founder.tsx ─────────────────────────────────────────────
cat > src/components/sections/Founder.tsx << 'ENDOFFILE'
'use client'

import Image from 'next/image'
import RevealWrapper from '@/components/ui/RevealWrapper'
import { useLang } from '@/lib/LanguageContext'

export default function Founder() {
  const { t } = useLang()

  return (
    <section style={{ padding: '120px 5%', maxWidth: '1200px', margin: '0 auto', position: 'relative' }}>

      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit,minmax(320px,1fr))', gap: '80px', alignItems: 'center' }}>

        {/* Left — Photo column */}
        <RevealWrapper direction="left">
          <div style={{ position: 'relative', maxWidth: '420px', margin: '0 auto' }}>

            {/* Outer glow orb */}
            <div style={{ position: 'absolute', inset: '-40px', borderRadius: '50%', background: 'radial-gradient(circle,rgba(0,245,196,0.08) 0%,transparent 70%)', filter: 'blur(40px)', pointerEvents: 'none' }} />

            {/* Grid bg behind photo */}
            <div className="grid-bg" style={{ position: 'absolute', inset: 0, borderRadius: '4px', opacity: 0.6, pointerEvents: 'none' }} />

            {/* Animated corner accents */}
            {[
              { top: 0,    left: 0,    borderTop: '2px solid #00f5c4',  borderLeft: '2px solid #00f5c4'  },
              { top: 0,    right: 0,   borderTop: '2px solid #39ff9a',  borderRight: '2px solid #39ff9a' },
              { bottom: 0, left: 0,    borderBottom: '2px solid #39ff9a', borderLeft: '2px solid #39ff9a' },
              { bottom: 0, right: 0,   borderBottom: '2px solid #00f5c4', borderRight: '2px solid #00f5c4' },
            ].map((corner, i) => (
              <div
                key={i}
                style={{
                  position: 'absolute',
                  width: '28px',
                  height: '28px',
                  zIndex: 3,
                  ...corner,
                }}
              />
            ))}

            {/* Teal border frame */}
            <div style={{ position: 'absolute', inset: '0', border: '1px solid rgba(0,245,196,0.2)', zIndex: 2, pointerEvents: 'none' }} />

            {/* Photo */}
            <div style={{ position: 'relative', overflow: 'hidden', clipPath: 'polygon(0 0,100% 0,100% 92%,92% 100%,0 100%)', aspectRatio: '4/5' }}>
              <Image
                src="/founder.jpg"
                alt="Soufiane Aboulhamam — Founder of ABOULABS"
                fill
                style={{ objectFit: 'cover', objectPosition: 'center top', filter: 'contrast(1.05) brightness(0.95)' }}
              />
              {/* Teal overlay tint */}
              <div style={{ position: 'absolute', inset: 0, background: 'linear-gradient(180deg, transparent 50%, rgba(2,13,20,0.7) 100%)', zIndex: 1 }} />
            </div>

            {/* Floating credential card */}
            <div style={{ position: 'absolute', bottom: '-20px', right: '-20px', background: '#0a1e2e', border: '1px solid rgba(0,245,196,0.25)', padding: '14px 18px', zIndex: 4, boxShadow: '0 8px 40px rgba(0,0,0,0.5)' }}>
              <div style={{ fontFamily: 'var(--font-syne)', fontWeight: 700, fontSize: '0.85rem', color: '#e8f4f8', marginBottom: '4px' }}>Soufiane Aboulhamam</div>
              <div style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.6rem', letterSpacing: '0.1em', color: '#00f5c4', textTransform: 'uppercase' }}>Founder, ABOULABS</div>
            </div>

          </div>
        </RevealWrapper>

        {/* Right — Content column */}
        <RevealWrapper delay={0.15}>
          <div style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.65rem', letterSpacing: '0.25em', color: '#00f5c4', textTransform: 'uppercase', marginBottom: '16px', display: 'flex', alignItems: 'center', gap: '12px' }}>
            <span style={{ width: '30px', height: '1px', background: '#00f5c4', display: 'inline-block' }} />
            {t('The Builder', 'Le Bâtisseur')}
          </div>

          <h2 style={{ fontFamily: 'var(--font-syne)', fontWeight: 800, fontSize: 'clamp(2rem,4vw,3.2rem)', lineHeight: 1.15, color: '#e8f4f8', marginBottom: '24px' }}>
            {t('Meet the ', 'Rencontrez le ')}<span style={{ background: 'linear-gradient(135deg,#00f5c4,#39ff9a)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent', backgroundClip: 'text' }}>{t('Founder', 'Fondateur')}</span>
          </h2>

          {/* Role line */}
          <div style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.75rem', letterSpacing: '0.1em', color: '#7ba3b8', marginBottom: '24px', display: 'flex', alignItems: 'center', gap: '8px' }}>
            <span style={{ width: '16px', height: '1px', background: 'rgba(0,245,196,0.4)', display: 'inline-block' }} />
            ERP Administrator · Al Akhawayn University, Ifrane
          </div>

          {/* Credential badges */}
          <div style={{ display: 'flex', flexWrap: 'wrap', gap: '8px', marginBottom: '32px' }}>
            {['Certified GenAI Expert', 'ITS Department · AUI'].map((badge) => (
              <span key={badge} style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.62rem', letterSpacing: '0.08em', color: '#00c4a7', border: '1px solid rgba(0,245,196,0.25)', padding: '5px 12px', background: 'rgba(0,245,196,0.04)' }}>
                {badge}
              </span>
            ))}
          </div>

          {/* Quote block */}
          <blockquote style={{ position: 'relative', margin: '0 0 32px 0', padding: '24px 28px', border: '1px solid rgba(0,245,196,0.12)', background: 'rgba(0,245,196,0.02)', borderLeft: '3px solid #00f5c4' }}>
            {/* Quote mark */}
            <div style={{ fontFamily: 'var(--font-syne)', fontSize: '4rem', color: 'rgba(0,245,196,0.15)', lineHeight: 1, position: 'absolute', top: '8px', left: '16px', fontWeight: 800 }}>"</div>
            <p style={{ fontSize: '0.95rem', color: '#7ba3b8', lineHeight: 1.75, fontStyle: 'italic', position: 'relative', zIndex: 1, margin: '16px 0 16px 0' }}>
              {t(
                'ABOULABS was built out of a simple observation: Moroccan businesses deserve world-class software, designed for their reality. I started this as a solo builder, applying AI-first engineering to build faster, smarter, and closer to the ground.',
                "ABOULABS est né d'une observation simple : les entreprises marocaines méritent des logiciels de classe mondiale, conçus pour leur réalité. J'ai démarré ce projet en solo, en appliquant une ingénierie axée sur l'IA pour construire plus vite, plus intelligemment, au plus près du terrain."
              )}
            </p>
            <div style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.65rem', letterSpacing: '0.12em', color: '#00f5c4', textTransform: 'uppercase' }}>
              — Soufiane Aboulhamam, {t('Founder', 'Fondateur')}
            </div>
          </blockquote>

        </RevealWrapper>
      </div>
    </section>
  )
}
ENDOFFILE
echo "✅ 9. Founder.tsx created"

# ── 10. Footer.tsx — social SVG icons ─────────────────────────
cat > src/components/layout/Footer.tsx << 'ENDOFFILE'
'use client'

import { useState } from 'react'
import Link from 'next/link'
import Image from 'next/image'

function LinkedInIcon() {
  return (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor">
      <path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z"/>
      <rect x="2" y="9" width="4" height="12"/><circle cx="4" cy="4" r="2"/>
    </svg>
  )
}

function InstagramIcon() {
  return (
    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      <rect x="2" y="2" width="20" height="20" rx="5" ry="5"/>
      <path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"/>
      <line x1="17.5" y1="6.5" x2="17.51" y2="6.5"/>
    </svg>
  )
}

function SocialLink({ href, label, Icon }: { href: string; label: string; Icon: () => JSX.Element }) {
  const [hovered, setHovered] = useState(false)
  return (
    <a
      href={href}
      target="_blank"
      rel="noopener noreferrer"
      aria-label={label}
      style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', width: '36px', height: '36px', border: `1px solid ${hovered ? 'rgba(0,245,196,0.4)' : 'rgba(0,245,196,0.12)'}`, color: hovered ? '#00f5c4' : '#3d6070', background: hovered ? 'rgba(0,245,196,0.06)' : 'transparent', transition: 'all 0.3s', textDecoration: 'none' }}
      onMouseEnter={() => setHovered(true)}
      onMouseLeave={() => setHovered(false)}
    >
      <Icon />
    </a>
  )
}

function FooterLink(props: { href: string; label: string }) {
  const [hovered, setHovered] = useState(false)
  return (
    <a href={props.href} style={{ fontSize: '0.88rem', color: hovered ? '#00f5c4' : '#7ba3b8', textDecoration: 'none', transition: 'color 0.3s' }} onMouseEnter={() => setHovered(true)} onMouseLeave={() => setHovered(false)}>
      {props.label}
    </a>
  )
}

const footerLinks = {
  Products: [
    { label: 'PCS — Premium Car Service',   href: '#product-pcs'     },
    { label: 'Cabi.NET — Legal Management', href: '#product-cabinet'  },
    { label: 'EduPath — School LMS',        href: '#product-edupath'  },
    { label: 'Maw9if — Mobile App',         href: '#product-maw9if'   },
  ],
  Company: [
    { label: 'About',    href: '#about'    },
    { label: 'Services', href: '#services' },
    { label: 'Process',  href: '#process'  },
    { label: 'Contact',  href: '#contact'  },
  ],
}

export default function Footer() {
  return (
    <footer style={{ position: 'relative', zIndex: 2, borderTop: '1px solid rgba(0,245,196,0.12)' }}>
      <div style={{ maxWidth: '1200px', margin: '0 auto', padding: '60px 5% 40px' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', paddingBottom: '48px', borderBottom: '1px solid rgba(0,245,196,0.12)', flexWrap: 'wrap', gap: '40px' }}>

          {/* Brand */}
          <div>
            <Link href="/" style={{ display: 'flex', alignItems: 'center', gap: '12px', textDecoration: 'none' }}>
              <div style={{ width: '28px', height: '28px', filter: 'drop-shadow(0 0 6px rgba(0,245,196,0.5))' }}>
                <Image src="/logos/logo-mark.png" alt="ABOULABS" width={28} height={28} style={{ objectFit: 'contain', width: '100%', height: '100%' }} />
              </div>
              <span style={{ fontFamily: 'var(--font-syne)', fontWeight: 800, fontSize: '1rem', letterSpacing: '0.08em', background: 'linear-gradient(135deg,#00f5c4,#39ff9a)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent', backgroundClip: 'text' }}>
                ABOULABS
              </span>
            </Link>
            <p style={{ fontSize: '0.85rem', color: '#3d6070', maxWidth: '260px', lineHeight: 1.6, marginTop: '16px', marginBottom: '20px' }}>
              Engineering digital futures for Moroccan businesses and beyond.
            </p>
            {/* Social icons */}
            <div style={{ display: 'flex', gap: '8px' }}>
              {/* TODO: update LinkedIn URL */}
              <SocialLink href="https://linkedin.com/company/aboulabs" label="LinkedIn" Icon={LinkedInIcon} />
              {/* TODO: update Instagram URL */}
              <SocialLink href="https://instagram.com/aboulabs" label="Instagram" Icon={InstagramIcon} />
            </div>
          </div>

          {/* Link groups */}
          {Object.entries(footerLinks).map(([group, links]) => (
            <div key={group}>
              <h4 style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.65rem', letterSpacing: '0.2em', color: '#3d6070', textTransform: 'uppercase', marginBottom: '20px' }}>{group}</h4>
              <ul style={{ listStyle: 'none', padding: 0, margin: 0, display: 'flex', flexDirection: 'column', gap: '12px' }}>
                {links.map((link) => (
                  <li key={link.label}><FooterLink href={link.href} label={link.label} /></li>
                ))}
              </ul>
            </div>
          ))}

          {/* Contact column */}
          <div>
            <h4 style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.65rem', letterSpacing: '0.2em', color: '#3d6070', textTransform: 'uppercase', marginBottom: '20px' }}>Contact</h4>
            <ul style={{ listStyle: 'none', padding: 0, margin: 0, display: 'flex', flexDirection: 'column', gap: '12px' }}>
              <li><FooterLink href="mailto:contact@aboulabs.com" label="contact@aboulabs.com" /></li>
              <li><FooterLink href="#contact" label="Send a Message" /></li>
            </ul>
          </div>

        </div>

        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', paddingTop: '32px', flexWrap: 'wrap', gap: '16px' }}>
          <div style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.65rem', letterSpacing: '0.1em', color: '#3d6070' }}>
            © 2025 <span style={{ color: '#00f5c4' }}>ABOULABS</span>. All rights reserved. — Ifrane, Morocco
          </div>
          <div style={{ display: 'flex', alignItems: 'center', gap: '8px', fontFamily: 'var(--font-jetbrains)', fontSize: '0.65rem', letterSpacing: '0.1em', color: '#3d6070' }}>
            <span style={{ width: '6px', height: '6px', background: '#39ff9a', borderRadius: '50%', boxShadow: '0 0 8px #39ff9a', display: 'inline-block', animation: 'pulseDot 2s ease-in-out infinite' }} />
            All Systems Operational
          </div>
        </div>
      </div>
    </footer>
  )
}
ENDOFFILE
echo "✅ 10. Footer.tsx updated (LinkedIn + Instagram SVG icons)"

# ── 11. page.tsx — wire everything ────────────────────────────
cat > src/app/page.tsx << 'ENDOFFILE'
import Cursor          from '@/components/ui/Cursor'
import WhatsAppButton  from '@/components/ui/WhatsAppButton'
import Navbar          from '@/components/layout/Navbar'
import Footer          from '@/components/layout/Footer'
import Hero            from '@/components/sections/Hero'
import Ticker          from '@/components/sections/Ticker'
import About           from '@/components/sections/About'
import Founder         from '@/components/sections/Founder'
import Products        from '@/components/sections/Products'
import Services        from '@/components/sections/Services'
import Process         from '@/components/sections/Process'
import CTA             from '@/components/sections/CTA'

export default function Home() {
  return (
    <>
      <Cursor />
      <WhatsAppButton />
      <Navbar />
      <main>
        <Hero />
        <Ticker />
        <About />
        <Founder />
        <Products />
        <Services />
        <Process />
        <CTA />
      </main>
      <Footer />
    </>
  )
}
ENDOFFILE
echo "✅ 11. page.tsx finalized"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 All 10 modifications complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Next: install @vercel/analytics"
echo "  npm install @vercel/analytics"
echo ""
echo "Then: add your founder photo"
echo "  mv ~/Downloads/your-photo.jpg public/founder.jpg"
echo ""
echo "Then: npm run dev → localhost:3000"
