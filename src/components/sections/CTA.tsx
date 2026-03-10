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
