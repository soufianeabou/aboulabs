#!/bin/bash

# ── Services.tsx — replace emoji icons with SVGs ──────────────
cat > src/components/sections/Services.tsx << 'ENDOFFILE'
'use client'

import { useState } from 'react'
import RevealWrapper from '@/components/ui/RevealWrapper'

function IconCode() {
  return (
    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#00f5c4" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
      <polyline points="16 18 22 12 16 6" /><polyline points="8 6 2 12 8 18" />
    </svg>
  )
}
function IconTransform() {
  return (
    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#00f5c4" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
      <path d="M12 2L2 7l10 5 10-5-10-5z"/><path d="M2 17l10 5 10-5"/><path d="M2 12l10 5 10-5"/>
    </svg>
  )
}
function IconMobile() {
  return (
    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#00f5c4" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
      <rect x="5" y="2" width="14" height="20" rx="2" ry="2"/><line x1="12" y1="18" x2="12.01" y2="18"/>
    </svg>
  )
}
function IconLink() {
  return (
    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#00f5c4" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
      <path d="M10 13a5 5 0 0 0 7.54.54l3-3a5 5 0 0 0-7.07-7.07l-1.72 1.71"/>
      <path d="M14 11a5 5 0 0 0-7.54-.54l-3 3a5 5 0 0 0 7.07 7.07l1.71-1.71"/>
    </svg>
  )
}
function IconArchitecture() {
  return (
    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#00f5c4" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
      <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/>
    </svg>
  )
}
function IconStrategy() {
  return (
    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#00f5c4" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
      <circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/>
    </svg>
  )
}

const services = [
  { Icon: IconCode,         name: 'Custom SaaS Development',  desc: 'We build bespoke web platforms tailored to your industry workflows and specific requirements.' },
  { Icon: IconTransform,    name: 'Digital Transformation',    desc: 'Strategic consulting to help Moroccan businesses migrate from legacy processes to modern digital operations.' },
  { Icon: IconMobile,       name: 'Mobile App Engineering',    desc: 'Cross-platform mobile applications built with modern frameworks, designed for Moroccan users and markets.' },
  { Icon: IconLink,         name: 'System Integration',        desc: 'Connecting your existing tools and platforms into a seamless, unified ecosystem.' },
  { Icon: IconArchitecture, name: 'Technical Architecture',    desc: 'Designing scalable, secure cloud architectures built for performance and long-term growth.' },
  { Icon: IconStrategy,     name: 'Product Strategy',          desc: 'From idea to launch — product discovery, market fit analysis, and technical roadmapping.' },
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
          gap: '14px',
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
            border: `1px solid ${hovered ? 'rgba(0,245,196,0.35)' : 'rgba(0,245,196,0.12)'}`,
            background: hovered ? 'rgba(0,245,196,0.08)' : 'rgba(0,245,196,0.03)',
            transition: 'all 0.3s',
            flexShrink: 0,
          }}
        >
          <service.Icon />
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

      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(280px, 1fr))', gap: '2px', background: 'rgba(0,245,196,0.12)' }}>
        {services.map((s, i) => (
          <ServiceCard key={s.name} service={s} delay={i * 0.08} />
        ))}
      </div>
    </section>
  )
}
ENDOFFILE
echo "✅ Services.tsx — SVG icons done!"

# ── About.tsx — replace emoji pillars with SVGs ───────────────
cat > src/components/sections/About.tsx << 'ENDOFFILE'
'use client'

import Image from 'next/image'
import RevealWrapper from '@/components/ui/RevealWrapper'

function IconSaas() {
  return (
    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#00f5c4" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
      <rect x="2" y="3" width="20" height="14" rx="2"/><line x1="8" y1="21" x2="16" y2="21"/><line x1="12" y1="17" x2="12" y2="21"/>
    </svg>
  )
}
function IconConsulting() {
  return (
    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#00f5c4" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
      <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/>
    </svg>
  )
}
function IconScale() {
  return (
    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#00f5c4" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
      <polyline points="23 6 13.5 15.5 8.5 10.5 1 18"/><polyline points="17 6 23 6 23 12"/>
    </svg>
  )
}
function IconMorocco() {
  return (
    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#00f5c4" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
      <circle cx="12" cy="12" r="10"/>
      <line x1="2" y1="12" x2="22" y2="12"/>
      <path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"/>
    </svg>
  )
}

const pillars = [
  { Icon: IconSaas,       title: 'SaaS Products',   desc: 'Purpose-built platforms for industry verticals' },
  { Icon: IconConsulting, title: 'Consulting',       desc: 'Strategic digital transformation guidance' },
  { Icon: IconScale,      title: 'Scale',            desc: 'Architectures designed to grow with you' },
  { Icon: IconMorocco,    title: 'Morocco-First',    desc: 'Local insight, global engineering standards' },
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
              <div style={{ marginBottom: '12px', display: 'flex', alignItems: 'center', justifyContent: 'flex-start' }}>
                <p.Icon />
              </div>
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

          <div style={{ position: 'absolute', top: '50%', left: '50%', transform: 'translate(-50%,-50%)', width: '160px', height: '160px', filter: 'drop-shadow(0 0 20px rgba(0,245,196,0.4))' }}>
            <Image src="/logos/logo-mark.png" alt="ABOULABS" width={160} height={160} style={{ objectFit: 'contain', width: '100%', height: '100%' }} />
          </div>

          <div style={{ position: 'absolute', width: '8px', height: '8px', background: '#00f5c4', borderRadius: '50%', boxShadow: '0 0 10px #00f5c4', top: '5%', left: '50%', animation: 'float 3s ease-in-out infinite' }} />
          <div style={{ position: 'absolute', width: '6px', height: '6px', background: '#39ff9a', borderRadius: '50%', boxShadow: '0 0 8px #39ff9a', bottom: '15%', right: '10%', animation: 'float 4s ease-in-out infinite 1s' }} />
          <div style={{ position: 'absolute', width: '5px', height: '5px', background: '#00e5ff', borderRadius: '50%', boxShadow: '0 0 8px #00e5ff', top: '30%', left: '5%', animation: 'float 3.5s ease-in-out infinite 0.5s' }} />
        </div>
      </RevealWrapper>
    </section>
  )
}
ENDOFFILE
echo "✅ About.tsx — SVG icons done!"

