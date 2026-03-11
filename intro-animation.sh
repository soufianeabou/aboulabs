#!/bin/bash

echo "🎬 Building intro animation + logo updates..."

# ── 1. PageIntro.tsx — 3s cinematic logo reveal ───────────────
cat > src/components/ui/PageIntro.tsx << 'ENDOFFILE'
'use client'

import { useEffect, useState } from 'react'
import Image from 'next/image'

export default function PageIntro() {
  const [phase, setPhase] = useState<'enter' | 'hold' | 'exit' | 'done'>('enter')

  useEffect(() => {
    // Phase timeline:
    // 0ms    → mark fades + scales in
    // 600ms  → hold (mark glows, scanline sweeps)
    // 1600ms → lines expand outward + wordmark fades in
    // 2600ms → entire overlay slides up and away
    // 3100ms → done, unmount

    const t1 = setTimeout(() => setPhase('hold'),  600)
    const t2 = setTimeout(() => setPhase('exit'),  1600)
    const t3 = setTimeout(() => setPhase('done'),  3200)
    return () => { clearTimeout(t1); clearTimeout(t2); clearTimeout(t3) }
  }, [])

  if (phase === 'done') return null

  const isEnter = phase === 'enter'
  const isHold  = phase === 'hold'
  const isExit  = phase === 'exit'

  return (
    <div
      style={{
        position: 'fixed',
        inset: 0,
        zIndex: 9999,
        background: '#020d14',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        flexDirection: 'column',
        overflow: 'hidden',
        // Slide up on exit
        transform: isExit ? 'translateY(-100%)' : 'translateY(0)',
        transition: isExit ? 'transform 0.65s cubic-bezier(0.76,0,0.24,1)' : 'none',
      }}
    >
      {/* Grid background — same as page */}
      <div style={{
        position: 'absolute', inset: 0, pointerEvents: 'none',
        backgroundImage: `
          linear-gradient(rgba(0,245,196,0.04) 1px, transparent 1px),
          linear-gradient(90deg, rgba(0,245,196,0.04) 1px, transparent 1px)
        `,
        backgroundSize: '60px 60px',
        opacity: isEnter ? 0 : isExit ? 0 : 1,
        transition: 'opacity 0.6s',
      }} />

      {/* Radial glow behind logo */}
      <div style={{
        position: 'absolute',
        width: '500px', height: '500px',
        borderRadius: '50%',
        background: 'radial-gradient(circle, rgba(0,245,196,0.12) 0%, transparent 70%)',
        filter: 'blur(60px)',
        opacity: isEnter ? 0 : isExit ? 0 : 1,
        transition: 'opacity 0.8s',
        pointerEvents: 'none',
      }} />

      {/* ── Expanding horizontal lines ── */}
      {/* Top line */}
      <div style={{
        position: 'absolute',
        top: '50%',
        left: '50%',
        transform: 'translate(-50%, -50%)',
        width: isExit ? '100vw' : '0px',
        height: '1px',
        background: 'linear-gradient(90deg, transparent, #00f5c4, transparent)',
        marginTop: '-60px',
        transition: isExit ? 'width 0.5s cubic-bezier(0.23,1,0.32,1)' : 'none',
        opacity: isExit ? 0.6 : 0,
      }} />
      {/* Bottom line */}
      <div style={{
        position: 'absolute',
        top: '50%',
        left: '50%',
        transform: 'translate(-50%, -50%)',
        width: isExit ? '100vw' : '0px',
        height: '1px',
        background: 'linear-gradient(90deg, transparent, #00f5c4, transparent)',
        marginTop: '60px',
        transition: isExit ? 'width 0.5s cubic-bezier(0.23,1,0.32,1)' : 'none',
        opacity: isExit ? 0.6 : 0,
      }} />

      {/* ── Logo container ── */}
      <div style={{
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        gap: '28px',
        position: 'relative',
      }}>

        {/* Mark — scales + fades in, then scales up slightly on exit */}
        <div style={{
          width: '80px',
          height: '80px',
          position: 'relative',
          opacity: isEnter ? 0 : isExit ? 0 : 1,
          transform: isEnter
            ? 'scale(0.6)'
            : isExit
            ? 'scale(1.15)'
            : 'scale(1)',
          transition: isEnter
            ? 'opacity 0.5s ease, transform 0.5s cubic-bezier(0.23,1,0.32,1)'
            : isExit
            ? 'opacity 0.4s ease, transform 0.5s ease'
            : 'none',
          filter: isHold
            ? 'drop-shadow(0 0 24px rgba(0,245,196,0.7)) drop-shadow(0 0 8px rgba(57,255,154,0.5))'
            : 'drop-shadow(0 0 8px rgba(0,245,196,0.3))',
        }}>
          <Image
            src="/logos/logo-mark.png"
            alt="ABOULABS"
            fill
            style={{ objectFit: 'contain' }}
            priority
          />
        </div>

        {/* Wordmark — slides up + fades in during exit phase */}
        <div style={{
          width: '220px',
          height: '27px',
          position: 'relative',
          opacity: isExit ? 1 : 0,
          transform: isExit ? 'translateY(0)' : 'translateY(12px)',
          transition: isExit
            ? 'opacity 0.4s ease 0.05s, transform 0.4s cubic-bezier(0.23,1,0.32,1) 0.05s'
            : 'none',
          filter: 'drop-shadow(0 0 8px rgba(0,245,196,0.25))',
        }}>
          <Image
            src="/logos/logo-full.png"
            alt="ABOULABS"
            fill
            style={{ objectFit: 'contain', objectPosition: 'center' }}
            priority
          />
        </div>

        {/* Tagline — appears just before exit */}
        <div style={{
          fontFamily: 'var(--font-jetbrains)',
          fontSize: '0.6rem',
          letterSpacing: '0.3em',
          color: '#00f5c4',
          textTransform: 'uppercase',
          opacity: isExit ? 0.7 : 0,
          transform: isExit ? 'translateY(0)' : 'translateY(8px)',
          transition: isExit
            ? 'opacity 0.4s ease 0.15s, transform 0.4s ease 0.15s'
            : 'none',
        }}>
          Engineering Digital Futures
        </div>
      </div>

      {/* Scanline sweep — subtle horizontal highlight sweeping down */}
      <div style={{
        position: 'absolute',
        inset: 0,
        background: 'linear-gradient(180deg, transparent 0%, rgba(0,245,196,0.03) 50%, transparent 100%)',
        backgroundSize: '100% 200px',
        animation: isHold ? 'scanline 1.2s linear infinite' : 'none',
        pointerEvents: 'none',
      }} />

      <style>{`
        @keyframes scanline {
          0%   { background-position: 0 -200px; }
          100% { background-position: 0 100vh;  }
        }
      `}</style>

      {/* Corner accents — decorative */}
      {[
        { top: '30%',    left: '30%',    borderTop: '1px solid rgba(0,245,196,0.3)',    borderLeft: '1px solid rgba(0,245,196,0.3)'    },
        { top: '30%',    right: '30%',   borderTop: '1px solid rgba(0,245,196,0.3)',    borderRight: '1px solid rgba(0,245,196,0.3)'   },
        { bottom: '30%', left: '30%',    borderBottom: '1px solid rgba(0,245,196,0.3)', borderLeft: '1px solid rgba(0,245,196,0.3)'    },
        { bottom: '30%', right: '30%',   borderBottom: '1px solid rgba(0,245,196,0.3)', borderRight: '1px solid rgba(0,245,196,0.3)'   },
      ].map((s, i) => (
        <div key={i} style={{
          position: 'absolute',
          width: '20px', height: '20px',
          opacity: isHold || isExit ? 0.8 : 0,
          transition: 'opacity 0.4s',
          ...s,
        }} />
      ))}
    </div>
  )
}
ENDOFFILE
echo "✅ PageIntro.tsx — cinematic 3s reveal created"

