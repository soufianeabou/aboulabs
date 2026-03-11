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