# ── Process.tsx — replace number-only with SVG step icons ─────
cat > src/components/sections/Process.tsx << 'ENDOFFILE'
'use client'

import { useState } from 'react'
import RevealWrapper from '@/components/ui/RevealWrapper'

function IconDiscover() {
  return (
    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#00f5c4" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
      <circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/>
    </svg>
  )
}
function IconArchitect() {
  return (
    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#00f5c4" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
      <line x1="12" y1="2" x2="12" y2="6"/><line x1="12" y1="18" x2="12" y2="22"/>
      <line x1="4.93" y1="4.93" x2="7.76" y2="7.76"/><line x1="16.24" y1="16.24" x2="19.07" y2="19.07"/>
      <line x1="2" y1="12" x2="6" y2="12"/><line x1="18" y1="12" x2="22" y2="12"/>
      <circle cx="12" cy="12" r="4"/>
    </svg>
  )
}
function IconEngineer() {
  return (
    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#00f5c4" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
      <polyline points="16 18 22 12 16 6"/><polyline points="8 6 2 12 8 18"/>
    </svg>
  )
}
function IconDeploy() {
  return (
    <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#00f5c4" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
      <polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/>
    </svg>
  )
}

const steps = [
  { num: '01', Icon: IconDiscover, title: 'Discovery',    desc: 'We deep-dive into your business context, challenges, and goals to define the right solution scope.' },
  { num: '02', Icon: IconArchitect,title: 'Architecture', desc: 'Technical design, data modeling, and system architecture planned before a single line of code is written.' },
  { num: '03', Icon: IconEngineer, title: 'Engineering',  desc: 'Iterative development with continuous client feedback loops — transparent progress, zero surprises.' },
  { num: '04', Icon: IconDeploy,   title: 'Deployment',   desc: 'Staged launch with full QA, team training, documentation, and post-launch monitoring included.' },
]

function StepCard({ step, delay }: { step: typeof steps[0]; delay: number }) {
  const [hovered, setHovered] = useState(false)
  return (
    <RevealWrapper delay={delay}>
      <div
        style={{ background: hovered ? '#0a1e2e' : '#020d14', padding: '40px 28px', position: 'relative', overflow: 'hidden', transition: 'background 0.3s', height: '100%', cursor: 'default' }}
        onMouseEnter={() => setHovered(true)}
        onMouseLeave={() => setHovered(false)}
      >
        {/* Step number — faint bg */}
        <div style={{ fontFamily: 'var(--font-syne)', fontWeight: 800, fontSize: '3.5rem', color: hovered ? 'rgba(0,245,196,0.15)' : 'rgba(0,245,196,0.07)', lineHeight: 1, marginBottom: '16px', transition: 'color 0.3s' }}>
          {step.num}
        </div>

        {/* SVG icon */}
        <div
          style={{
            width: '44px', height: '44px',
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            border: `1px solid ${hovered ? 'rgba(0,245,196,0.35)' : 'rgba(0,245,196,0.15)'}`,
            background: hovered ? 'rgba(0,245,196,0.08)' : 'rgba(0,245,196,0.03)',
            marginBottom: '20px',
            transition: 'all 0.3s',
          }}
        >
          <step.Icon />
        </div>

        <div style={{ fontFamily: 'var(--font-syne)', fontWeight: 700, fontSize: '1rem', color: '#e8f4f8', marginBottom: '10px' }}>
          {step.title}
        </div>
        <div style={{ fontSize: '0.83rem', color: '#3d6070', lineHeight: 1.6 }}>
          {step.desc}
        </div>

        <div style={{ position: 'absolute', bottom: 0, left: 0, height: '2px', width: hovered ? '100%' : '0%', background: 'linear-gradient(90deg,#00f5c4,#39ff9a)', transition: 'width 0.4s cubic-bezier(0.23,1,0.32,1)' }} />
      </div>
    </RevealWrapper>
  )
}

export default function Process() {
  return (
    <section id="process" style={{ padding: '120px 5%', borderTop: '1px solid rgba(0,245,196,0.12)', borderBottom: '1px solid rgba(0,245,196,0.12)', background: 'linear-gradient(180deg,transparent,rgba(0,245,196,0.02) 50%,transparent)' }}>
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

        <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(220px,1fr))', gap: '2px', background: 'rgba(0,245,196,0.12)' }}>
          {steps.map((step, i) => (
            <StepCard key={step.num} step={step} delay={i * 0.1} />
          ))}
        </div>
      </div>
    </section>
  )
}
ENDOFFILE
echo "✅ Process.tsx — SVG icons done!"

echo ""
echo "🎉 All emojis replaced with premium SVG icons!"
echo "   Services: 6 custom SVGs"
echo "   About pillars: 4 custom SVGs"
echo "   Process steps: 4 custom SVGs + step numbers kept"
echo ""
echo "   Run: npm run dev → localhost:3000"
