#!/bin/bash

# ── Services Section ───────────────────────────────────────────
cat > src/components/sections/Services.tsx << 'ENDOFFILE'
'use client'

import { useState } from 'react'
import RevealWrapper from '@/components/ui/RevealWrapper'

const services = [
  { icon: '🔧', name: 'Custom SaaS Development',  desc: 'We build bespoke web platforms tailored to your industry workflows and specific requirements.' },
  { icon: '📊', name: 'Digital Transformation',    desc: 'Strategic consulting to help Moroccan businesses migrate from legacy processes to modern digital operations.' },
  { icon: '📱', name: 'Mobile App Engineering',    desc: 'Cross-platform mobile applications built with modern frameworks, designed for Moroccan users and markets.' },
  { icon: '🔗', name: 'System Integration',        desc: 'Connecting your existing tools and platforms into a seamless, unified ecosystem.' },
  { icon: '🛡️', name: 'Technical Architecture',   desc: 'Designing scalable, secure cloud architectures built for performance and long-term growth.' },
  { icon: '🎯', name: 'Product Strategy',          desc: 'From idea to launch — product discovery, market fit analysis, and technical roadmapping.' },
]

function ServiceCard({ service, delay }: { service: typeof services[0]; delay: number }) {
  const [hovered, setHovered] = useState(false)
  return (
    <RevealWrapper delay={delay}>
      <div
        style={{
          background: hovered ? '#0a1e2e' : '#020d14',
          padding: '32px 28px',
          transition: 'background 0.3s',
          display: 'flex',
          flexDirection: 'column',
          gap: '12px',
          height: '100%',
          cursor: 'default',
        }}
        onMouseEnter={() => setHovered(true)}
        onMouseLeave={() => setHovered(false)}
      >
        <div
          style={{
            width: '48px', height: '48px',
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            border: '1px solid rgba(0,245,196,0.12)',
            background: 'rgba(0,245,196,0.03)',
            fontSize: '1.4rem',
          }}
        >
          {service.icon}
        </div>
        <div style={{ fontFamily: 'var(--font-syne)', fontWeight: 700, fontSize: '1rem', color: '#e8f4f8' }}>
          {service.name}
        </div>
        <div style={{ fontSize: '0.83rem', color: '#3d6070', lineHeight: 1.6 }}>
          {service.desc}
        </div>
      </div>
    </RevealWrapper>
  )
}

export default function Services() {
  return (
    <section id="services" style={{ padding: '120px 5%', maxWidth: '1200px', margin: '0 auto' }}>
      <RevealWrapper>
        <div style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.65rem', letterSpacing: '0.25em', color: '#00f5c4', textTransform: 'uppercase', marginBottom: '16px', display: 'flex', alignItems: 'center', gap: '12px' }}>
          <span style={{ width: '30px', height: '1px', background: '#00f5c4', display: 'inline-block' }} />
          What We Do
        </div>
        <h2 style={{ fontFamily: 'var(--font-syne)', fontWeight: 800, fontSize: 'clamp(2rem,4vw,3.2rem)', lineHeight: 1.15, color: '#e8f4f8', marginBottom: '64px' }}>
          Digital{' '}
          <span style={{ background: 'linear-gradient(135deg,#00f5c4,#39ff9a)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent', backgroundClip: 'text' }}>
            Consulting
          </span>
          {' '}& Engineering
        </h2>
      </RevealWrapper>

      <div
        style={{
          display: 'grid',
          gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))',
          gap: '2px',
          background: 'rgba(0,245,196,0.12)',
        }}
      >
        {services.map((s, i) => (
          <ServiceCard key={s.name} service={s} delay={i * 0.08} />
        ))}
      </div>
    </section>
  )
}
ENDOFFILE
echo "✅ Services.tsx created!"

# ── Process Section ────────────────────────────────────────────
cat > src/components/sections/Process.tsx << 'ENDOFFILE'
'use client'

import { useState } from 'react'
import RevealWrapper from '@/components/ui/RevealWrapper'

