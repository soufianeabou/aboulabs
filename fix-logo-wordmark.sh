#!/bin/bash

# First copy the new transparent logo-full.png to public/logos/
# (user must run: cp ~/Downloads/logo-full.png public/logos/logo-full.png)

# ── Navbar.tsx — mark + full logo, perfectly aligned ──────────
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
          style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.62rem', letterSpacing: '0.1em', textTransform: 'uppercase', background: lang === l ? 'rgba(0,245,196,0.15)' : 'transparent', color: lang === l ? '#00f5c4' : '#3d6070', border: 'none', padding: '3px 8px', cursor: 'none', transition: 'all 0.2s' }}
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

      {/* ── Logo: mark + full wordmark side by side ── */}
      <Link href="/" style={{ display: 'flex', alignItems: 'center', gap: '10px', textDecoration: 'none' }}>
        {/* Mark — the triangle A */}
        <div style={{ width: '36px', height: '36px', flexShrink: 0, filter: 'drop-shadow(0 0 8px rgba(0,245,196,0.45))' }}>
          <Image
            src="/logos/logo-mark.png"
            alt=""
            width={36}
            height={36}
            style={{ objectFit: 'contain', width: '100%', height: '100%' }}
          />
        </div>
        {/* Divider */}
        <span style={{ width: '1px', height: '22px', background: 'rgba(0,245,196,0.2)', flexShrink: 0 }} />
        {/* Full wordmark — sized to match mark height visually */}
        <div style={{ height: '22px', position: 'relative', width: '140px', filter: 'drop-shadow(0 0 6px rgba(0,245,196,0.2))' }}>
          <Image
            src="/logos/logo-full.png"
            alt="ABOULABS"
            fill
            style={{ objectFit: 'contain', objectPosition: 'left center' }}
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
echo "✅ Navbar.tsx — mark + full logo, divider aligned"

# ── Footer.tsx — full wordmark replaces text ──────────────────
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
    <a href={props.href} style={{ fontSize: '0.88rem', color: hovered ? '#00f5c4' : '#7ba3b8', textDecoration: 'none', transition: 'color 0.3s' }}
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

          {/* Brand block — full wordmark */}
          <div style={{ maxWidth: '280px' }}>
            <Link href="/" style={{ display: 'inline-flex', alignItems: 'center', gap: '10px', textDecoration: 'none', marginBottom: '16px' }}>
              {/* Mark */}
              <div style={{ width: '28px', height: '28px', flexShrink: 0, filter: 'drop-shadow(0 0 6px rgba(0,245,196,0.4))' }}>
                <Image src="/logos/logo-mark.png" alt="" width={28} height={28} style={{ objectFit: 'contain', width: '100%', height: '100%' }} />
              </div>
              {/* Divider */}
              <span style={{ width: '1px', height: '18px', background: 'rgba(0,245,196,0.2)', flexShrink: 0 }} />
              {/* Full wordmark */}
              <div style={{ height: '18px', position: 'relative', width: '110px', filter: 'drop-shadow(0 0 4px rgba(0,245,196,0.15))' }}>
                <Image src="/logos/logo-full.png" alt="ABOULABS" fill style={{ objectFit: 'contain', objectPosition: 'left center' }} />
              </div>
            </Link>

            <p style={{ fontSize: '0.82rem', color: '#3d6070', lineHeight: 1.65, marginBottom: '20px' }}>
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

          {/* Contact */}
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
echo "✅ Footer.tsx — full wordmark with mark + divider"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "⚠️  IMPORTANT: copy the new transparent logo first:"
echo "   cp ~/Downloads/logo-full.png public/logos/logo-full.png"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🎉 Done! Navbar + Footer now use:"
echo "   [▲ mark] | [ABOULABS wordmark]"
echo ""
echo "Run: npm run dev"
