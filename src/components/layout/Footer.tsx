'use client'

import { useState } from 'react'
import Link from 'next/link'
import Image from 'next/image'

const footerLinks = {
  Products: [
    { label: 'PCS — Premium Car Service',  href: '#products' },
    { label: 'Cabi.NET — Legal Management', href: '#products' },
    { label: 'EduPath — School LMS',        href: '#products' },
    { label: 'Maw9if — Mobile App',         href: '#products' },
  ],
  Company: [
    { label: 'About',    href: '#about'    },
    { label: 'Services', href: '#services' },
    { label: 'Process',  href: '#process'  },
    { label: 'Contact',  href: '#contact'  },
  ],
  Connect: [
    { label: 'LinkedIn',  href: '#' },
    { label: 'GitHub',    href: '#' },
    { label: 'Instagram', href: '#' },
    { label: 'Email Us',  href: 'mailto:contact@aboulabs.com' },
  ],
}

function FooterLink(props: { href: string; label: string }) {
  const [hovered, setHovered] = useState(false)
  return (
    <a
      href={props.href}
      style={{ fontSize: '0.88rem', color: hovered ? '#00f5c4' : '#7ba3b8', textDecoration: 'none', transition: 'color 0.3s' }}
      onMouseEnter={() => setHovered(true)}
      onMouseLeave={() => setHovered(false)}
    >
      {props.label}
    </a>
  )
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
            <p style={{ fontSize: '0.85rem', color: '#3d6070', maxWidth: '260px', lineHeight: 1.6, marginTop: '16px' }}>
              Engineering digital futures for Moroccan businesses and beyond.
            </p>
          </div>

          {/* Link groups */}
          {Object.entries(footerLinks).map(([group, links]) => (
            <div key={group}>
              <h4 style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.65rem', letterSpacing: '0.2em', color: '#3d6070', textTransform: 'uppercase', marginBottom: '20px' }}>
                {group}
              </h4>
              <ul style={{ listStyle: 'none', padding: 0, margin: 0, display: 'flex', flexDirection: 'column', gap: '12px' }}>
                {links.map((link) => (
                  <li key={link.label}>
                    <FooterLink href={link.href} label={link.label} />
                  </li>
                ))}
              </ul>
            </div>
          ))}
        </div>

        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', paddingTop: '32px', flexWrap: 'wrap', gap: '16px' }}>
          <div style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.65rem', letterSpacing: '0.1em', color: '#3d6070' }}>
            © 2025 <span style={{ color: '#00f5c4' }}>ABOULABS</span>. All rights reserved. — Morocco
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