const steps = [
  { num: '01', title: 'Discovery',    desc: 'We deep-dive into your business context, challenges, and goals to define the right solution scope.' },
  { num: '02', title: 'Architecture', desc: 'Technical design, data modeling, and system architecture planned before a single line of code is written.' },
  { num: '03', title: 'Engineering',  desc: 'Iterative development with continuous client feedback loops — transparent progress, zero surprises.' },
  { num: '04', title: 'Deployment',   desc: 'Staged launch with full QA, team training, documentation, and post-launch monitoring included.' },
]

function StepCard({ step, delay }: { step: typeof steps[0]; delay: number }) {
  const [hovered, setHovered] = useState(false)
  return (
    <RevealWrapper delay={delay}>
      <div
        style={{
          background: hovered ? '#0a1e2e' : '#020d14',
          padding: '40px 28px',
          position: 'relative',
          overflow: 'hidden',
          transition: 'background 0.3s',
          height: '100%',
          cursor: 'default',
        }}
        onMouseEnter={() => setHovered(true)}
        onMouseLeave={() => setHovered(false)}
      >
        <div
          style={{
            fontFamily: 'var(--font-syne)',
            fontWeight: 800,
            fontSize: '3.5rem',
            color: hovered ? 'rgba(0,245,196,0.15)' : 'rgba(0,245,196,0.07)',
            lineHeight: 1,
            marginBottom: '20px',
            transition: 'color 0.3s',
          }}
        >
          {step.num}
        </div>
        <div style={{ fontFamily: 'var(--font-syne)', fontWeight: 700, fontSize: '1rem', color: '#e8f4f8', marginBottom: '10px' }}>
          {step.title}
        </div>
        <div style={{ fontSize: '0.83rem', color: '#3d6070', lineHeight: 1.6 }}>
          {step.desc}
        </div>
        {/* Bottom accent bar */}
        <div
          style={{
            position: 'absolute',
            bottom: 0, left: 0,
            height: '2px',
            width: hovered ? '100%' : '0%',
            background: 'linear-gradient(90deg, #00f5c4, #39ff9a)',
            transition: 'width 0.4s cubic-bezier(0.23,1,0.32,1)',
          }}
        />
      </div>
    </RevealWrapper>
  )
}

export default function Process() {
  return (
    <section
      id="process"
      style={{
        padding: '120px 5%',
        borderTop: '1px solid rgba(0,245,196,0.12)',
        borderBottom: '1px solid rgba(0,245,196,0.12)',
        background: 'linear-gradient(180deg, transparent, rgba(0,245,196,0.02) 50%, transparent)',
      }}
    >
      <div style={{ maxWidth: '1200px', margin: '0 auto' }}>
        <RevealWrapper>
          <div style={{ textAlign: 'center', marginBottom: '80px' }}>
            <div style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.65rem', letterSpacing: '0.25em', color: '#00f5c4', textTransform: 'uppercase', marginBottom: '16px', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '12px' }}>
              <span style={{ width: '30px', height: '1px', background: '#00f5c4', display: 'inline-block' }} />
              How We Work
              <span style={{ width: '30px', height: '1px', background: '#00f5c4', display: 'inline-block' }} />
            </div>
            <h2 style={{ fontFamily: 'var(--font-syne)', fontWeight: 800, fontSize: 'clamp(2rem,4vw,3.2rem)', lineHeight: 1.15, color: '#e8f4f8', marginBottom: '16px' }}>
              Our{' '}
              <span style={{ background: 'linear-gradient(135deg,#00f5c4,#39ff9a)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent', backgroundClip: 'text' }}>
                Process
              </span>
            </h2>
            <p style={{ fontSize: '0.95rem', color: '#7ba3b8', maxWidth: '440px', margin: '0 auto', lineHeight: 1.7 }}>
              From first conversation to production deployment — a structured, transparent workflow.
            </p>
          </div>
        </RevealWrapper>

        <div
          style={{
            display: 'grid',
            gridTemplateColumns: 'repeat(auto-fit, minmax(220px, 1fr))',
            gap: '2px',
            background: 'rgba(0,245,196,0.12)',
          }}
        >
          {steps.map((step, i) => (
            <StepCard key={step.num} step={step} delay={i * 0.1} />
          ))}
        </div>
      </div>
    </section>
  )
}
ENDOFFILE
echo "✅ Process.tsx created!"

