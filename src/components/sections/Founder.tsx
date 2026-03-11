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
