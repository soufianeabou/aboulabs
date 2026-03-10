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