# ── CTA Section ────────────────────────────────────────────────
cat > src/components/sections/CTA.tsx << 'ENDOFFILE'
'use client'

import { useState } from 'react'
import RevealWrapper from '@/components/ui/RevealWrapper'

function CtaBtn({ href, primary, children }: { href: string; primary?: boolean; children: React.ReactNode }) {
  const [hovered, setHovered] = useState(false)
  return (
    <a
      href={href}
      style={{
        fontFamily: 'var(--font-jetbrains)',
        fontSize: '0.8rem',
        letterSpacing: '0.1em',
        textDecoration: 'none',
        padding: '14px 32px',
        display: 'inline-block',
        transition: 'all 0.3s',
        ...(primary ? {
          background: 'linear-gradient(135deg, #00f5c4, #39ff9a)',
          color: '#020d14',
          clipPath: 'polygon(10px 0%, 100% 0%, calc(100% - 10px) 100%, 0% 100%)',
          fontWeight: 600,
          boxShadow: hovered ? '0 0 30px rgba(0,245,196,0.4)' : 'none',
        } : {
          color: '#00f5c4',
          border: '1px solid rgba(0,245,196,0.35)',
          background: hovered ? 'rgba(0,245,196,0.06)' : 'transparent',
        }),
      }}
      onMouseEnter={() => setHovered(true)}
      onMouseLeave={() => setHovered(false)}
    >
      {children}
    </a>
  )
}

export default function CTA() {
  return (
    <section
      id="contact"
      style={{ padding: '140px 5%', textAlign: 'center', position: 'relative', overflow: 'hidden' }}
    >
      {/* Radial glow */}
      <div
        style={{
          position: 'absolute',
          width: '800px', height: '800px',
          borderRadius: '50%',
          background: 'radial-gradient(circle, rgba(0,245,196,0.06) 0%, transparent 70%)',
          top: '50%', left: '50%',
          transform: 'translate(-50%,-50%)',
          pointerEvents: 'none',
        }}
      />

      <RevealWrapper>
        <div style={{ maxWidth: '700px', margin: '0 auto', position: 'relative' }}>
          <div style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.7rem', letterSpacing: '0.2em', color: '#00f5c4', textTransform: 'uppercase', marginBottom: '24px' }}>
            {'// Ready to build?'}
          </div>
          <h2 style={{ fontFamily: 'var(--font-syne)', fontWeight: 800, fontSize: 'clamp(2.2rem,4vw,3.8rem)', lineHeight: 1.1, color: '#e8f4f8', marginBottom: '24px' }}>
            Your Digital{' '}
            <span style={{ background: 'linear-gradient(135deg,#00f5c4,#39ff9a)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent', backgroundClip: 'text' }}>
              Transformation
            </span>
            {' '}Starts Here.
          </h2>
          <p style={{ fontSize: '1rem', color: '#7ba3b8', lineHeight: 1.7, marginBottom: '48px' }}>
            Whether you are exploring a new product idea, need to digitalize your operations,
            or want to integrate our SaaS solutions — let&apos;s talk.
          </p>
          <div style={{ display: 'flex', gap: '16px', justifyContent: 'center', flexWrap: 'wrap' }}>
            <CtaBtn href="mailto:contact@aboulabs.com" primary>
              contact@aboulabs.com
            </CtaBtn>
            <CtaBtn href="#products">
              Explore Products
            </CtaBtn>
          </div>
        </div>
      </RevealWrapper>
    </section>
  )
}
ENDOFFILE
echo "✅ CTA.tsx created!"

# ── Footer ─────────────────────────────────────────────────────
cat > src/components/layout/Footer.tsx << 'ENDOFFILE'
'use client'

import { useState } from 'react'
import Link from 'next/link'

