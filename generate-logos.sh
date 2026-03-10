#!/bin/bash

# ── products.ts — add logo + screenshot fields ─────────────────
cat > src/data/products.ts << 'ENDOFFILE'
export type ProductType = 'web' | 'mobile'

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
  },
]
ENDOFFILE
echo "✅ products.ts updated with logos!"

# ── Products.tsx — use real logos ──────────────────────────────
cat > src/components/sections/Products.tsx << 'ENDOFFILE'
'use client'

import { useState } from 'react'
import Image from 'next/image'
import RevealWrapper from '@/components/ui/RevealWrapper'
import { products } from '@/data/products'

function PhoneMockup() {
  return (
    <div style={{ display: 'flex', justifyContent: 'center', gap: '16px', alignItems: 'flex-end' }}>
      {[
        { rotate: '-4deg', scale: '0.92', opacity: '0.75' },
        { rotate: '0deg',  scale: '1',    opacity: '1'    },
        { rotate: '4deg',  scale: '0.92', opacity: '0.75' },
      ].map((s, i) => (
        <div
          key={i}
          style={{
            width: '110px',
            aspectRatio: '9/19',
            border: '2px solid rgba(0,245,196,0.35)',
            borderRadius: '16px',
            background: '#071826',
            overflow: 'hidden',
            transform: `rotate(${s.rotate}) scale(${s.scale})`,
            opacity: s.opacity,
            boxShadow: i === 1 ? '0 0 30px rgba(0,245,196,0.15)' : 'none',
            display: 'flex',
            flexDirection: 'column',
          }}
        >
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
        style={{
          background: '#0a1e2e',
          padding: '48px 40px',
          position: 'relative',
          overflow: 'hidden',
          transition: 'all 0.4s cubic-bezier(0.23,1,0.32,1)',
          transform: hovered ? 'translateY(-4px)' : 'translateY(0)',
          boxShadow: hovered ? '0 20px 60px rgba(0,0,0,0.5)' : 'none',
          display: isMobile ? 'grid' : 'flex',
          gridTemplateColumns: isMobile ? 'repeat(auto-fit, minmax(280px,1fr))' : undefined,
          flexDirection: isMobile ? undefined : 'column',
          gap: isMobile ? '48px' : '0',
          alignItems: isMobile ? 'center' : undefined,
          height: '100%',
        }}
        onMouseEnter={() => setHovered(true)}
        onMouseLeave={() => setHovered(false)}
      >
        {/* Top bar */}
        <div style={{ position: 'absolute', top: 0, left: 0, right: 0, height: '2px', background: 'linear-gradient(90deg,#00f5c4,#39ff9a)', transform: hovered ? 'scaleX(1)' : 'scaleX(0)', transformOrigin: 'left', transition: 'transform 0.4s cubic-bezier(0.23,1,0.32,1)' }} />

        {/* Hover glow */}
        <div style={{ position: 'absolute', inset: 0, background: 'linear-gradient(135deg,rgba(0,245,196,0.05) 0%,transparent 60%)', opacity: hovered ? 1 : 0, transition: 'opacity 0.4s', pointerEvents: 'none' }} />

        {/* Content */}
        <div style={{ position: 'relative', display: 'flex', flexDirection: 'column', flex: 1 }}>
          <div style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.65rem', letterSpacing: '0.2em', color: '#00f5c4', marginBottom: '28px', opacity: 0.7 }}>
            PRODUCT / {product.num}{product.type === 'mobile' ? ' — MOBILE APP' : ''}
          </div>

          {/* Logo icon area */}
          <div
            style={{
              width: '64px', height: '64px',
              border: '1px solid rgba(0,245,196,0.35)',
              display: 'flex', alignItems: 'center', justifyContent: 'center',
              marginBottom: '24px',
              background: hovered ? 'rgba(0,245,196,0.08)' : 'rgba(0,245,196,0.03)',
              clipPath: 'polygon(6px 0%, 100% 0%, calc(100% - 6px) 100%, 0% 100%)',
              transition: 'background 0.3s',
              padding: '10px',
            }}
          >
            {product.logo ? (
              <Image
                src={product.logo}
                alt={product.name}
                width={44}
                height={44}
                style={{ objectFit: 'contain', width: '100%', height: '100%' }}
              />
            ) : (
              <span style={{ fontSize: '1.5rem' }}>{product.icon}</span>
            )}
          </div>

          <div style={{ fontFamily: 'var(--font-syne)', fontWeight: 800, fontSize: '1.6rem', color: '#e8f4f8', marginBottom: '4px', lineHeight: 1 }}>
            {product.name}
          </div>
          <div style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.7rem', letterSpacing: '0.1em', color: '#00c4a7', marginBottom: '16px', textTransform: 'uppercase' }}>
            {product.tagline}
          </div>
          <p style={{ fontSize: '0.9rem', color: '#7ba3b8', lineHeight: 1.65, marginBottom: '24px', flex: 1 }}>
            {product.description}
          </p>

          <div style={{ display: 'flex', flexWrap: 'wrap', gap: '8px', marginBottom: '24px' }}>
            {product.features.map((f) => (
              <span
                key={f}
                style={{
                  fontFamily: 'var(--font-jetbrains)',
                  fontSize: '0.62rem',
                  letterSpacing: '0.08em',
                  color: hovered ? '#7ba3b8' : '#3d6070',
                  border: `1px solid ${hovered ? 'rgba(0,245,196,0.25)' : 'rgba(0,245,196,0.12)'}`,
                  padding: '4px 10px',
                  background: 'rgba(0,245,196,0.02)',
                  transition: 'all 0.3s',
                }}
              >
                {f}
              </span>
            ))}
          </div>

          <a href="#contact" style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.72rem', letterSpacing: '0.12em', color: '#00f5c4', textDecoration: 'none', display: 'flex', alignItems: 'center', gap: '8px' }}>
            Learn more →
          </a>
        </div>

        {/* Phone mockup for Maw9if */}
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

      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(340px, 1fr))', gap: '2px', background: 'rgba(0,245,196,0.12)' }}>
        {products.map((product, i) => (
          <ProductCard key={product.id} product={product} index={i} />
        ))}
      </div>
    </section>
  )
}
ENDOFFILE
echo "✅ Products.tsx updated with real logos!"

# ── Navbar.tsx — replace SVG with real logo-mark ──────────────
cat > src/components/layout/Navbar.tsx << 'ENDOFFILE'
'use client'

import { useEffect, useState } from 'react'
import Link from 'next/link'
import Image from 'next/image'

const navLinks = [
  { label: 'About', href: '#about' },
  { label: 'Products', href: '#products' },
  { label: 'Services', href: '#services' },
  { label: 'Process', href: '#process' },
  { label: 'Contact', href: '#contact' },
]

function NavLink(props: { href: string; label: string }) {
  const [hovered, setHovered] = useState(false)
  return (
    <a
      href={props.href}
      style={{
        color: hovered ? '#00f5c4' : '#7ba3b8',
        transition: 'color 0.3s',
        fontFamily: 'var(--font-jetbrains)',
        fontSize: '0.72rem',
        letterSpacing: '0.12em',
        textTransform: 'uppercase',
        textDecoration: 'none',
        position: 'relative',
        display: 'block',
      }}
      onMouseEnter={() => setHovered(true)}
      onMouseLeave={() => setHovered(false)}
    >
      {props.label}
      <span
        style={{
          position: 'absolute',
          bottom: '-4px',
          left: 0,
          right: 0,
          height: '1px',
          background: '#00f5c4',
          transform: hovered ? 'scaleX(1)' : 'scaleX(0)',
          transformOrigin: 'left',
          transition: 'transform 0.3s',
        }}
      />
    </a>
  )
}

function CtaButton(props: { onClick?: () => void }) {
  const [hovered, setHovered] = useState(false)
  return (
    <a
      href="#contact"
      onClick={props.onClick}
      style={{
        background: 'linear-gradient(135deg, #00f5c4, #39ff9a)',
        color: '#020d14',
        fontFamily: 'var(--font-jetbrains)',
        fontSize: '0.72rem',
        letterSpacing: '0.1em',
        fontWeight: '500',
        padding: '10px 24px',
        textDecoration: 'none',
        display: 'inline-block',
        clipPath: 'polygon(10px 0%, 100% 0%, calc(100% - 10px) 100%, 0% 100%)',
        boxShadow: hovered ? '0 0 24px rgba(0,245,196,0.45)' : 'none',
        transition: 'box-shadow 0.3s',
      }}
      onMouseEnter={() => setHovered(true)}
      onMouseLeave={() => setHovered(false)}
    >
      Get in Touch
    </a>
  )
}

export default function Navbar() {
  const [scrolled, setScrolled] = useState(false)
  const [menuOpen, setMenuOpen] = useState(false)

  useEffect(() => {
    const onScroll = () => setScrolled(window.scrollY > 50)
    window.addEventListener('scroll', onScroll)
    return () => window.removeEventListener('scroll', onScroll)
  }, [])

  return (
    <nav
      style={{
        position: 'fixed',
        top: 0, left: 0, right: 0,
        zIndex: 100,
        padding: '0 5%',
        height: '70px',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'space-between',
        background: scrolled ? 'rgba(2,13,20,0.95)' : 'rgba(2,13,20,0.8)',
        backdropFilter: 'blur(20px)',
        borderBottom: '1px solid rgba(0,245,196,0.12)',
        transition: 'background 0.3s',
      }}
    >
      <Link href="/" style={{ display: 'flex', alignItems: 'center', gap: '12px', textDecoration: 'none' }}>
        <div style={{ width: '36px', height: '36px', filter: 'drop-shadow(0 0 8px rgba(0,245,196,0.5))' }}>
          <Image
            src="/logos/logo-mark.png"
            alt="ABOULABS"
            width={36}
            height={36}
            style={{ objectFit: 'contain', width: '100%', height: '100%' }}
          />
        </div>
        <span
          style={{
            fontFamily: 'var(--font-syne)',
            fontWeight: '800',
            fontSize: '1.1rem',
            letterSpacing: '0.08em',
            background: 'linear-gradient(135deg, #00f5c4, #39ff9a)',
            WebkitBackgroundClip: 'text',
            WebkitTextFillColor: 'transparent',
            backgroundClip: 'text',
          }}
        >
          ABOULABS
        </span>
      </Link>

      <ul
        className="hidden md:flex"
        style={{ alignItems: 'center', gap: '36px', listStyle: 'none', margin: 0, padding: 0 }}
      >
        {navLinks.map((link) => (
          <li key={link.href}>
            <NavLink href={link.href} label={link.label} />
          </li>
        ))}
      </ul>

      <div className="hidden md:block">
        <CtaButton />
      </div>

      <button
        className="md:hidden"
        style={{ background: 'none', border: 'none', cursor: 'none', display: 'flex', flexDirection: 'column', gap: '5px', padding: '8px' }}
        onClick={() => setMenuOpen(!menuOpen)}
      >
        <span style={{ display: 'block', height: '1px', width: '24px', background: '#00f5c4', transform: menuOpen ? 'rotate(45deg) translate(4px,4px)' : 'none', transition: 'transform 0.3s' }} />
        <span style={{ display: 'block', height: '1px', width: '24px', background: '#00f5c4', opacity: menuOpen ? 0 : 1, transition: 'opacity 0.3s' }} />
        <span style={{ display: 'block', height: '1px', width: '24px', background: '#00f5c4', transform: menuOpen ? 'rotate(-45deg) translate(4px,-4px)' : 'none', transition: 'transform 0.3s' }} />
      </button>

      {menuOpen && (
        <div
          className="md:hidden"
          style={{ position: 'absolute', top: '70px', left: 0, right: 0, background: 'rgba(2,13,20,0.98)', borderBottom: '1px solid rgba(0,245,196,0.12)', display: 'flex', flexDirection: 'column' }}
        >
          {navLinks.map((link) => (
            <a
              key={link.href}
              href={link.href}
              onClick={() => setMenuOpen(false)}
              style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.75rem', letterSpacing: '0.15em', textTransform: 'uppercase', padding: '20px 5%', textDecoration: 'none', color: '#7ba3b8', borderBottom: '1px solid rgba(0,245,196,0.06)' }}
            >
              {link.label}
            </a>
          ))}
          <div style={{ padding: '20px 5%' }}>
            <CtaButton onClick={() => setMenuOpen(false)} />
          </div>
        </div>
      )}
    </nav>
  )
}
ENDOFFILE
echo "✅ Navbar.tsx updated with real logo!"

# ── About.tsx — replace center SVG with real logo ─────────────
cat > src/components/sections/About.tsx << 'ENDOFFILE'
'use client'

import Image from 'next/image'
import RevealWrapper from '@/components/ui/RevealWrapper'

const pillars = [
  { icon: '⚡', title: 'SaaS Products',   desc: 'Purpose-built platforms for industry verticals' },
  { icon: '🧠', title: 'Consulting',      desc: 'Strategic digital transformation guidance' },
  { icon: '🚀', title: 'Scale',           desc: 'Architectures designed to grow with you' },
  { icon: '🇲🇦', title: 'Morocco-First', desc: 'Local insight, global engineering standards' },
]

export default function About() {
  return (
    <section
      id="about"
      style={{
        padding: '120px 5%',
        maxWidth: '1200px',
        margin: '0 auto',
        display: 'grid',
        gridTemplateColumns: 'repeat(auto-fit, minmax(320px, 1fr))',
        gap: '80px',
        alignItems: 'center',
      }}
    >
      {/* Left */}
      <RevealWrapper>
        <div style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.65rem', letterSpacing: '0.25em', color: '#00f5c4', textTransform: 'uppercase', marginBottom: '16px', display: 'flex', alignItems: 'center', gap: '12px' }}>
          <span style={{ width: '30px', height: '1px', background: '#00f5c4', display: 'inline-block' }} />
          Who We Are
        </div>
        <h2 style={{ fontFamily: 'var(--font-syne)', fontWeight: 800, fontSize: 'clamp(2rem,4vw,3.2rem)', lineHeight: 1.15, color: '#e8f4f8', marginBottom: '16px' }}>
          Built for Morocco.{' '}
          <span style={{ background: 'linear-gradient(135deg,#00f5c4,#39ff9a)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent', backgroundClip: 'text' }}>
            Engineered for the World.
          </span>
        </h2>
        <p style={{ fontSize: '1rem', color: '#7ba3b8', lineHeight: 1.7, maxWidth: '480px', marginBottom: '40px' }}>
          ABOULABS is an e-consulting and SaaS technology company on a mission to digitally
          transform Moroccan businesses. We build scalable, elegant software products — and
          the digital expertise to deploy them.
        </p>
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '16px' }}>
          {pillars.map((p) => (
            <div
              key={p.title}
              style={{ padding: '20px', border: '1px solid rgba(0,245,196,0.12)', background: 'rgba(0,245,196,0.02)', transition: 'all 0.3s', cursor: 'default' }}
              onMouseEnter={e => { const el = e.currentTarget as HTMLDivElement; el.style.borderColor = 'rgba(0,245,196,0.35)'; el.style.background = 'rgba(0,245,196,0.04)'; el.style.transform = 'translateY(-2px)' }}
              onMouseLeave={e => { const el = e.currentTarget as HTMLDivElement; el.style.borderColor = 'rgba(0,245,196,0.12)'; el.style.background = 'rgba(0,245,196,0.02)'; el.style.transform = 'translateY(0)' }}
            >
              <div style={{ fontSize: '1.2rem', marginBottom: '10px' }}>{p.icon}</div>
              <div style={{ fontFamily: 'var(--font-syne)', fontWeight: 700, fontSize: '0.85rem', color: '#e8f4f8', marginBottom: '6px' }}>{p.title}</div>
              <div style={{ fontSize: '0.78rem', color: '#3d6070', lineHeight: 1.5 }}>{p.desc}</div>
            </div>
          ))}
        </div>
      </RevealWrapper>

      {/* Right — orbital visual */}
      <RevealWrapper delay={0.15}>
        <div style={{ position: 'relative', width: '100%', maxWidth: '420px', aspectRatio: '1', margin: '0 auto' }}>
          {[
            { size: '80%', offset: '10%', color: 'rgba(0,245,196,0.08)', duration: '20s', dir: 'normal' },
            { size: '60%', offset: '20%', color: 'rgba(0,245,196,0.15)', duration: '15s', dir: 'reverse' },
            { size: '40%', offset: '30%', color: 'rgba(0,245,196,0.2)',  duration: '10s', dir: 'normal' },
          ].map((ring, i) => (
            <div key={i} style={{ position: 'absolute', width: ring.size, height: ring.size, top: ring.offset, left: ring.offset, borderRadius: '50%', border: `1px solid ${ring.color}`, animation: `spin ${ring.duration} linear infinite ${ring.dir}` }} />
          ))}

          {/* Real logo in center */}
          <div style={{ position: 'absolute', top: '50%', left: '50%', transform: 'translate(-50%,-50%)', width: '90px', height: '90px', filter: 'drop-shadow(0 0 20px rgba(0,245,196,0.4))' }}>
            <Image
              src="/logos/logo-mark.png"
              alt="ABOULABS"
              width={90}
              height={90}
              style={{ objectFit: 'contain', width: '100%', height: '100%' }}
            />
          </div>

          {/* Floating dots */}
          <div style={{ position: 'absolute', width: '8px', height: '8px', background: '#00f5c4', borderRadius: '50%', boxShadow: '0 0 10px #00f5c4', top: '5%', left: '50%', animation: 'float 3s ease-in-out infinite' }} />
          <div style={{ position: 'absolute', width: '6px', height: '6px', background: '#39ff9a', borderRadius: '50%', boxShadow: '0 0 8px #39ff9a', bottom: '15%', right: '10%', animation: 'float 4s ease-in-out infinite 1s' }} />
          <div style={{ position: 'absolute', width: '5px', height: '5px', background: '#00e5ff', borderRadius: '50%', boxShadow: '0 0 8px #00e5ff', top: '30%', left: '5%', animation: 'float 3.5s ease-in-out infinite 0.5s' }} />
        </div>
      </RevealWrapper>
    </section>
  )
}
ENDOFFILE
echo "✅ About.tsx updated with real logo!"

# ── Footer.tsx — replace SVG with real logo ───────────────────
cat > src/components/layout/Footer.tsx << 'ENDOFFILE'
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
ENDOFFILE
echo "✅ Footer.tsx updated with real logo!"
echo ""
echo "🎉 All logos wired in! Check localhost:3000"
