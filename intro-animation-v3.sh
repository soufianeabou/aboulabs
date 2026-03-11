#!/bin/bash

cat > src/components/ui/PageIntro.tsx << 'ENDOFFILE'
'use client'

import { useEffect, useState } from 'react'
import Image from 'next/image'

type Phase =
  | 'blank'
  | 'grid'
  | 'frame'
  | 'mark-in'
  | 'mark-glow'
  | 'scanline'
  | 'wordmark'
  | 'details'
  | 'hold'
  | 'exit'
  | 'done'

const TIMELINE: { phase: Phase; delay: number }[] = [
  { phase: 'blank',     delay: 0    },
  { phase: 'grid',      delay: 200  },
  { phase: 'frame',     delay: 600  },
  { phase: 'mark-in',   delay: 1100 },
  { phase: 'mark-glow', delay: 1700 },
  { phase: 'scanline',  delay: 2400 },
  { phase: 'wordmark',  delay: 3100 },
  { phase: 'details',   delay: 3600 },
  { phase: 'hold',      delay: 4000 },
  { phase: 'exit',      delay: 4600 },
  { phase: 'done',      delay: 5400 },
]

function gte(target: Phase, current: Phase) {
  return TIMELINE.findIndex(t => t.phase === current) >= TIMELINE.findIndex(t => t.phase === target)
}

