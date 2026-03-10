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
