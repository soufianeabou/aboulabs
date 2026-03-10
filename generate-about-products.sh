#!/bin/bash

# ── About Section ──────────────────────────────────────────────
cat > src/components/sections/About.tsx << 'ENDOFFILE'
'use client'

import RevealWrapper from '@/components/ui/RevealWrapper'

const pillars = [
  { icon: '⚡', title: 'SaaS Products',    desc: 'Purpose-built platforms for industry verticals' },
  { icon: '🧠', title: 'Consulting',       desc: 'Strategic digital transformation guidance' },
  { icon: '🚀', title: 'Scale',            desc: 'Architectures designed to grow with you' },
  { icon: '🇲🇦', title: 'Morocco-First',  desc: 'Local insight, global engineering standards' },
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
      {/* Left — Text */}
      <RevealWrapper>
        <div
          style={{
            fontFamily: 'var(--font-jetbrains)',
            fontSize: '0.65rem',
            letterSpacing: '0.25em',
            color: '#00f5c4',
            textTransform: 'uppercase',
            marginBottom: '16px',
            display: 'flex',
            alignItems: 'center',
            gap: '12px',
          }}
        >
          <span style={{ width: '30px', height: '1px', background: '#00f5c4', display: 'inline-block' }} />
          Who We Are
        </div>

        <h2
          style={{
            fontFamily: 'var(--font-syne)',
            fontWeight: 800,
            fontSize: 'clamp(2rem, 4vw, 3.2rem)',
            lineHeight: 1.15,
            color: '#e8f4f8',
            marginBottom: '16px',
          }}
        >
          Built for Morocco.{' '}
          <span
            style={{
              background: 'linear-gradient(135deg, #00f5c4, #39ff9a)',
              WebkitBackgroundClip: 'text',
              WebkitTextFillColor: 'transparent',
              backgroundClip: 'text',
            }}
          >
            Engineered for the World.
          </span>
        </h2>

        <p
          style={{
            fontSize: '1rem',
            color: '#7ba3b8',
            lineHeight: 1.7,
            maxWidth: '480px',
            marginBottom: '40px',
          }}
        >
          ABOULABS is an e-consulting and SaaS technology company on a mission
          to digitally transform Moroccan businesses. We build scalable, elegant
          software products — and the digital expertise to deploy them.
        </p>

        {/* Pillars grid */}
        <div
          style={{
            display: 'grid',
            gridTemplateColumns: '1fr 1fr',
            gap: '16px',
          }}
        >
          {pillars.map((p) => (
            <div
              key={p.title}
              style={{
                padding: '20px',
                border: '1px solid rgba(0,245,196,0.12)',
                background: 'rgba(0,245,196,0.02)',
                transition: 'all 0.3s',
                cursor: 'default',
              }}
              onMouseEnter={e => {
                const el = e.currentTarget as HTMLDivElement
                el.style.borderColor = 'rgba(0,245,196,0.35)'
                el.style.background  = 'rgba(0,245,196,0.04)'
                el.style.transform   = 'translateY(-2px)'
              }}
              onMouseLeave={e => {
                const el = e.currentTarget as HTMLDivElement
                el.style.borderColor = 'rgba(0,245,196,0.12)'
                el.style.background  = 'rgba(0,245,196,0.02)'
                el.style.transform   = 'translateY(0)'
              }}
            >
              <div style={{ fontSize: '1.2rem', marginBottom: '10px' }}>{p.icon}</div>
              <div
                style={{
                  fontFamily: 'var(--font-syne)',
                  fontWeight: 700,
                  fontSize: '0.85rem',
                  color: '#e8f4f8',
                  marginBottom: '6px',
                }}
              >
                {p.title}
              </div>
              <div
                style={{
                  fontSize: '0.78rem',
                  color: '#3d6070',
                  lineHeight: 1.5,
                }}
              >
                {p.desc}
              </div>
            </div>
          ))}
        </div>
      </RevealWrapper>

      {/* Right — Visual */}
      <RevealWrapper delay={0.15}>
        <div
          style={{
            position: 'relative',
            width: '100%',
            maxWidth: '420px',
            aspectRatio: '1',
            margin: '0 auto',
          }}
        >
          {/* Rings */}
          {[
            { size: '80%', offset: '10%', color: 'rgba(0,245,196,0.08)', duration: '20s', dir: 'normal' },
            { size: '60%', offset: '20%', color: 'rgba(0,245,196,0.15)', duration: '15s', dir: 'reverse' },
            { size: '40%', offset: '30%', color: 'rgba(0,245,196,0.2)',  duration: '10s', dir: 'normal' },
          ].map((ring, i) => (
            <div
              key={i}
              style={{
                position: 'absolute',
                width: ring.size,
                height: ring.size,
                top: ring.offset,
                left: ring.offset,
                borderRadius: '50%',
                border: `1px solid ${ring.color}`,
                animation: `spin ${ring.duration} linear infinite ${ring.dir}`,
              }}
            />
          ))}

          {/* Center Logo */}
          <div
            style={{
              position: 'absolute',
              top: '50%',
              left: '50%',
              transform: 'translate(-50%, -50%)',
              width: '80px',
              height: '80px',
              filter: 'drop-shadow(0 0 20px rgba(0,245,196,0.4))',
            }}
          >
            <svg viewBox="0 0 100 100" fill="none" style={{ width: '100%', height: '100%' }}>
              <defs>
                <linearGradient id="aboutG1" x1="5" y1="5" x2="95" y2="85" gradientUnits="userSpaceOnUse">
                  <stop offset="0%" stopColor="#00f5c4" />
                  <stop offset="100%" stopColor="#39ff9a" />
                </linearGradient>
                <linearGradient id="aboutG2" x1="22" y1="48" x2="78" y2="85" gradientUnits="userSpaceOnUse">
                  <stop offset="0%" stopColor="#00c4a7" />
                  <stop offset="100%" stopColor="#00e5ff" />
                </linearGradient>
              </defs>
              <polygon points="50,5 95,85 5,85" fill="none" stroke="url(#aboutG1)" strokeWidth="7" />
              <polyline points="22,85 50,48 78,85" fill="none" stroke="url(#aboutG2)" strokeWidth="5" />
            </svg>
          </div>

          {/* Orbiting dots */}
          <div
            style={{
              position: 'absolute',
              width: '8px',
              height: '8px',
              background: '#00f5c4',
              borderRadius: '50%',
              boxShadow: '0 0 10px #00f5c4',
              top: '5%',
              left: '50%',
              animation: 'float 3s ease-in-out infinite',
            }}
          />
          <div
            style={{
              position: 'absolute',
              width: '6px',
              height: '6px',
              background: '#39ff9a',
              borderRadius: '50%',
              boxShadow: '0 0 8px #39ff9a',
              bottom: '15%',
              right: '10%',
              animation: 'float 4s ease-in-out infinite 1s',
            }}
          />
          <div
            style={{
              position: 'absolute',
              width: '5px',
              height: '5px',
              background: '#00e5ff',
              borderRadius: '50%',
              boxShadow: '0 0 8px #00e5ff',
              top: '30%',
              left: '5%',
              animation: 'float 3.5s ease-in-out infinite 0.5s',
            }}
          />
        </div>
      </RevealWrapper>
    </section>
  )
}
ENDOFFILE