const footerLinks = {
  Products: [
    { label: 'PCS — Premium Car Service', href: '#products' },
    { label: 'Cabi.NET — Legal Management', href: '#products' },
    { label: 'EduPath — School LMS', href: '#products' },
    { label: 'Maw9if — Mobile App', href: '#products' },
  ],
  Company: [
    { label: 'About', href: '#about' },
    { label: 'Services', href: '#services' },
    { label: 'Process', href: '#process' },
    { label: 'Contact', href: '#contact' },
  ],
  Connect: [
    { label: 'LinkedIn', href: '#' },
    { label: 'GitHub', href: '#' },
    { label: 'Instagram', href: '#' },
    { label: 'Email Us', href: 'mailto:contact@aboulabs.com' },
  ],
}

function FooterLink({ href, label }: { href: string; label: string }) {
  const [hovered, setHovered] = useState(false)
  return (
    <a
      href={href}
      style={{
        fontSize: '0.88rem',
        color: hovered ? '#00f5c4' : '#7ba3b8',
        textDecoration: 'none',
        transition: 'color 0.3s',
      }}
      onMouseEnter={() => setHovered(true)}
      onMouseLeave={() => setHovered(false)}
    >
      {label}
    </a>
  )
}

export default function Footer() {
  return (
    <footer style={{ position: 'relative', zIndex: 2, borderTop: '1px solid rgba(0,245,196,0.12)' }}>
      <div style={{ maxWidth: '1200px', margin: '0 auto', padding: '60px 5% 40px' }}>

        {/* Top */}
        <div
          style={{
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'flex-start',
            paddingBottom: '48px',
            borderBottom: '1px solid rgba(0,245,196,0.12)',
            flexWrap: 'wrap',
            gap: '40px',
          }}
        >
          {/* Brand */}
          <div>
            <Link href="/" style={{ display: 'flex', alignItems: 'center', gap: '12px', textDecoration: 'none' }}>
              <div style={{ width: '28px', height: '28px', filter: 'drop-shadow(0 0 6px rgba(0,245,196,0.5))' }}>
                <svg viewBox="0 0 100 100" fill="none" style={{ width: '100%', height: '100%' }}>
                  <defs>
                    <linearGradient id="ftG1" x1="5" y1="5" x2="95" y2="85" gradientUnits="userSpaceOnUse">
                      <stop offset="0%" stopColor="#00f5c4" />
                      <stop offset="100%" stopColor="#39ff9a" />
                    </linearGradient>
                    <linearGradient id="ftG2" x1="22" y1="48" x2="78" y2="85" gradientUnits="userSpaceOnUse">
                      <stop offset="0%" stopColor="#00c4a7" />
                      <stop offset="100%" stopColor="#00e5ff" />
                    </linearGradient>
                  </defs>
                  <polygon points="50,5 95,85 5,85" fill="none" stroke="url(#ftG1)" strokeWidth="8" />
                  <polyline points="22,85 50,48 78,85" fill="none" stroke="url(#ftG2)" strokeWidth="6" />
                </svg>
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

        {/* Bottom */}
        <div
          style={{
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center',
            paddingTop: '32px',
            flexWrap: 'wrap',
            gap: '16px',
          }}
        >
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
echo "✅ Footer.tsx created!"

# ── Final page.tsx ─────────────────────────────────────────────
cat > src/app/page.tsx << 'ENDOFFILE'
import Cursor   from '@/components/ui/Cursor'
import Navbar   from '@/components/layout/Navbar'
import Footer   from '@/components/layout/Footer'
import Hero     from '@/components/sections/Hero'
import Ticker   from '@/components/sections/Ticker'
import About    from '@/components/sections/About'
import Products from '@/components/sections/Products'
import Services from '@/components/sections/Services'
import Process  from '@/components/sections/Process'
import CTA      from '@/components/sections/CTA'

export default function Home() {
  return (
    <>
      <Cursor />
      <Navbar />
      <main>
        <Hero />
        <Ticker />
        <About />
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
echo "✅ page.tsx finalized!"
echo ""
echo "🎉 ABOULABS landing page is complete!"
echo "   Run: npm run dev"
echo "   Open: http://localhost:3000"
