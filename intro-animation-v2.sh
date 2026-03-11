#!/bin/bash

cat > src/components/ui/PageIntro.tsx << 'ENDOFFILE'
'use client'

import { useEffect, useState } from 'react'
import Image from 'next/image'

type Phase =
  | 'blank'        // 0ms     — pure black
  | 'grid'         // 300ms   — grid fades in
  | 'orb'          // 700ms   — radial glow pulses in
  | 'mark-in'      // 1100ms  — mark scales in from 0
  | 'mark-glow'    // 1700ms  — mark intensifies, corner accents appear
  | 'scanline'     // 2300ms  — scanline sweeps, counter ticks
  | 'lines'        // 3000ms  — horizontal lines burst outward
  | 'wordmark'     // 3300ms  — wordmark slides up, tagline appears
  | 'hold'         // 3900ms  — everything holds for a beat
  | 'exit'         // 4400ms  — overlay slides up off screen
  | 'done'         // 5100ms  — unmount

const PHASES: { phase: Phase; delay: number }[] = [
  { phase: 'blank',     delay: 0    },
  { phase: 'grid',      delay: 300  },
  { phase: 'orb',       delay: 700  },
  { phase: 'mark-in',   delay: 1100 },
  { phase: 'mark-glow', delay: 1700 },
  { phase: 'scanline',  delay: 2300 },
  { phase: 'lines',     delay: 3000 },
  { phase: 'wordmark',  delay: 3300 },
  { phase: 'hold',      delay: 3900 },
  { phase: 'exit',      delay: 4400 },
  { phase: 'done',      delay: 5100 },
]

function after(phase: Phase, current: Phase): boolean {
  const order = PHASES.map(p => p.phase)
  return order.indexOf(current) >= order.indexOf(phase)
}

