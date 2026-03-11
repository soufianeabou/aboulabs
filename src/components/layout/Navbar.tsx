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
