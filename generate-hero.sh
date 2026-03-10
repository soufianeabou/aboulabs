#!/bin/bash

# ── Hero Section ──────────────────────────────────────────────
cat > src/components/sections/Hero.tsx << 'ENDOFFILE'
'use client'

import { motion } from 'framer-motion'

const fadeUp = (delay = 0) => ({
  initial: { opacity: 0, y: 24 },
  animate: { opacity: 1, y: 0 },
  transition: { duration: 0.8, delay, ease: [0.23, 1, 0.32, 1] },
})

export default function Hero() {
  return (
    <section
      style={{
        minHeight: '100vh',
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        justifyContent: 'center',
        padding: '120px 5% 80px',
        position: 'relative',
        overflow: 'hidden',
      }}
    >
      {/* Grid background */}
      <div
        className="grid-bg"
        style={{ position: 'absolute', inset: 0, pointerEvents: 'none' }}
      />

      {/* Orb 1 */}
      <div
        style={{
          position: 'absolute',
          width: '600px',
          height: '600px',
          borderRadius: '50%',
          background: 'radial-gradient(circle, rgba(0,245,196,0.08) 0%, transparent 70%)',
          filter: 'blur(100px)',
          top: '-100px',
          left: '50%',
          transform: 'translateX(-50%)',
          pointerEvents: 'none',
        }}
      />

      {/* Orb 2 */}
      <div
        style={{
          position: 'absolute',
          width: '400px',
          height: '400px',
          borderRadius: '50%',
          background: 'radial-gradient(circle, rgba(57,255,154,0.06) 0%, transparent 70%)',
          filter: 'blur(100px)',
          bottom: 0,
          right: '10%',
          pointerEvents: 'none',
        }}
      />

      {/* Badge */}
      <motion.div {...fadeUp(0.1)}>
        <div
          style={{
            fontFamily: 'var(--font-jetbrains)',
            fontSize: '0.68rem',
            letterSpacing: '0.2em',
            color: '#00f5c4',
            border: '1px solid rgba(0,245,196,0.35)',
            padding: '6px 18px',
            marginBottom: '32px',
            background: 'rgba(0,245,196,0.04)',
            textTransform: 'uppercase',
          }}
        >
          {'// '}Morocco&apos;s Premier Tech Studio{' //'}
        </div>
      </motion.div>

      {/* Headline */}
      <motion.h1
        {...fadeUp(0.2)}
        style={{
          fontFamily: 'var(--font-syne)',
          fontWeight: 800,
          fontSize: 'clamp(3rem, 7vw, 6.5rem)',
          lineHeight: 1.0,
          textAlign: 'center',
          maxWidth: '900px',
          marginBottom: '12px',
        }}
      >
        <span style={{ display: 'block', color: '#e8f4f8' }}>We Engineer</span>
        <span
          className="glitch"
          data-text="Digital Futures"
          style={{
            display: 'block',
            background: 'linear-gradient(135deg, #00f5c4 0%, #39ff9a 50%, #00e5ff 100%)',
            WebkitBackgroundClip: 'text',
            WebkitTextFillColor: 'transparent',
            backgroundClip: 'text',
          }}
        >
          Digital Futures
        </span>
      </motion.h1>

      {/* Subheading */}
      <motion.p
        {...fadeUp(0.35)}
        style={{
          fontFamily: 'var(--font-inter)',
          fontWeight: 300,
          fontSize: 'clamp(1rem, 1.5vw, 1.15rem)',
          color: '#7ba3b8',
          textAlign: 'center',
          maxWidth: '520px',
          lineHeight: 1.7,
          marginBottom: '48px',
        }}
      >
        SaaS solutions and digital consulting designed for Morocco&apos;s businesses —
        built to world-class standards, engineered for real impact.
      </motion.p>

      {/* CTA Buttons */}
      <motion.div
        {...fadeUp(0.45)}
        style={{ display: 'flex', gap: '16px', alignItems: 'center', flexWrap: 'wrap', justifyContent: 'center' }}
      >
        <a
          href="#products"
          style={{
            fontFamily: 'var(--font-jetbrains)',
            fontSize: '0.8rem',
            letterSpacing: '0.1em',
            color: '#020d14',
            background: 'linear-gradient(135deg, #00f5c4, #39ff9a)',
            padding: '14px 32px',
            textDecoration: 'none',
            clipPath: 'polygon(10px 0%, 100% 0%, calc(100% - 10px) 100%, 0% 100%)',
            fontWeight: 600,
          }}
        >
          Explore Products
        </a>
        <a
          href="#contact"
          style={{
            fontFamily: 'var(--font-jetbrains)',
            fontSize: '0.8rem',
            letterSpacing: '0.1em',
            color: '#00f5c4',
            border: '1px solid rgba(0,245,196,0.35)',
            padding: '14px 32px',
            textDecoration: 'none',
            background: 'transparent',
            transition: 'background 0.3s',
          }}
        >
          Start a Project
        </a>
      </motion.div>

      {/* Stats */}
      <motion.div
        {...fadeUp(0.6)}
        style={{
          display: 'flex',
          gap: '60px',
          marginTop: '80px',
          paddingTop: '40px',
          borderTop: '1px solid rgba(0,245,196,0.12)',
          flexWrap: 'wrap',
          justifyContent: 'center',
        }}
      >
        {[
          { num: '4+',   label: 'SaaS Products'    },
          { num: '100%', label: 'Online Delivery'   },
          { num: 'MA',   label: 'Based in Morocco'  },
          { num: '∞',    label: 'Scalable Solutions' },
        ].map((stat) => (
          <div key={stat.label} style={{ textAlign: 'center' }}>
            <span
              style={{
                display: 'block',
                fontFamily: 'var(--font-syne)',
                fontWeight: 800,
                fontSize: '2rem',
                background: 'linear-gradient(135deg, #00f5c4, #39ff9a)',
                WebkitBackgroundClip: 'text',
                WebkitTextFillColor: 'transparent',
                backgroundClip: 'text',
              }}
            >
              {stat.num}
            </span>
            <span
              style={{
                fontFamily: 'var(--font-jetbrains)',
                fontSize: '0.65rem',
                letterSpacing: '0.15em',
                color: '#3d6070',
                textTransform: 'uppercase',
                marginTop: '4px',
                display: 'block',
              }}
            >
              {stat.label}
            </span>
          </div>
        ))}
      </motion.div>
    </section>
  )
}
ENDOFFILE

