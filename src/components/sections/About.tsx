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