# ── 2. Navbar.tsx — full logo only, no mark ───────────────────
cat > src/components/layout/Navbar.tsx << 'ENDOFFILE'
'use client'

import { useEffect, useState } from 'react'
import Link from 'next/link'
import Image from 'next/image'
import { useLang } from '@/lib/LanguageContext'

const navLinks = [
  { labelEn: 'About',    labelFr: 'À propos',  href: '#about'    },
  { labelEn: 'Products', labelFr: 'Produits',  href: '#products' },
  { labelEn: 'Services', labelFr: 'Services',  href: '#services' },
  { labelEn: 'Process',  labelFr: 'Processus', href: '#process'  },
  { labelEn: 'Contact',  labelFr: 'Contact',   href: '#contact'  },
]

function NavLink(props: { href: string; label: string }) {
  const [hovered, setHovered] = useState(false)
  return (
    <a href={props.href}
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
        <button key={l} onClick={() => setLang(l)}
          style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.62rem', letterSpacing: '0.1em', textTransform: 'uppercase', background: lang === l ? 'rgba(0,245,196,0.15)' : 'transparent', color: lang === l ? '#00f5c4' : '#3d6070', border: 'none', padding: '3px 8px', cursor: 'none', transition: 'all 0.2s' }}>
          {l}
        </button>
      ))}
    </div>
  )
}

