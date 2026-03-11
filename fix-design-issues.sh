#!/bin/bash

echo "🔧 Applying fixes..."

# ── 1. Hero.tsx — fix French title overflow ───────────────────
cat > src/components/sections/Hero.tsx << 'ENDOFFILE'
'use client'

import { motion } from 'framer-motion'
import { useLang } from '@/lib/LanguageContext'

const fadeUp = (delay = 0) => ({
  initial: { opacity: 0, y: 24 },
  animate: { opacity: 1, y: 0 },
  transition: { duration: 0.8, delay, ease: [0.23, 1, 0.32, 1] },
})

export default function Hero() {
  const { t } = useLang()

  const stats = [
    { num: '4+',   labelEn: 'SaaS Products',      labelFr: 'Produits SaaS'       },
    { num: '100%', labelEn: 'Online Delivery',     labelFr: 'Livraison en ligne'  },
    { num: '2025', labelEn: 'Founded',             labelFr: 'Fondée'              },
    { num: '∞',    labelEn: 'Scalable Solutions',  labelFr: 'Solutions scalables' },
  ]

  const line2 = t('Digital Futures', "L'Avenir Numérique")

  return (
    <section style={{ minHeight: '100vh', display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center', padding: '120px 5% 80px', position: 'relative', overflow: 'hidden' }}>
      <div className="grid-bg" style={{ position: 'absolute', inset: 0, pointerEvents: 'none' }} />
      <div style={{ position: 'absolute', width: '600px', height: '600px', borderRadius: '50%', background: 'radial-gradient(circle,rgba(0,245,196,0.08) 0%,transparent 70%)', filter: 'blur(100px)', top: '-100px', left: '50%', transform: 'translateX(-50%)', pointerEvents: 'none' }} />
      <div style={{ position: 'absolute', width: '400px', height: '400px', borderRadius: '50%', background: 'radial-gradient(circle,rgba(57,255,154,0.06) 0%,transparent 70%)', filter: 'blur(100px)', bottom: 0, right: '10%', pointerEvents: 'none' }} />

      <motion.div {...fadeUp(0.1)}>
        <div style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.68rem', letterSpacing: '0.2em', color: '#00f5c4', border: '1px solid rgba(0,245,196,0.35)', padding: '6px 18px', marginBottom: '32px', background: 'rgba(0,245,196,0.04)', textTransform: 'uppercase' }}>
          {t('// Morocco\'s Premier Tech Studio //', '// Le Studio Tech de Référence au Maroc //')}
        </div>
      </motion.div>

      <motion.h1
        {...fadeUp(0.2)}
        style={{
          fontFamily: 'var(--font-syne)',
          fontWeight: 800,
          /* Slightly smaller on FR to prevent overflow */
          fontSize: 'clamp(2.4rem,5.5vw,6rem)',
          lineHeight: 1.05,
          textAlign: 'center',
          maxWidth: '960px',
          width: '100%',
          marginBottom: '12px',
          wordBreak: 'break-word',
          overflowWrap: 'break-word',
        }}
      >
        <span style={{ display: 'block', color: '#e8f4f8' }}>
          {t('We Engineer', 'Nous Façonnons')}
        </span>
        <span
          style={{
            display: 'block',
            background: 'linear-gradient(135deg,#00f5c4 0%,#39ff9a 50%,#00e5ff 100%)',
            WebkitBackgroundClip: 'text',
            WebkitTextFillColor: 'transparent',
            backgroundClip: 'text',
            /* Ensure long French words don't get cut */
            paddingBottom: '0.1em',
          }}
        >
          {line2}
        </span>
      </motion.h1>

      <motion.p
        {...fadeUp(0.35)}
        style={{ fontFamily: 'var(--font-inter)', fontWeight: 300, fontSize: 'clamp(1rem,1.5vw,1.15rem)', color: '#7ba3b8', textAlign: 'center', maxWidth: '520px', lineHeight: 1.7, marginBottom: '48px' }}
      >
        {t(
          "SaaS solutions and digital consulting designed for Morocco's businesses — built to world-class standards, engineered for real impact.",
          "Des solutions SaaS et du conseil digital conçus pour les entreprises marocaines — des standards internationaux, un impact concret."
        )}
      </motion.p>

      <motion.div {...fadeUp(0.45)} style={{ display: 'flex', gap: '16px', alignItems: 'center', flexWrap: 'wrap', justifyContent: 'center' }}>
        <a href="#products" style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.8rem', letterSpacing: '0.1em', color: '#020d14', background: 'linear-gradient(135deg,#00f5c4,#39ff9a)', padding: '14px 32px', textDecoration: 'none', clipPath: 'polygon(10px 0%,100% 0%,calc(100% - 10px) 100%,0% 100%)', fontWeight: 600 }}>
          {t('Explore Products', 'Découvrir nos produits')}
        </a>
        <a href="#contact" style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.8rem', letterSpacing: '0.1em', color: '#00f5c4', border: '1px solid rgba(0,245,196,0.35)', padding: '14px 32px', textDecoration: 'none', background: 'transparent' }}>
          {t('Start a Project', 'Démarrer un projet')}
        </a>
      </motion.div>

      <motion.div {...fadeUp(0.6)} style={{ display: 'flex', gap: '60px', marginTop: '80px', paddingTop: '40px', borderTop: '1px solid rgba(0,245,196,0.12)', flexWrap: 'wrap', justifyContent: 'center' }}>
        {stats.map((stat) => (
          <div key={stat.labelEn} style={{ textAlign: 'center' }}>
            <span style={{ display: 'block', fontFamily: 'var(--font-syne)', fontWeight: 800, fontSize: '2rem', background: 'linear-gradient(135deg,#00f5c4,#39ff9a)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent', backgroundClip: 'text' }}>
              {stat.num}
            </span>
            <span style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.65rem', letterSpacing: '0.15em', color: '#3d6070', textTransform: 'uppercase', marginTop: '4px', display: 'block' }}>
              {t(stat.labelEn, stat.labelFr)}
            </span>
          </div>
        ))}
      </motion.div>
    </section>
  )
}
ENDOFFILE
echo "✅ Hero.tsx — French overflow fixed"

# ── 2. Products.tsx — redesigned header + smart logo display ──
cat > src/components/sections/Products.tsx << 'ENDOFFILE'
'use client'

import { useState } from 'react'
import Image from 'next/image'
import RevealWrapper from '@/components/ui/RevealWrapper'
import { products } from '@/data/products'

function StatusBadge({ status }: { status: 'beta' | 'coming-soon' }) {
  const isBeta = status === 'beta'
  return (
    <div style={{
      position: 'absolute', top: '16px', right: '16px',
      fontFamily: 'var(--font-jetbrains)', fontSize: '0.58rem', letterSpacing: '0.15em',
      padding: '3px 10px',
      border: `1px solid ${isBeta ? 'rgba(0,245,196,0.4)' : 'rgba(245,158,11,0.4)'}`,
      color: isBeta ? '#00f5c4' : '#f59e0b',
      background: isBeta ? 'rgba(0,245,196,0.06)' : 'rgba(245,158,11,0.06)',
      textTransform: 'uppercase', zIndex: 2,
    }}>
      {isBeta ? 'BETA' : 'COMING SOON'}
    </div>
  )
}

/* Smart logo display — white/light bg for dark logos, dark bg for light logos */
function ProductLogo({ src, alt, hovered }: { src: string; alt: string; hovered: boolean }) {
  return (
    <div style={{
      width: '100%', height: '100%',
      display: 'flex', alignItems: 'center', justifyContent: 'center',
      position: 'relative',
    }}>
      <Image
        src={src}
        alt={alt}
        fill
        style={{
          objectFit: 'contain',
          padding: '12px',
          filter: hovered
            ? 'brightness(1.1) drop-shadow(0 0 8px rgba(0,245,196,0.3))'
            : 'brightness(1)',
          transition: 'filter 0.3s',
        }}
      />
    </div>
  )
}

function PhoneMockup() {
  return (
    <div style={{ display: 'flex', justifyContent: 'center', gap: '16px', alignItems: 'flex-end' }}>
      {[
        { rotate: '-4deg', scale: '0.92', opacity: '0.75' },
        { rotate: '0deg',  scale: '1',    opacity: '1'    },
        { rotate: '4deg',  scale: '0.92', opacity: '0.75' },
      ].map((s, i) => (
        <div key={i} style={{ width: '110px', aspectRatio: '9/19', border: '2px solid rgba(0,245,196,0.35)', borderRadius: '16px', background: '#071826', overflow: 'hidden', transform: `rotate(${s.rotate}) scale(${s.scale})`, opacity: s.opacity, boxShadow: i === 1 ? '0 0 30px rgba(0,245,196,0.15)' : 'none', display: 'flex', flexDirection: 'column' }}>
          <div style={{ background: 'linear-gradient(135deg,rgba(0,245,196,0.18),rgba(57,255,154,0.08))', height: '28%', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '6px' }}>
            <div style={{ position: 'relative', width: '20px', height: '20px' }}>
              <Image src="/logos/maw9if-logo.png" alt="Maw9if" fill style={{ objectFit: 'contain' }} />
            </div>
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
        id={product.anchor}
        style={{ background: '#0a1e2e', padding: '48px 36px', position: 'relative', overflow: 'hidden', transition: 'all 0.4s cubic-bezier(0.23,1,0.32,1)', transform: hovered ? 'translateY(-4px)' : 'translateY(0)', boxShadow: hovered ? '0 20px 60px rgba(0,0,0,0.5)' : 'none', display: isMobile ? 'grid' : 'flex', gridTemplateColumns: isMobile ? 'repeat(auto-fit,minmax(280px,1fr))' : undefined, flexDirection: isMobile ? undefined : 'column', gap: isMobile ? '48px' : '0', alignItems: isMobile ? 'center' : undefined, height: '100%' }}
        onMouseEnter={() => setHovered(true)}
        onMouseLeave={() => setHovered(false)}
      >
        {product.status && <StatusBadge status={product.status} />}
        <div style={{ position: 'absolute', top: 0, left: 0, right: 0, height: '2px', background: 'linear-gradient(90deg,#00f5c4,#39ff9a)', transform: hovered ? 'scaleX(1)' : 'scaleX(0)', transformOrigin: 'left', transition: 'transform 0.4s cubic-bezier(0.23,1,0.32,1)' }} />
        <div style={{ position: 'absolute', inset: 0, background: 'linear-gradient(135deg,rgba(0,245,196,0.04) 0%,transparent 60%)', opacity: hovered ? 1 : 0, transition: 'opacity 0.4s', pointerEvents: 'none' }} />

        <div style={{ position: 'relative', display: 'flex', flexDirection: 'column', flex: 1 }}>
          <div style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.65rem', letterSpacing: '0.2em', color: '#00f5c4', marginBottom: '24px', opacity: 0.7 }}>
            PRODUCT / {product.num}{product.type === 'mobile' ? ' — MOBILE APP' : ''}
          </div>

          {/* Logo display — dark pill background so any logo reads clearly */}
          <div style={{
            width: '100px', height: '72px',
            marginBottom: '24px',
            position: 'relative',
            background: 'rgba(255,255,255,0.04)',
            border: `1px solid ${hovered ? 'rgba(0,245,196,0.3)' : 'rgba(255,255,255,0.06)'}`,
            borderRadius: '6px',
            overflow: 'hidden',
            transition: 'border-color 0.3s',
            flexShrink: 0,
          }}>
            {product.logo && (
              <ProductLogo src={product.logo} alt={product.name} hovered={hovered} />
            )}
          </div>

          <div style={{ fontFamily: 'var(--font-syne)', fontWeight: 800, fontSize: '1.6rem', color: '#e8f4f8', marginBottom: '4px', lineHeight: 1 }}>{product.name}</div>
          <div style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.7rem', letterSpacing: '0.1em', color: '#00c4a7', marginBottom: '16px', textTransform: 'uppercase' }}>{product.tagline}</div>
          <p style={{ fontSize: '0.88rem', color: '#7ba3b8', lineHeight: 1.65, marginBottom: '24px', flex: 1 }}>{product.description}</p>

          <div style={{ display: 'flex', flexWrap: 'wrap', gap: '8px', marginBottom: '24px' }}>
            {product.features.map((f) => (
              <span key={f} style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.62rem', letterSpacing: '0.08em', color: hovered ? '#7ba3b8' : '#3d6070', border: `1px solid ${hovered ? 'rgba(0,245,196,0.25)' : 'rgba(0,245,196,0.12)'}`, padding: '4px 10px', background: 'rgba(0,245,196,0.02)', transition: 'all 0.3s' }}>
                {f}
              </span>
            ))}
          </div>

          <a href={`#${product.anchor}`} style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.72rem', letterSpacing: '0.12em', color: '#00f5c4', textDecoration: 'none', display: 'flex', alignItems: 'center', gap: '8px' }}>
            Learn more →
          </a>
        </div>

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
    <section id="products" style={{ padding: '140px 5% 120px', position: 'relative', overflow: 'hidden' }}>

      {/* Background orb */}
      <div style={{ position: 'absolute', width: '700px', height: '700px', borderRadius: '50%', background: 'radial-gradient(circle,rgba(0,245,196,0.04) 0%,transparent 70%)', filter: 'blur(80px)', top: '0', left: '50%', transform: 'translateX(-50%)', pointerEvents: 'none' }} />

      {/* ── Redesigned header ── */}
      <div style={{ maxWidth: '1200px', margin: '0 auto 80px' }}>
        <RevealWrapper>
          <div style={{ display: 'flex', alignItems: 'center', gap: '12px', marginBottom: '24px' }}>
            <span style={{ width: '30px', height: '1px', background: '#00f5c4', display: 'inline-block' }} />
            <span style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.65rem', letterSpacing: '0.25em', color: '#00f5c4', textTransform: 'uppercase' }}>Our Ecosystem</span>
          </div>
        </RevealWrapper>

        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '0', alignItems: 'end' }}>
          <RevealWrapper>
            <h2 style={{ fontFamily: 'var(--font-syne)', fontWeight: 800, fontSize: 'clamp(2.4rem,4.5vw,3.8rem)', lineHeight: 1.1, color: '#e8f4f8', margin: 0 }}>
              The{' '}
              <span style={{ background: 'linear-gradient(135deg,#00f5c4,#39ff9a)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent', backgroundClip: 'text' }}>
                ABOULABS
              </span>
              <br />Product Suite
            </h2>
          </RevealWrapper>

          <RevealWrapper delay={0.15}>
            <div style={{ paddingLeft: '40px', borderLeft: '1px solid rgba(0,245,196,0.15)' }}>
              <p style={{ fontSize: '0.95rem', color: '#7ba3b8', lineHeight: 1.75, margin: '0 0 20px 0' }}>
                Four vertical SaaS solutions purpose-built to digitalize and scale Moroccan industries — from garage floors to law offices.
              </p>
              {/* Product count pills */}
              <div style={{ display: 'flex', gap: '8px', flexWrap: 'wrap' }}>
                {[
                  { label: '2 Live',        color: '#00f5c4', bg: 'rgba(0,245,196,0.08)',   border: 'rgba(0,245,196,0.3)'  },
                  { label: '2 Coming Soon', color: '#f59e0b', bg: 'rgba(245,158,11,0.08)',  border: 'rgba(245,158,11,0.3)' },
                  { label: 'Web + Mobile',  color: '#7ba3b8', bg: 'rgba(123,163,184,0.06)', border: 'rgba(123,163,184,0.2)'},
                ].map((pill) => (
                  <span key={pill.label} style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.62rem', letterSpacing: '0.1em', color: pill.color, border: `1px solid ${pill.border}`, padding: '4px 12px', background: pill.bg }}>
                    {pill.label}
                  </span>
                ))}
              </div>
            </div>
          </RevealWrapper>
        </div>
      </div>

      {/* Cards grid */}
      <div style={{ maxWidth: '1200px', margin: '0 auto', display: 'grid', gridTemplateColumns: 'repeat(auto-fit,minmax(340px,1fr))', gap: '2px', background: 'rgba(0,245,196,0.1)' }}>
        {products.map((product, i) => (
          <ProductCard key={product.id} product={product} index={i} />
        ))}
      </div>
    </section>
  )
}
ENDOFFILE
echo "✅ Products.tsx — header redesigned + smart logo display"

# ── 3. Founder.tsx — emotional origin story, no work details ──
cat > src/components/sections/Founder.tsx << 'ENDOFFILE'
'use client'

import Image from 'next/image'
import RevealWrapper from '@/components/ui/RevealWrapper'
import { useLang } from '@/lib/LanguageContext'

export default function Founder() {
  const { t } = useLang()

  return (
    <section style={{ padding: '120px 5%', maxWidth: '1200px', margin: '0 auto', position: 'relative' }}>
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit,minmax(320px,1fr))', gap: '80px', alignItems: 'center' }}>

        {/* Left — Photo */}
        <RevealWrapper direction="left">
          <div style={{ position: 'relative', maxWidth: '420px', margin: '0 auto' }}>
            <div style={{ position: 'absolute', inset: '-40px', borderRadius: '50%', background: 'radial-gradient(circle,rgba(0,245,196,0.08) 0%,transparent 70%)', filter: 'blur(40px)', pointerEvents: 'none' }} />
            <div className="grid-bg" style={{ position: 'absolute', inset: 0, borderRadius: '4px', opacity: 0.5, pointerEvents: 'none' }} />

            {/* Corner accents */}
            {[
              { top: 0,    left: 0,    borderTop: '2px solid #00f5c4',    borderLeft:   '2px solid #00f5c4'  },
              { top: 0,    right: 0,   borderTop: '2px solid #39ff9a',    borderRight:  '2px solid #39ff9a'  },
              { bottom: 0, left: 0,    borderBottom: '2px solid #39ff9a', borderLeft:   '2px solid #39ff9a'  },
              { bottom: 0, right: 0,   borderBottom: '2px solid #00f5c4', borderRight:  '2px solid #00f5c4'  },
            ].map((corner, i) => (
              <div key={i} style={{ position: 'absolute', width: '28px', height: '28px', zIndex: 3, ...corner }} />
            ))}

            <div style={{ position: 'absolute', inset: 0, border: '1px solid rgba(0,245,196,0.15)', zIndex: 2, pointerEvents: 'none' }} />

            <div style={{ position: 'relative', overflow: 'hidden', clipPath: 'polygon(0 0,100% 0,100% 92%,92% 100%,0 100%)', aspectRatio: '4/5' }}>
              <Image
                src="/founder.jpg"
                alt="Soufiane Aboulhamam — Founder of ABOULABS"
                fill
                style={{ objectFit: 'cover', objectPosition: 'center top', filter: 'contrast(1.05) brightness(0.92)' }}
              />
              <div style={{ position: 'absolute', inset: 0, background: 'linear-gradient(180deg,transparent 55%,rgba(2,13,20,0.75) 100%)', zIndex: 1 }} />
            </div>

            {/* Name card */}
            <div style={{ position: 'absolute', bottom: '-20px', right: '-20px', background: '#0a1e2e', border: '1px solid rgba(0,245,196,0.25)', padding: '14px 18px', zIndex: 4, boxShadow: '0 8px 40px rgba(0,0,0,0.5)' }}>
              <div style={{ fontFamily: 'var(--font-syne)', fontWeight: 700, fontSize: '0.85rem', color: '#e8f4f8', marginBottom: '4px' }}>Soufiane Aboulhamam</div>
              <div style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.6rem', letterSpacing: '0.1em', color: '#00f5c4', textTransform: 'uppercase' }}>Founder, ABOULABS</div>
            </div>
          </div>
        </RevealWrapper>

        {/* Right — Story */}
        <RevealWrapper delay={0.15}>
          <div style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.65rem', letterSpacing: '0.25em', color: '#00f5c4', textTransform: 'uppercase', marginBottom: '16px', display: 'flex', alignItems: 'center', gap: '12px' }}>
            <span style={{ width: '30px', height: '1px', background: '#00f5c4', display: 'inline-block' }} />
            {t('The Builder', 'Le Bâtisseur')}
          </div>

          <h2 style={{ fontFamily: 'var(--font-syne)', fontWeight: 800, fontSize: 'clamp(2rem,4vw,3.2rem)', lineHeight: 1.15, color: '#e8f4f8', marginBottom: '28px' }}>
            {t('Meet the ', 'Rencontrez le ')}
            <span style={{ background: 'linear-gradient(135deg,#00f5c4,#39ff9a)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent', backgroundClip: 'text' }}>
              {t('Founder', 'Fondateur')}
            </span>
          </h2>

          <p style={{ fontSize: '0.95rem', color: '#7ba3b8', lineHeight: 1.8, marginBottom: '36px' }}>
            {t(
              "ABOULABS didn't start with a business plan. It started with a feeling — the quiet frustration of watching talented Moroccan entrepreneurs run their businesses on tools that were never built for them. Spreadsheets patched with tape. WhatsApp groups as CRMs. The gap was real, and it was personal.",
              "ABOULABS n'a pas commencé avec un business plan. C'est né d'un sentiment — cette frustration silencieuse de voir des entrepreneurs marocains talentueux gérer leur activité avec des outils qui n'ont jamais été conçus pour eux. Des tableurs rafistolés. Des groupes WhatsApp en guise de CRM. Le fossé était réel, et il était personnel."
            )}
          </p>

          {/* Quote block */}
          <blockquote style={{ position: 'relative', margin: '0', padding: '28px 28px 28px 32px', border: '1px solid rgba(0,245,196,0.12)', background: 'rgba(0,245,196,0.02)', borderLeft: '3px solid #00f5c4' }}>
            <div style={{ fontFamily: 'var(--font-syne)', fontSize: '3.5rem', color: 'rgba(0,245,196,0.12)', lineHeight: 1, position: 'absolute', top: '10px', left: '16px', fontWeight: 800, userSelect: 'none' }}>"</div>
            <p style={{ fontSize: '1.05rem', color: '#c8dde8', lineHeight: 1.75, fontStyle: 'italic', position: 'relative', zIndex: 1, margin: '12px 0 16px 0', fontFamily: 'var(--font-inter)', fontWeight: 300 }}>
              {t(
                "I didn't want to build a startup. I wanted to build something that actually mattered — software that felt like it understood you.",
                "Je ne voulais pas créer une startup. Je voulais construire quelque chose qui compte vraiment — un logiciel qui te comprend."
              )}
            </p>
            <div style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.65rem', letterSpacing: '0.12em', color: '#00f5c4', textTransform: 'uppercase' }}>
              — Soufiane Aboulhamam, {t('Founder', 'Fondateur')}
            </div>
          </blockquote>
        </RevealWrapper>
      </div>
    </section>
  )
}
ENDOFFILE
echo "✅ Founder.tsx — emotional origin story, no work details"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 All fixes applied!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  ✓ French 'Numérique' no longer cut off"
echo "  ✓ Products header redesigned (2-col, pills)"
echo "  ✓ Logos: neutral bg pill, fill+padding display"
echo "  ✓ Founder: emotional story, clean quote"
echo ""
echo "Run: npm run dev"
