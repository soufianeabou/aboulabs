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
              width: "88px", height: "88px",
              border: '1px solid rgba(0,245,196,0.35)',
              display: 'flex', alignItems: 'center', justifyContent: 'center',
              marginBottom: '24px',
              background: hovered ? 'rgba(0,245,196,0.08)' : 'rgba(0,245,196,0.03)',
              clipPath: 'polygon(6px 0%, 100% 0%, calc(100% - 6px) 100%, 0% 100%)',
              transition: 'background 0.3s',
              padding: "14px",
            }}
          >
            {product.logo ? (
              <Image
                src={product.logo}
                alt={product.name}
                width={64}
                height={64}
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
