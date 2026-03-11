'use client'

import { useState } from 'react'
import { useLang } from '@/lib/LanguageContext'

function InputField({ label, name, type = 'text', value, onChange }: { label: string; name: string; type?: string; value: string; onChange: (v: string) => void }) {
  const [focused, setFocused] = useState(false)
  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
      <label style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.65rem', letterSpacing: '0.15em', color: '#3d6070', textTransform: 'uppercase' }}>{label}</label>
      <input
        type={type}
        name={name}
        value={value}
        onChange={e => onChange(e.target.value)}
        onFocus={() => setFocused(true)}
        onBlur={() => setFocused(false)}
        style={{ background: 'rgba(0,245,196,0.03)', border: `1px solid ${focused ? 'rgba(0,245,196,0.5)' : 'rgba(0,245,196,0.15)'}`, color: '#e8f4f8', fontFamily: 'var(--font-inter)', fontSize: '0.9rem', padding: '12px 16px', outline: 'none', transition: 'border-color 0.3s', boxShadow: focused ? '0 0 0 3px rgba(0,245,196,0.06)' : 'none', width: '100%', boxSizing: 'border-box' }}
      />
    </div>
  )
}

function TextareaField({ label, name, value, onChange, placeholder }: { label: string; name: string; value: string; onChange: (v: string) => void; placeholder?: string }) {
  const [focused, setFocused] = useState(false)
  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: '8px' }}>
      <label style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.65rem', letterSpacing: '0.15em', color: '#3d6070', textTransform: 'uppercase' }}>{label}</label>
      <textarea
        name={name}
        value={value}
        placeholder={placeholder}
        onChange={e => onChange(e.target.value)}
        onFocus={() => setFocused(true)}
        onBlur={() => setFocused(false)}
        rows={4}
        style={{ background: 'rgba(0,245,196,0.03)', border: `1px solid ${focused ? 'rgba(0,245,196,0.5)' : 'rgba(0,245,196,0.15)'}`, color: '#e8f4f8', fontFamily: 'var(--font-inter)', fontSize: '0.9rem', padding: '12px 16px', outline: 'none', transition: 'border-color 0.3s', resize: 'vertical', boxShadow: focused ? '0 0 0 3px rgba(0,245,196,0.06)' : 'none', width: '100%', boxSizing: 'border-box' }}
      />
    </div>
  )
}

export default function CTA() {
  const { t } = useLang()
  const [form, setForm] = useState({ name: '', company: '', message: '' })
  const [submitted, setSubmitted] = useState(false)
  const [btnHovered, setBtnHovered] = useState(false)

  const handleSubmit = () => {
    if (!form.name || !form.message) return
    setSubmitted(true)
  }

  return (
    <section id="contact" style={{ padding: '140px 5%', position: 'relative', overflow: 'hidden' }}>
      <div style={{ position: 'absolute', width: '800px', height: '800px', borderRadius: '50%', background: 'radial-gradient(circle,rgba(0,245,196,0.06) 0%,transparent 70%)', top: '50%', left: '50%', transform: 'translate(-50%,-50%)', pointerEvents: 'none' }} />

      <div style={{ maxWidth: '700px', margin: '0 auto', position: 'relative' }}>
        {/* Headline */}
        <div style={{ textAlign: 'center', marginBottom: '56px' }}>
          <div style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.7rem', letterSpacing: '0.2em', color: '#00f5c4', textTransform: 'uppercase', marginBottom: '24px' }}>
            {t('// Ready to build?', '// Prêt à construire ?')}
          </div>
          <h2 style={{ fontFamily: 'var(--font-syne)', fontWeight: 800, fontSize: 'clamp(2.2rem,4vw,3.8rem)', lineHeight: 1.1, color: '#e8f4f8', marginBottom: '24px' }}>
            {t('Your Digital ', 'Votre ')}
            <span style={{ background: 'linear-gradient(135deg,#00f5c4,#39ff9a)', WebkitBackgroundClip: 'text', WebkitTextFillColor: 'transparent', backgroundClip: 'text' }}>
              {t('Transformation', 'Transformation Digitale')}
            </span>
            {t(' Starts Here.', ' Commence Ici.')}
          </h2>
          <p style={{ fontSize: '1rem', color: '#7ba3b8', lineHeight: 1.7 }}>
            {t(
              "Whether you're exploring a new product idea, need to digitalize your operations, or want to integrate our SaaS solutions — let's talk.",
              "Que vous explorez une nouvelle idée de produit, souhaitez digitaliser vos opérations, ou intégrer nos solutions SaaS — parlons-en."
            )}
          </p>
        </div>

        {/* Form */}
        {submitted ? (
          <div style={{ border: '1px solid rgba(0,245,196,0.35)', background: 'rgba(0,245,196,0.05)', padding: '40px', textAlign: 'center' }}>
            <div style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.7rem', letterSpacing: '0.15em', color: '#00f5c4', marginBottom: '12px', textTransform: 'uppercase' }}>
              {t('// Message Sent', '// Message Envoyé')}
            </div>
            <p style={{ color: '#7ba3b8', fontSize: '0.95rem', lineHeight: 1.7 }}>
              {t("Thank you! We'll be in touch very soon.", "Merci ! Nous vous répondrons très prochainement.")}
            </p>
          </div>
        ) : (
          <div style={{ display: 'flex', flexDirection: 'column', gap: '20px', border: '1px solid rgba(0,245,196,0.12)', background: 'rgba(0,245,196,0.02)', padding: '40px' }}>
            <InputField
              label={t('Full Name', 'Nom complet')}
              name="name"
              value={form.name}
              onChange={v => setForm(f => ({ ...f, name: v }))}
            />
            <InputField
              label={t('Company / Organization', 'Entreprise / Organisation')}
              name="company"
              value={form.company}
              onChange={v => setForm(f => ({ ...f, company: v }))}
            />
            <TextareaField
              label={t('What do you need?', 'De quoi avez-vous besoin ?')}
              name="message"
              value={form.message}
              onChange={v => setForm(f => ({ ...f, message: v }))}
              placeholder={t('Tell us about your project...', 'Parlez-nous de votre projet...')}
            />
            <button
              onClick={handleSubmit}
              style={{ alignSelf: 'flex-start', fontFamily: 'var(--font-jetbrains)', fontSize: '0.8rem', letterSpacing: '0.1em', color: '#020d14', background: 'linear-gradient(135deg,#00f5c4,#39ff9a)', padding: '14px 36px', border: 'none', clipPath: 'polygon(10px 0%,100% 0%,calc(100% - 10px) 100%,0% 100%)', fontWeight: 600, cursor: 'none', transition: 'all 0.3s', boxShadow: btnHovered ? '0 0 24px rgba(0,245,196,0.4)' : 'none' }}
              onMouseEnter={() => setBtnHovered(true)}
              onMouseLeave={() => setBtnHovered(false)}
            >
              {t('Send Message', 'Envoyer')}
            </button>
          </div>
        )}

        {/* Secondary email link */}
        <div style={{ textAlign: 'center', marginTop: '28px' }}>
          <span style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.7rem', color: '#3d6070', letterSpacing: '0.08em' }}>
            {t('or email us directly at ', 'ou écrivez-nous à ')}
          </span>
          <a href="mailto:contact@aboulabs.com" style={{ fontFamily: 'var(--font-jetbrains)', fontSize: '0.7rem', color: '#00f5c4', textDecoration: 'none', letterSpacing: '0.08em' }}>
            contact@aboulabs.com
          </a>
        </div>
      </div>
    </section>
  )
}
