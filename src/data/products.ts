export type ProductType = 'web' | 'mobile'

export interface Product {
  id: string
  num: string
  icon: string
  name: string
  tagline: string
  description: string
  features: string[]
  type: ProductType
  logo?: string
  screenshot?: string
}

export const products: Product[] = [
  {
    id: 'pcs',
    num: '01',
    icon: '🚗',
    name: 'PCS',
    tagline: 'Premium Car Service',
    description: 'Full-spectrum ERP for garages and automotive businesses. Repair workflows, invoicing, and customer tracking unified in one intelligent platform.',
    features: ['Garage Management', 'Repair Workflow', 'Invoicing', 'Customer Tracking', 'Analytics'],
    type: 'web',
    logo: '/logos/pcs-logo.png',
  },
  {
    id: 'cabinet',
    num: '02',
    icon: '⚖️',
    name: 'Cabi.NET',
    tagline: 'Legal Practice Management',
    description: 'Modern management system built exclusively for Moroccan law offices. Cases, clients, and documents organized with precision.',
    features: ['Case Management', 'Client Profiles', 'Document Hub', 'Billing', 'Deadlines'],
    type: 'web',
    logo: '/logos/cabinet-logo.png',
  },
  {
    id: 'edupath',
    num: '03',
    icon: '📚',
    name: 'EduPath',
    tagline: 'LMS for Moroccan Schools',
    description: 'Learning management for private schools from primaire to lycée. Curriculum building, progress tracking, and parent engagement unified.',
    features: ['Curriculum Builder', 'Progress Tracking', 'Parent Portal', 'Assignments', 'Gradebook'],
    type: 'web',
    logo: '/logos/edupath-logo.png',
  },
  {
    id: 'maw9if',
    num: '04',
    icon: '📍',
    name: 'Maw9if',
    tagline: 'Craftsman Marketplace',
    description: 'Mobile-first marketplace connecting Moroccan craftsmen with customers. Browse professionals, book services, and discover authentic local craft.',
    features: ['Artisan Profiles', 'Service Booking', 'Reviews', 'Location-Based', 'Messaging'],
    type: 'mobile',
    logo: '/logos/maw9if-logo.png',
  },
]
