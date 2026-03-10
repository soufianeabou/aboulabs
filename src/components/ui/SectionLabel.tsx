interface Props {
    text: string
    className?: string
  }
  
  export default function SectionLabel({ text, className = '' }: Props) {
    return (
      <div
        className={`section-label-line font-mono text-[0.65rem] tracking-[0.25em] uppercase mb-4 ${className}`}
        style={{ color: '#00f5c4' }}
      >
        {text}
      </div>
    )
  }