echo "✅ About.tsx created!"

# ── Products Section ───────────────────────────────────────────
cat > src/components/sections/Products.tsx << 'ENDOFFILE'
'use client'

import { useState } from 'react'
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
            position: 'relative',
            overflow: 'hidden',
            transform: `rotate(${s.rotate}) scale(${s.scale})`,
            opacity: s.opacity,
            boxShadow: i === 1 ? '0 0 30px rgba(0,245,196,0.15)' : 'none',
          }}
        >
          <div style={{ position: 'absolute', inset: '6px', background: 'linear-gradient(135deg,#071826,#0a2535)', borderRadius: '10px', display: 'flex', flexDirection: 'column', overflow: 'hidden' }}>
            <div style={{ background: 'linear-gradient(135deg,rgba(0,245,196,0.18),rgba(57,255,154,0.08))', height: '28%', display: 'flex', alignItems: 'center', justifyContent: 'center', fontFamily: 'var(--font-syne)', fontSize: '0.42rem', color: '#00f5c4', letterSpacing: '0.1em', fontWeight: 700 }}>
              MAW9IF
            </div>
            <div style={{ flex: 1, padding: '4px', display: 'flex', flexDirection: 'column', gap: '3px' }}>
              {[80, 55, 75, 60, 85, 50].map((w, j) => (
                <div key={j} style={{ height: '10px', background: 'rgba(0,245,196,0.07)', borderRadius: '2px', borderLeft: '2px solid rgba(0,245,196,0.3)', width: `${w}%` }} />
              ))}
            </div>
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
          padding: isMobile ? '48px 40px' : '48px 40px',
          position: 'relative',
          overflow: 'hidden',
          transition: 'all 0.4s cubic-bezier(0.23,1,0.32,1)',
          transform: hovered ? 'translateY(-4px)' : 'translateY(0)',
          boxShadow: hovered ? '0 20px 60px rgba(0,0,0,0.5)' : 'none',
          display: isMobile ? 'grid' : 'flex',
          gridTemplateColumns: isMobile ? '1fr 1fr' : undefined,
          flexDirection: isMobile ? undefined : 'column',
          gap: isMobile ? '48px' : '0',
          alignItems: isMobile ? 'center' : undefined,
          height: '100%',
        }}
        onMouseEnter={() => setHovered(true)}
        onMouseLeave={() => setHovered(false)}
      >
        {/* Top gradient bar */}
        <div
          style={{
            position: 'absolute',
            top: 0, left: 0, right: 0,
            height: '2px',
            background: 'linear-gradient(90deg, #00f5c4, #39ff9a)',
            transform: hovered ? 'scaleX(1)' : 'scaleX(0)',
            transformOrigin: 'left',
            transition: 'transform 0.4s cubic-bezier(0.23,1,0.32,1)',
          }}
        />

        {/* Background glow on hover */}
        <div
          style={{
            position: 'absolute',
            inset: 0,
            background: 'linear-gradient(135deg, rgba(0,245,196,0.05) 0%, transparent 60%)',
            opacity: hovered ? 1 : 0,
            transition: 'opacity 0.4s',
            pointerEvents: 'none',
          }}
        />

        {/* Content */}
        <div style={{ position: 'relative', display: 'flex', flexDirection: 'column', flex: 1 }}>
          <div style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.65rem', letterSpacing: '0.2em', color: '#00f5c4', marginBottom: '28px', opacity: 0.7 }}>
            PRODUCT / {product.num}{product.type === 'mobile' ? ' — MOBILE APP' : ''}
          </div>

          <div
            style={{
              width: '56px', height: '56px',
              border: '1px solid rgba(0,245,196,0.35)',
              display: 'flex', alignItems: 'center', justifyContent: 'center',
              marginBottom: '24px',
              fontSize: '1.5rem',
              background: hovered ? 'rgba(0,245,196,0.1)' : 'rgba(0,245,196,0.04)',
              clipPath: 'polygon(6px 0%, 100% 0%, calc(100% - 6px) 100%, 0% 100%)',
              transition: 'background 0.3s',
            }}
          >
            {product.icon}
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

          <a
            href="#contact"
            style={{
              fontFamily: 'var(--font-jetbrains)',
              fontSize: '0.72rem',
              letterSpacing: '0.12em',
              color: '#00f5c4',
              textDecoration: 'none',
              display: 'flex',
              alignItems: 'center',
              gap: '8px',
            }}
          >
            Learn more →
          </a>
        </div>

        {/* Phone mockup for mobile product */}
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
    <section
      id="products"
      style={{ padding: '120px 5%', maxWidth: '1200px', margin: '0 auto' }}
    >
      {/* Header */}
      <div
        style={{
          display: 'flex',
          justifyContent: 'space-between',
          alignItems: 'flex-end',
          marginBottom: '64px',
          flexWrap: 'wrap',
          gap: '24px',
        }}
      >
        <RevealWrapper>
          <div style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.65rem', letterSpacing: '0.25em', color: '#00f5c4', textTransform: 'uppercase', marginBottom: '16px', display: 'flex', alignItems: 'center', gap: '12px' }}>
            <span style={{ width: '30px', height: '1px', background: '#00f5c4', display: 'inline-block' }} />
            Our Ecosystem
          </div>
          <h2 style={{ fontFamily: 'var(--font-syne)', fontWeight: 800, fontSize: 'clamp(2rem,4vw,3.2rem)', lineHeight: 1.15, color: '#e8f4f8' }}>
            The{' '}
            <span style={{ background: 'linear-gradient(135deg,#00f5c4,#39ff9a)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent', backgroundClip: 'text' }}>
              ABOULABS
            </span>
            <br />Product Suite
          </h2>
        </RevealWrapper>

        <RevealWrapper delay={0.1}>
          <p style={{ fontSize: '0.9rem', color: '#7ba3b8', maxWidth: '300px', lineHeight: 1.7 }}>
            Four vertical SaaS solutions built to digitalize and scale Moroccan industries.
          </p>
        </RevealWrapper>
      </div>

      {/* Grid */}
      <div
        style={{
          display: 'grid',
          gridTemplateColumns: 'repeat(auto-fit, minmax(340px, 1fr))',
          gap: '2px',
          background: 'rgba(0,245,196,0.12)',
        }}
      >
        {products.map((product, i) => (
          <ProductCard key={product.id} product={product} index={i} />
        ))}
      </div>
    </section>
  )
}
ENDOFFILE

echo "✅ Products.tsx created!"

# ── Update page.tsx ────────────────────────────────────────────
cat > src/app/page.tsx << 'ENDOFFILE'
import Cursor   from '@/components/ui/Cursor'
import Navbar   from '@/components/layout/Navbar'
import Hero     from '@/components/sections/Hero'
import Ticker   from '@/components/sections/Ticker'
import About    from '@/components/sections/About'
import Products from '@/components/sections/Products'

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
      </main>
    </>
  )
}
ENDOFFILE

echo "✅ page.tsx updated!"
echo ""
echo "🚀 All done! Check localhost:3000"