# ── Ticker Section ─────────────────────────────────────────────
cat > src/components/sections/Ticker.tsx << 'ENDOFFILE'
const items = [
  '01 — Digital Transformation',
  '02 — SaaS Engineering',
  '03 — Web Platforms',
  '04 — Process Digitalization',
  '05 — Mobile Applications',
  '06 — E-Consulting',
  '07 — Morocco & Beyond',
  '08 — Premium Engineering',
]

export default function Ticker() {
  return (
    <div
      style={{
        width: '100%',
        overflow: 'hidden',
        padding: '18px 0',
        borderTop: '1px solid rgba(0,245,196,0.12)',
        borderBottom: '1px solid rgba(0,245,196,0.12)',
        background: 'rgba(0,245,196,0.02)',
        position: 'relative',
        zIndex: 2,
      }}
    >
      <div
        style={{
          display: 'flex',
          width: 'max-content',
          animation: 'ticker 25s linear infinite',
        }}
      >
        {[...items, ...items].map((item, i) => (
          <span
            key={i}
            style={{
              fontFamily: 'var(--font-jetbrains)',
              fontSize: '0.7rem',
              letterSpacing: '0.15em',
              color: '#3d6070',
              textTransform: 'uppercase',
              padding: '0 40px',
              whiteSpace: 'nowrap',
            }}
          >
            <span style={{ color: '#00f5c4', marginRight: '8px' }}>◆</span>
            {item}
          </span>
        ))}
      </div>
    </div>
  )
}
ENDOFFILE

# ── page.tsx ───────────────────────────────────────────────────
cat > src/app/page.tsx << 'ENDOFFILE'
import Cursor  from '@/components/ui/Cursor'
import Navbar  from '@/components/layout/Navbar'
import Hero    from '@/components/sections/Hero'
import Ticker  from '@/components/sections/Ticker'

export default function Home() {
  return (
    <>
      <Cursor />
      <Navbar />
      <main>
        <Hero />
        <Ticker />
      </main>
    </>
  )
}
ENDOFFILE

echo "✅ Hero, Ticker, and page.tsx created successfully!"
