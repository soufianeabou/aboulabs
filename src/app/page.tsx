import PageIntro       from '@/components/ui/PageIntro'
import Cursor          from '@/components/ui/Cursor'
import WhatsAppButton  from '@/components/ui/WhatsAppButton'
import Navbar          from '@/components/layout/Navbar'
import Footer          from '@/components/layout/Footer'
import Hero            from '@/components/sections/Hero'
import Ticker          from '@/components/sections/Ticker'
import About           from '@/components/sections/About'
import Founder         from '@/components/sections/Founder'
import Products        from '@/components/sections/Products'
import Services        from '@/components/sections/Services'
import Process         from '@/components/sections/Process'
import CTA             from '@/components/sections/CTA'

export default function Home() {
  return (
    <>
      <PageIntro />
      <Cursor />
      <WhatsAppButton />
      <Navbar />
      <main>
        <Hero />
        <Ticker />
        <About />
        <Founder />
        <Products />
        <Services />
        <Process />
        <CTA />
      </main>
      <Footer />
    </>
  )
}