function CtaButton(props: { label: string; onClick?: () => void }) {
  const [hovered, setHovered] = useState(false)
  return (
    <a href="#contact" onClick={props.onClick}
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

      {/* Full wordmark only */}
      <Link href="/" style={{ display: 'flex', alignItems: 'center', textDecoration: 'none' }}>
        <div style={{
          width: '180px',
          height: '32px',
          position: 'relative',
          filter: 'drop-shadow(0 0 8px rgba(0,245,196,0.2))',
        }}>
          <Image
            src="/logos/logo-full.png"
            alt="ABOULABS"
            fill
            style={{ objectFit: 'contain', objectPosition: 'left center' }}
            priority
          />
        </div>
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
            <a key={link.href} href={link.href} onClick={() => setMenuOpen(false)}
              style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.75rem', letterSpacing: '0.15em', textTransform: 'uppercase', padding: '20px 5%', textDecoration: 'none', color: '#7ba3b8', borderBottom: '1px solid rgba(0,245,196,0.06)' }}>
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
echo "✅ Navbar.tsx — full logo only"

# ── 3. Footer.tsx — full logo only ────────────────────────────
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
    <a href={href} target="_blank" rel="noopener noreferrer" aria-label={label}
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
    <a href={props.href}
      style={{ fontSize: '0.88rem', color: hovered ? '#00f5c4' : '#7ba3b8', textDecoration: 'none', transition: 'color 0.3s' }}
      onMouseEnter={() => setHovered(true)}
      onMouseLeave={() => setHovered(false)}
    >
      {props.label}
    </a>
  )
}

const footerLinks = {
  Products: [
    { label: 'PCS — Premium Car Service',   href: '#product-pcs'    },
    { label: 'Cabi.NET — Legal Management', href: '#product-cabinet' },
    { label: 'EduPath — School LMS',        href: '#product-edupath' },
    { label: 'Maw9if — Mobile App',         href: '#product-maw9if'  },
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

          <div style={{ maxWidth: '280px' }}>
            <Link href="/" style={{ display: 'inline-flex', textDecoration: 'none', marginBottom: '20px' }}>
              <div style={{
                width: '160px',
                height: '20px',
                position: 'relative',
                filter: 'drop-shadow(0 0 6px rgba(0,245,196,0.15))',
              }}>
                <Image src="/logos/logo-full.png" alt="ABOULABS" fill style={{ objectFit: 'contain', objectPosition: 'left center' }} />
              </div>
            </Link>
            <p style={{ fontSize: '0.82rem', color: '#3d6070', lineHeight: 1.65, marginBottom: '20px' }}>
              Engineering digital futures for Moroccan businesses and beyond.
            </p>
            <div style={{ display: 'flex', gap: '8px' }}>
              {/* TODO: update LinkedIn URL */}
              <SocialLink href="https://linkedin.com/company/aboulabs" label="LinkedIn" Icon={LinkedInIcon} />
              {/* TODO: update Instagram URL */}
              <SocialLink href="https://instagram.com/aboulabs" label="Instagram" Icon={InstagramIcon} />
            </div>
          </div>

          {Object.entries(footerLinks).map(([group, links]) => (
            <div key={group}>
              <h4 style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.65rem', letterSpacing: '0.2em', color: '#3d6070', textTransform: 'uppercase', marginBottom: '20px' }}>{group}</h4>
              <ul style={{ listStyle: 'none', padding: 0, margin: 0, display: 'flex', flexDirection: 'column', gap: '12px' }}>
                {links.map((link) => <li key={link.label}><FooterLink href={link.href} label={link.label} /></li>)}
              </ul>
            </div>
          ))}

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
            © 2025 ABOULABS. All rights reserved. — Ifrane, Morocco
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
echo "✅ Footer.tsx — full logo only"

# ── 4. page.tsx — add PageIntro at the very top ───────────────
cat > src/app/page.tsx << 'ENDOFFILE'
import PageIntro       from '@/components/ui/PageIntro'
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
      <PageIntro />
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
echo "✅ page.tsx — PageIntro wired in"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 Done!"
echo ""
echo "Intro animation timeline:"
echo "  0.0s  → mark scales + fades in"
echo "  0.6s  → glow pulses, grid appears, corner accents"
echo "  1.6s  → lines expand, wordmark slides up"
echo "  2.6s  → full overlay slides up off screen"
echo "  3.2s  → component unmounts"
echo ""
echo "Run: npm run dev"