export default function PageIntro() {
  const [phase, setPhase]     = useState<Phase>('blank')
  const [counter, setCounter] = useState(0)
  const [scanY, setScanY]     = useState(0)

  useEffect(() => {
    const timers = TIMELINE.map(({ phase, delay }) => setTimeout(() => setPhase(phase), delay))
    return () => timers.forEach(clearTimeout)
  }, [])

  // Counter
  useEffect(() => {
    if (phase !== 'scanline') return
    let v = 0
    const iv = setInterval(() => {
      v += Math.floor(Math.random() * 5) + 2
      if (v >= 100) { v = 100; clearInterval(iv) }
      setCounter(v)
    }, 28)
    return () => clearInterval(iv)
  }, [phase])

  // Scanline
  useEffect(() => {
    if (!gte('scanline', phase) || gte('wordmark', phase)) return
    let y = 0
    const iv = setInterval(() => {
      y = (y + 1.2) % 100
      setScanY(y)
    }, 16)
    return () => clearInterval(iv)
  }, [phase])

  if (phase === 'done') return null

  const isExit = phase === 'exit'
  const show   = (p: Phase) => gte(p, phase) && !isExit

  return (
    <>
      <style>{`
        @keyframes glowPulse {
          0%,100% { filter: drop-shadow(0 0 16px rgba(0,245,196,0.5)) drop-shadow(0 0 4px rgba(57,255,154,0.3)); }
          50%      { filter: drop-shadow(0 0 48px rgba(0,245,196,1))   drop-shadow(0 0 20px rgba(57,255,154,0.8)) drop-shadow(0 0 80px rgba(0,229,255,0.4)); }
        }
        @keyframes floatY {
          0%,100% { transform: translateY(0);   }
          50%     { transform: translateY(-8px); }
        }
        @keyframes blink {
          0%,100% { opacity:0.4; } 50% { opacity:1; }
        }
        @keyframes particleUp {
          0%   { transform: translateY(0)    scale(1);   opacity:0.8; }
          100% { transform: translateY(-90px) scale(0);  opacity:0;   }
        }
        @keyframes barWave {
          0%,100% { transform: scaleY(0.25); }
          50%     { transform: scaleY(1);    }
        }
        @keyframes slideLineL {
          from { width: 0;    opacity:0; }
          10%  { opacity: 1; }
          to   { width: 46vw; opacity:0.6; }
        }
        @keyframes slideLineR {
          from { width: 0;    opacity:0; }
          10%  { opacity: 1; }
          to   { width: 46vw; opacity:0.6; }
        }
        @keyframes fadeUp {
          from { opacity:0; transform: translateY(14px); }
          to   { opacity:1; transform: translateY(0);    }
        }
        @keyframes letterSpacing {
          from { letter-spacing: 0.6em; opacity:0; }
          to   { letter-spacing: 0.3em; opacity:0.65; }
        }
        @keyframes progressFill {
          from { width: 0%; }
          to   { width: 100%; }
        }
      `}</style>

      {/* ── Master overlay ── */}
      <div style={{
        position: 'fixed', inset: 0, zIndex: 9999,
        background: '#020d14',
        overflow: 'hidden',
        transform: isExit ? 'translateY(-100%)' : 'translateY(0)',
        transition: isExit ? 'transform 0.75s cubic-bezier(0.76,0,0.24,1)' : 'none',
      }}>

        {/* Grid */}
        <div style={{
          position: 'absolute', inset: 0, pointerEvents: 'none',
          backgroundImage: `
            linear-gradient(rgba(0,245,196,0.045) 1px, transparent 1px),
            linear-gradient(90deg, rgba(0,245,196,0.045) 1px, transparent 1px)
          `,
          backgroundSize: '64px 64px',
          opacity: show('grid') ? 1 : 0,
          transition: 'opacity 1s ease',
        }} />

        {/* Outer glow orb */}
        <div style={{
          position: 'absolute',
          width: '900px', height: '900px',
          borderRadius: '50%',
          background: 'radial-gradient(circle, rgba(0,245,196,0.07) 0%, transparent 65%)',
          filter: 'blur(90px)',
          top: '50%', left: '50%',
          transform: 'translate(-50%,-50%)',
          opacity: show('mark-glow') ? 1 : 0,
          transition: 'opacity 1s',
          pointerEvents: 'none',
        }} />

        {/* Scanline */}
        {gte('scanline', phase) && !gte('wordmark', phase) && (
          <div style={{
            position: 'absolute', left: 0, right: 0,
            height: '2px', top: `${scanY}%`,
            background: 'linear-gradient(90deg, transparent, rgba(0,245,196,0.5) 50%, transparent)',
            pointerEvents: 'none', zIndex: 2,
          }} />
        )}

        {/* ── Structural frame box ── */}
        {/* Top-left corner */}
        <div style={{
          position: 'absolute', top: '12%', left: '6%',
          width: '48px', height: '48px',
          borderTop: '1px solid rgba(0,245,196,0.5)',
          borderLeft: '1px solid rgba(0,245,196,0.5)',
          opacity: show('frame') ? 1 : 0,
          transition: 'opacity 0.5s',
          animation: show('mark-glow') ? 'blink 2.5s ease-in-out infinite' : 'none',
        }} />
        {/* Top-right corner */}
        <div style={{
          position: 'absolute', top: '12%', right: '6%',
          width: '48px', height: '48px',
          borderTop: '1px solid rgba(0,245,196,0.5)',
          borderRight: '1px solid rgba(0,245,196,0.5)',
          opacity: show('frame') ? 1 : 0,
          transition: 'opacity 0.5s 0.1s',
          animation: show('mark-glow') ? 'blink 2.5s ease-in-out infinite 0.3s' : 'none',
        }} />
        {/* Bottom-left corner */}
        <div style={{
          position: 'absolute', bottom: '12%', left: '6%',
          width: '48px', height: '48px',
          borderBottom: '1px solid rgba(0,245,196,0.5)',
          borderLeft: '1px solid rgba(0,245,196,0.5)',
          opacity: show('frame') ? 1 : 0,
          transition: 'opacity 0.5s 0.2s',
          animation: show('mark-glow') ? 'blink 2.5s ease-in-out infinite 0.6s' : 'none',
        }} />
        {/* Bottom-right corner */}
        <div style={{
          position: 'absolute', bottom: '12%', right: '6%',
          width: '48px', height: '48px',
          borderBottom: '1px solid rgba(0,245,196,0.5)',
          borderRight: '1px solid rgba(0,245,196,0.5)',
          opacity: show('frame') ? 1 : 0,
          transition: 'opacity 0.5s 0.3s',
          animation: show('mark-glow') ? 'blink 2.5s ease-in-out infinite 0.9s' : 'none',
        }} />

        {/* ── Center horizontal rule above logo group ── */}
        <div style={{
          position: 'absolute',
          top: 'calc(50% - 130px)',
          left: '50%', transform: 'translateX(-50%)',
          width: show('frame') ? '280px' : '0px',
          height: '1px',
          background: 'linear-gradient(90deg, transparent, rgba(0,245,196,0.4), transparent)',
          transition: 'width 0.7s cubic-bezier(0.23,1,0.32,1)',
        }} />

        {/* ── Center horizontal rule below logo group ── */}
        <div style={{
          position: 'absolute',
          top: 'calc(50% + 130px)',
          left: '50%', transform: 'translateX(-50%)',
          width: show('wordmark') ? '420px' : '0px',
          height: '1px',
          background: 'linear-gradient(90deg, transparent, rgba(0,245,196,0.3), transparent)',
          transition: 'width 0.6s cubic-bezier(0.23,1,0.32,1)',
        }} />

        {/* ── Burst lines from center ── */}
        {/* Left */}
        <div style={{
          position: 'absolute',
          top: 'calc(50% - 1px)', right: '50%',
          height: '1px',
          background: 'linear-gradient(270deg, #00f5c4, transparent)',
          animation: gte('wordmark', phase) ? 'slideLineL 0.55s cubic-bezier(0.23,1,0.32,1) forwards' : 'none',
          width: 0,
        }} />
        {/* Right */}
        <div style={{
          position: 'absolute',
          top: 'calc(50% - 1px)', left: '50%',
          height: '1px',
          background: 'linear-gradient(90deg, #39ff9a, transparent)',
          animation: gte('wordmark', phase) ? 'slideLineR 0.55s cubic-bezier(0.23,1,0.32,1) forwards' : 'none',
          width: 0,
        }} />

        {/* ── Left side data panel ── */}
        <div style={{
          position: 'absolute', left: '6%', top: '50%',
          transform: 'translateY(-50%)',
          display: 'flex', flexDirection: 'column', gap: '12px',
          opacity: show('scanline') ? 1 : 0,
          transition: 'opacity 0.5s',
        }}>
          {/* Waveform */}
          <div style={{ display: 'flex', alignItems: 'center', gap: '3px', marginBottom: '8px' }}>
            {[10,18,8,26,14,22,9,30,12,20,7,16,24,11].map((h, i) => (
              <div key={i} style={{
                width: '2px', height: `${h}px`,
                background: `rgba(0,245,196,${0.3 + (i % 3) * 0.15})`,
                animation: `barWave ${0.35 + i * 0.06}s ease-in-out infinite ${i * 0.04}s`,
              }} />
            ))}
          </div>
          <div style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.55rem', letterSpacing: '0.15em', color: 'rgba(0,245,196,0.4)', lineHeight: 1.8 }}>
            <div>SYS_INIT</div>
            <div>BUILD // 2025</div>
            <div style={{ color: 'rgba(0,245,196,0.6)' }}>MA // IFRANE</div>
          </div>
        </div>

        {/* ── Right side counter panel ── */}
        <div style={{
          position: 'absolute', right: '6%', top: '50%',
          transform: 'translateY(-50%)',
          display: 'flex', flexDirection: 'column', alignItems: 'flex-end', gap: '10px',
          opacity: show('scanline') ? 1 : 0,
          transition: 'opacity 0.5s',
        }}>
          <div style={{
            fontFamily: 'var(--font-syne)',
            fontSize: '2.4rem', fontWeight: 800,
            background: 'linear-gradient(135deg,#00f5c4,#39ff9a)',
            WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent', backgroundClip: 'text',
            lineHeight: 1,
          }}>
            {String(counter).padStart(3, '0')}
          </div>
          <div style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.55rem', letterSpacing: '0.15em', color: 'rgba(0,245,196,0.4)', textAlign: 'right', lineHeight: 1.8 }}>
            <div>LOADING</div>
            <div>ASSETS</div>
            <div style={{ color: 'rgba(0,245,196,0.6)' }}>ABOULABS.MA</div>
          </div>
        </div>

        {/* ── Floating particles ── */}
        {show('mark-glow') && [
          { left:'48%', size:3, delay:'0s',   dur:'2.1s' },
          { left:'51%', size:2, delay:'0.5s', dur:'1.7s' },
          { left:'49%', size:4, delay:'0.9s', dur:'2.5s' },
          { left:'52%', size:2, delay:'1.3s', dur:'2.0s' },
          { left:'47%', size:3, delay:'0.2s', dur:'2.3s' },
        ].map((p, i) => (
          <div key={i} style={{
            position: 'absolute', bottom: '52%', left: p.left,
            width: `${p.size}px`, height: `${p.size}px`,
            borderRadius: '50%',
            background: '#00f5c4',
            boxShadow: `0 0 ${p.size * 3}px #00f5c4`,
            animation: `particleUp ${p.dur} ease-out ${p.delay} infinite`,
            pointerEvents: 'none',
          }} />
        ))}

        {/* ────────────────────────────────────────
            CENTRAL LOGO GROUP
        ──────────────────────────────────────── */}
        <div style={{
          position: 'absolute',
          top: '50%', left: '50%',
          transform: 'translate(-50%, -50%)',
          display: 'flex', flexDirection: 'column',
          alignItems: 'center',
          gap: '0',
        }}>

          {/* Mark — 120px, centered */}
          <div style={{
            width: '120px', height: '120px',
            position: 'relative',
            marginBottom: '28px',
            opacity: gte('mark-in', phase) && !isExit ? 1 : 0,
            transform: !gte('mark-in', phase)
              ? 'scale(0.2) rotate(-20deg)'
              : isExit ? 'scale(1.3)' : 'scale(1) rotate(0deg)',
            transition: 'opacity 0.6s ease, transform 0.7s cubic-bezier(0.34,1.4,0.64,1)',
            animation: show('mark-glow')
              ? 'floatY 3.5s ease-in-out infinite, glowPulse 2.2s ease-in-out infinite'
              : 'none',
          }}>
            <Image src="/logos/logo-mark.png" alt="" fill style={{ objectFit: 'contain' }} priority />
          </div>

          {/* Divider line between mark and wordmark */}
          <div style={{
            width: show('wordmark') ? '320px' : '0px',
            height: '1px',
            background: 'linear-gradient(90deg, transparent, rgba(0,245,196,0.35), transparent)',
            transition: 'width 0.5s cubic-bezier(0.23,1,0.32,1)',
            marginBottom: '24px',
          }} />

          {/* Wordmark — 320px wide */}
          <div style={{
            width: '320px', height: '39px',
            position: 'relative',
            opacity: show('wordmark') ? 1 : 0,
            transform: show('wordmark') ? 'translateY(0)' : 'translateY(20px)',
            transition: 'opacity 0.6s ease, transform 0.6s cubic-bezier(0.23,1,0.32,1)',
            filter: 'drop-shadow(0 0 12px rgba(0,245,196,0.25))',
            marginBottom: '16px',
          }}>
            <Image src="/logos/logo-full.png" alt="ABOULABS" fill style={{ objectFit: 'contain', objectPosition: 'center' }} priority />
          </div>

          {/* Tagline */}
          <div style={{
            fontFamily: 'var(--font-jetbrains)',
            fontSize: '0.62rem',
            color: 'rgba(0,245,196,0.65)',
            textTransform: 'uppercase',
            opacity: show('details') ? 1 : 0,
            animation: show('details') ? 'letterSpacing 0.8s ease forwards' : 'none',
          }}>
            Engineering Digital Futures
          </div>

          {/* Dot separator + year */}
          <div style={{
            display: 'flex', alignItems: 'center', gap: '10px',
            marginTop: '12px',
            opacity: show('details') ? 1 : 0,
            animation: show('details') ? 'fadeUp 0.6s ease 0.2s forwards' : 'none',
          }}>
            <span style={{ width: '4px', height: '4px', borderRadius: '50%', background: '#00f5c4', boxShadow: '0 0 6px #00f5c4', display: 'inline-block' }} />
            <span style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.55rem', letterSpacing: '0.2em', color: 'rgba(0,245,196,0.35)' }}>IFRANE · MOROCCO · 2025</span>
            <span style={{ width: '4px', height: '4px', borderRadius: '50%', background: '#39ff9a', boxShadow: '0 0 6px #39ff9a', display: 'inline-block' }} />
          </div>
        </div>

        {/* ── Bottom progress bar ── */}
        <div style={{
          position: 'absolute', bottom: 0, left: 0, right: 0,
          height: '2px', background: 'rgba(0,245,196,0.08)',
        }}>
          <div style={{
            height: '100%',
            background: 'linear-gradient(90deg,#00f5c4,#39ff9a,#00e5ff)',
            boxShadow: '0 0 12px rgba(0,245,196,0.7)',
            transition: 'width 0.35s ease',
            width:
              gte('hold', phase)      ? '100%' :
              gte('details', phase)   ? '90%'  :
              gte('wordmark', phase)  ? '75%'  :
              gte('scanline', phase)  ? `${counter}%` :
              gte('mark-glow', phase) ? '38%'  :
              gte('mark-in', phase)   ? '22%'  :
              gte('frame', phase)     ? '10%'  :
              gte('grid', phase)      ? '4%'   : '0%',
          }} />
        </div>

      </div>
    </>
  )
}
ENDOFFILE
echo "✅ PageIntro.tsx — redesigned with structure + bigger logos"
echo ""
echo "Changes:"
echo "  • Mark: 88px → 120px"
echo "  • Wordmark: 240px → 320px"
echo "  • Clean divider line between mark and wordmark"
echo "  • Top/bottom horizontal rules frame the logo group"
echo "  • Left panel: waveform + SYS_INIT labels"
echo "  • Right panel: large 3-digit counter + labels"
echo "  • Corner accents: 48px (larger, more visible)"
echo "  • Center burst lines on wordmark reveal"
echo "  • Tagline with letter-spacing animation"
echo "  • IFRANE · MOROCCO · 2025 detail line"
echo ""
echo "Run: npm run dev"
