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
