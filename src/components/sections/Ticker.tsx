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