export default function PageIntro() {
  const [phase, setPhase] = useState<Phase>('blank')
  const [counter, setCounter] = useState(0)
  const [scanPos, setScanPos] = useState(-20)

  useEffect(() => {
    const timers = PHASES.map(({ phase, delay }) =>
      setTimeout(() => setPhase(phase), delay)
    )
    return () => timers.forEach(clearTimeout)
  }, [])

  // Counter tick during scanline phase
  useEffect(() => {
    if (phase !== 'scanline') return
    let val = 0
    const iv = setInterval(() => {
      val += Math.floor(Math.random() * 7) + 3
      if (val >= 100) { val = 100; clearInterval(iv) }
      setCounter(val)
    }, 40)
    return () => clearInterval(iv)
  }, [phase])

  // Scanline position
  useEffect(() => {
    if (!after('scanline', phase) || after('lines', phase)) return
    let pos = -20
    const iv = setInterval(() => {
      pos += 1.5
      if (pos > 120) pos = -20
      setScanPos(pos)
    }, 16)
    return () => clearInterval(iv)
  }, [phase])

  if (phase === 'done') return null

  const isExit = phase === 'exit'

  return (
    <>
      <style>{`
        @keyframes orbPulse {
          0%, 100% { transform: translate(-50%, -50%) scale(1);   opacity: 0.12; }
          50%       { transform: translate(-50%, -50%) scale(1.15); opacity: 0.22; }
        }
        @keyframes orbPulse2 {
          0%, 100% { transform: translate(-50%, -50%) scale(1);   opacity: 0.06; }
          50%       { transform: translate(-50%, -50%) scale(1.2);  opacity: 0.14; }
        }
        @keyframes markFloat {
          0%, 100% { transform: translateY(0px);  }
          50%       { transform: translateY(-6px); }
        }
        @keyframes glowPulse {
          0%, 100% { filter: drop-shadow(0 0 20px rgba(0,245,196,0.6)) drop-shadow(0 0 6px rgba(57,255,154,0.4)); }
          50%       { filter: drop-shadow(0 0 40px rgba(0,245,196,0.9)) drop-shadow(0 0 16px rgba(57,255,154,0.7)) drop-shadow(0 0 60px rgba(0,229,255,0.3)); }
        }
        @keyframes cornerBlink {
          0%, 100% { opacity: 0.5; }
          50%       { opacity: 1;   }
        }
        @keyframes taglineFade {
          0%   { opacity: 0; letter-spacing: 0.5em; }
          100% { opacity: 0.7; letter-spacing: 0.3em; }
        }
        @keyframes lineExpand {
          0%   { width: 0px; opacity: 0; }
          20%  { opacity: 1; }
          100% { width: 50vw; opacity: 0.5; }
        }
        @keyframes particleDrift {
          0%   { transform: translateY(0)   scale(1);   opacity: 0.6; }
          100% { transform: translateY(-80px) scale(0); opacity: 0;   }
        }
        @keyframes waveform {
          0%   { transform: scaleY(0.3); }
          50%  { transform: scaleY(1);   }
          100% { transform: scaleY(0.3); }
        }
      `}</style>

      {/* ── Overlay wrapper — slides up on exit ── */}
      <div style={{
        position: 'fixed', inset: 0, zIndex: 9999,
        background: '#020d14',
        display: 'flex', alignItems: 'center', justifyContent: 'center',
        flexDirection: 'column',
        overflow: 'hidden',
        transform: isExit ? 'translateY(-100%)' : 'translateY(0)',
        transition: isExit ? 'transform 0.7s cubic-bezier(0.76,0,0.24,1)' : 'none',
      }}>

        {/* ── Grid background ── */}
        <div style={{
          position: 'absolute', inset: 0, pointerEvents: 'none',
          backgroundImage: `
            linear-gradient(rgba(0,245,196,0.05) 1px, transparent 1px),
            linear-gradient(90deg, rgba(0,245,196,0.05) 1px, transparent 1px)
          `,
          backgroundSize: '60px 60px',
          opacity: after('grid', phase) && !isExit ? 1 : 0,
          transition: 'opacity 0.8s ease',
        }} />

        {/* ── Outer radial orb ── */}
        <div style={{
          position: 'absolute',
          width: '800px', height: '800px',
          borderRadius: '50%',
          background: 'radial-gradient(circle, rgba(0,245,196,0.1) 0%, transparent 70%)',
          filter: 'blur(80px)',
          top: '50%', left: '50%',
          opacity: after('orb', phase) && !isExit ? 1 : 0,
          transition: 'opacity 1s ease',
          animation: after('mark-glow', phase) ? 'orbPulse 2.5s ease-in-out infinite' : 'none',
          pointerEvents: 'none',
        }} />

        {/* ── Inner orb (tighter, brighter) ── */}
        <div style={{
          position: 'absolute',
          width: '300px', height: '300px',
          borderRadius: '50%',
          background: 'radial-gradient(circle, rgba(57,255,154,0.15) 0%, transparent 70%)',
          filter: 'blur(40px)',
          top: '50%', left: '50%',
          opacity: after('mark-glow', phase) && !isExit ? 1 : 0,
          transition: 'opacity 0.6s ease',
          animation: after('mark-glow', phase) ? 'orbPulse2 1.8s ease-in-out infinite 0.4s' : 'none',
          pointerEvents: 'none',
        }} />

        {/* ── Scanline sweep ── */}
        {after('scanline', phase) && !after('lines', phase) && (
          <div style={{
            position: 'absolute',
            left: 0, right: 0,
            height: '2px',
            top: `${scanPos}%`,
            background: 'linear-gradient(90deg, transparent 0%, rgba(0,245,196,0.6) 50%, transparent 100%)',
            pointerEvents: 'none',
            zIndex: 2,
          }} />
        )}

        {/* ── Floating particles ── */}
        {after('mark-glow', phase) && !isExit && [
          { left: '45%',  size: 3, delay: '0s',    dur: '2.2s' },
          { left: '52%',  size: 2, delay: '0.4s',  dur: '1.8s' },
          { left: '48%',  size: 4, delay: '0.8s',  dur: '2.6s' },
          { left: '50%',  size: 2, delay: '1.2s',  dur: '2s'   },
          { left: '46%',  size: 3, delay: '0.2s',  dur: '2.4s' },
          { left: '54%',  size: 2, delay: '1.6s',  dur: '1.9s' },
        ].map((p, i) => (
          <div key={i} style={{
            position: 'absolute',
            bottom: '46%',
            left: p.left,
            width: `${p.size}px`, height: `${p.size}px`,
            borderRadius: '50%',
            background: '#00f5c4',
            boxShadow: `0 0 ${p.size * 3}px #00f5c4`,
            animation: `particleDrift ${p.dur} ease-out ${p.delay} infinite`,
            pointerEvents: 'none',
          }} />
        ))}

        {/* ── Corner accents ── */}
        {[
          { top: '15%',  left: '8%',   borderTop: '1px solid rgba(0,245,196,0.5)',    borderLeft: '1px solid rgba(0,245,196,0.5)'    },
          { top: '15%',  right: '8%',  borderTop: '1px solid rgba(0,245,196,0.5)',    borderRight: '1px solid rgba(0,245,196,0.5)'   },
          { bottom:'15%',left: '8%',   borderBottom:'1px solid rgba(0,245,196,0.5)',  borderLeft: '1px solid rgba(0,245,196,0.5)'    },
          { bottom:'15%',right:'8%',   borderBottom:'1px solid rgba(0,245,196,0.5)',  borderRight:'1px solid rgba(0,245,196,0.5)'    },
        ].map((s, i) => (
          <div key={i} style={{
            position: 'absolute', width: '32px', height: '32px',
            opacity: after('mark-glow', phase) && !isExit ? 1 : 0,
            transition: 'opacity 0.4s',
            animation: after('mark-glow', phase) ? `cornerBlink 2s ease-in-out infinite ${i * 0.25}s` : 'none',
            ...s,
          }} />
        ))}

        {/* ── Horizontal teal lines that burst outward ── */}
        {/* Left lines */}
        <div style={{
          position: 'absolute', top: 'calc(50% - 56px)', right: '50%',
          height: '1px',
          background: 'linear-gradient(270deg, #00f5c4, transparent)',
          animation: after('lines', phase) ? 'lineExpand 0.6s cubic-bezier(0.23,1,0.32,1) forwards' : 'none',
          width: after('lines', phase) ? undefined : '0',
        }} />
        <div style={{
          position: 'absolute', top: 'calc(50% + 56px)', right: '50%',
          height: '1px',
          background: 'linear-gradient(270deg, #39ff9a, transparent)',
          animation: after('lines', phase) ? 'lineExpand 0.6s cubic-bezier(0.23,1,0.32,1) 0.05s forwards' : 'none',
          width: after('lines', phase) ? undefined : '0',
        }} />
        {/* Right lines */}
        <div style={{
          position: 'absolute', top: 'calc(50% - 56px)', left: '50%',
          height: '1px',
          background: 'linear-gradient(90deg, #00f5c4, transparent)',
          animation: after('lines', phase) ? 'lineExpand 0.6s cubic-bezier(0.23,1,0.32,1) forwards' : 'none',
          width: after('lines', phase) ? undefined : '0',
        }} />
        <div style={{
          position: 'absolute', top: 'calc(50% + 56px)', left: '50%',
          height: '1px',
          background: 'linear-gradient(90deg, #39ff9a, transparent)',
          animation: after('lines', phase) ? 'lineExpand 0.6s cubic-bezier(0.23,1,0.32,1) 0.05s forwards' : 'none',
          width: after('lines', phase) ? undefined : '0',
        }} />

        {/* ── Waveform bars — left side data viz ── */}
        {after('scanline', phase) && !isExit && (
          <div style={{
            position: 'absolute', left: '8%', top: '50%',
            transform: 'translateY(-50%)',
            display: 'flex', alignItems: 'center', gap: '3px',
            opacity: after('scanline', phase) && !after('lines', phase) ? 0.5 : 0,
            transition: 'opacity 0.4s',
          }}>
            {[12, 20, 8, 28, 16, 24, 10, 32, 14, 22, 9, 18].map((h, i) => (
              <div key={i} style={{
                width: '2px', height: `${h}px`,
                background: 'rgba(0,245,196,0.6)',
                animation: `waveform ${0.4 + i * 0.07}s ease-in-out infinite ${i * 0.05}s`,
              }} />
            ))}
          </div>
        )}

        {/* ── Counter / loading indicator ── */}
        {after('scanline', phase) && !after('lines', phase) && (
          <div style={{
            position: 'absolute', bottom: '18%', right: '10%',
            fontFamily: 'var(--font-jetbrains)',
            fontSize: '0.65rem', letterSpacing: '0.2em',
            color: 'rgba(0,245,196,0.6)',
          }}>
            {String(counter).padStart(3, '0')} / 100
          </div>
        )}

        {/* ── Status label ── */}
        {after('scanline', phase) && !after('lines', phase) && (
          <div style={{
            position: 'absolute', bottom: '18%', left: '10%',
            fontFamily: 'var(--font-jetbrains)',
            fontSize: '0.55rem', letterSpacing: '0.25em',
            color: 'rgba(0,245,196,0.4)',
            textTransform: 'uppercase',
          }}>
            // Initializing systems
          </div>
        )}

        {/* ── Central logo group ── */}
        <div style={{
          display: 'flex', flexDirection: 'column',
          alignItems: 'center', gap: '24px',
          position: 'relative', zIndex: 3,
        }}>

          {/* Mark */}
          <div style={{
            width: '88px', height: '88px',
            position: 'relative',
            opacity: after('mark-in', phase) && !isExit ? 1 : 0,
            transform: !after('mark-in', phase)
              ? 'scale(0.3) rotate(-15deg)'
              : isExit ? 'scale(1.2) rotate(0deg)' : 'scale(1) rotate(0deg)',
            transition: !after('mark-in', phase)
              ? 'opacity 0.6s ease, transform 0.6s cubic-bezier(0.34,1.56,0.64,1)'
              : isExit ? 'opacity 0.3s, transform 0.5s ease'
              : 'none',
            animation: after('mark-glow', phase) && !isExit
              ? 'markFloat 3s ease-in-out infinite, glowPulse 2s ease-in-out infinite'
              : after('mark-in', phase) && !isExit
              ? 'none'
              : 'none',
            filter: after('mark-in', phase) && !after('mark-glow', phase)
              ? 'drop-shadow(0 0 8px rgba(0,245,196,0.3))'
              : 'none',
          }}>
            <Image
              src="/logos/logo-mark.png"
              alt="ABOULABS"
              fill
              style={{ objectFit: 'contain' }}
              priority
            />
          </div>

          {/* Wordmark */}
          <div style={{
            width: '240px', height: '29px',
            position: 'relative',
            opacity: after('wordmark', phase) && !isExit ? 1 : 0,
            transform: after('wordmark', phase) && !isExit ? 'translateY(0)' : 'translateY(16px)',
            transition: 'opacity 0.5s ease, transform 0.5s cubic-bezier(0.23,1,0.32,1)',
            filter: 'drop-shadow(0 0 10px rgba(0,245,196,0.2))',
          }}>
            <Image
              src="/logos/logo-full.png"
              alt="ABOULABS"
              fill
              style={{ objectFit: 'contain', objectPosition: 'center' }}
              priority
            />
          </div>

          {/* Tagline */}
          <div style={{
            fontFamily: 'var(--font-jetbrains)',
            fontSize: '0.6rem',
            color: 'rgba(0,245,196,0.7)',
            textTransform: 'uppercase',
            opacity: after('wordmark', phase) && !isExit ? 1 : 0,
            animation: after('wordmark', phase) && !isExit ? 'taglineFade 0.8s ease forwards' : 'none',
          }}>
            Engineering Digital Futures
          </div>
        </div>

        {/* ── Bottom progress bar ── */}
        <div style={{
          position: 'absolute', bottom: 0, left: 0, right: 0,
          height: '2px',
          background: 'rgba(0,245,196,0.08)',
        }}>
          <div style={{
            height: '100%',
            background: 'linear-gradient(90deg, #00f5c4, #39ff9a)',
            width: after('hold', phase) ? '100%'
              : after('wordmark', phase) ? '85%'
              : after('lines', phase) ? '70%'
              : after('scanline', phase) ? `${counter}%`
              : after('mark-glow', phase) ? '35%'
              : after('mark-in', phase) ? '20%'
              : after('orb', phase) ? '8%'
              : '0%',
            transition: 'width 0.4s ease',
            boxShadow: '0 0 8px rgba(0,245,196,0.6)',
          }} />
        </div>

      </div>
    </>
  )
}
ENDOFFILE
echo "✅ PageIntro.tsx — full cinematic intro built"
echo ""
echo "Timeline:"
echo "  0.0s  blank — pure black"
echo "  0.3s  grid fades in"
echo "  0.7s  outer radial orb pulses in"
echo "  1.1s  mark scales in with spring + rotation"
echo "  1.7s  mark floats + glows, corner accents blink, particles rise"
echo "  2.3s  scanline sweeps, waveform animates, counter ticks 000→100"
echo "  3.0s  horizontal lines burst outward"
echo "  3.3s  wordmark slides up, tagline letter-spacing animates in"
echo "  3.9s  hold — everything pauses for one beat"
echo "  4.4s  overlay slides up off screen"
echo "  5.1s  component unmounts"
echo ""
echo "Run: npm run dev"
