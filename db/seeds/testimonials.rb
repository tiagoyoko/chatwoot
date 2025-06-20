# Seeds para depoimentos de exemplo
# Execute com: rails db:seed ou rails runner "load Rails.root.join('db/seeds/testimonials.rb')"

puts "🌱 Criando depoimentos de exemplo..."

# Dados de exemplo para depoimentos
testimonials_data = [
  {
    name: 'Maria Silva',
    position: 'Gerente de Atendimento',
    company: 'TechCorp Brasil',
    text: 'O Chatwoot revolucionou nosso atendimento ao cliente. Conseguimos reduzir o tempo de resposta em 70% e aumentar significativamente a satisfação dos nossos clientes. A plataforma é intuitiva e poderosa.',
    highlight_phrase: 'reduzir o tempo de resposta em 70%',
    rating: 5,
    category: 'technology',
    industry: 'software',
    company_size: 'medium',
    email: 'maria.silva@techcorp.com.br',
    approved: true,
    active: true,
    display_order: 1,
    source: 'manual'
  },
  {
    name: 'João Santos',
    position: 'CEO',
    company: 'StartupXYZ',
    text: 'Implementamos o Chatwoot e em apenas 3 meses vimos um aumento de 150% na conversão de leads. A integração com múltiplos canais nos permitiu centralizar todo o atendimento de forma eficiente.',
    highlight_phrase: 'aumento de 150% na conversão',
    rating: 5,
    category: 'saas',
    industry: 'technology',
    company_size: 'startup',
    email: 'joao@startupxyz.com',
    approved: true,
    active: true,
    display_order: 2,
    source: 'form'
  },
  {
    name: 'Ana Costa',
    position: 'Diretora de Marketing',
    company: 'E-commerce Plus',
    text: 'A capacidade de acompanhar toda a jornada do cliente em tempo real é simplesmente fantástica. Nossa equipe ficou mais produtiva e os clientes mais satisfeitos com o atendimento personalizado.',
    highlight_phrase: 'jornada do cliente em tempo real',
    rating: 5,
    category: 'ecommerce',
    industry: 'retail',
    company_size: 'large',
    email: 'ana.costa@ecommerceplus.com',
    approved: true,
    active: true,
    display_order: 3,
    source: 'survey'
  },
  {
    name: 'Carlos Oliveira',
    position: 'Head de Customer Success',
    company: 'SaaS Solutions',
    text: 'O sistema de automação do Chatwoot nos ajudou a escalar o atendimento sem perder a qualidade. Conseguimos atender 300% mais clientes com a mesma equipe. Recomendo para qualquer empresa que busca excelência.',
    highlight_phrase: 'escalar o atendimento sem perder a qualidade',
    rating: 5,
    category: 'saas',
    industry: 'software',
    company_size: 'large',
    email: 'carlos@saassolutions.com',
    approved: true,
    active: true,
    display_order: 4,
    source: 'email'
  },
  {
    name: 'Fernanda Lima',
    position: 'Coordenadora de Suporte',
    company: 'Digital Agency',
    text: 'Com o Chatwoot, conseguimos organizar melhor nossos tickets e ter uma visão completa do histórico de cada cliente. A ferramenta é indispensável para quem quer profissionalizar o atendimento.',
    highlight_phrase: 'visão completa do histórico',
    rating: 5,
    category: 'other',
    industry: 'marketing',
    company_size: 'small',
    email: 'fernanda@digitalagency.com',
    approved: true,
    active: true,
    display_order: 5,
    source: 'form'
  },
  {
    name: 'Roberto Mendes',
    position: 'CTO',
    company: 'InnovaTech',
    text: 'A implementação foi surpreendentemente simples e o suporte técnico é excepcional. Em 2 semanas já estávamos operando com 100% da capacidade. A API é bem documentada e flexível.',
    highlight_phrase: 'implementação foi surpreendentemente simples',
    rating: 5,
    category: 'technology',
    industry: 'software',
    company_size: 'medium',
    email: 'roberto@innovatech.com',
    approved: true,
    active: true,
    display_order: 6,
    source: 'manual'
  },
  {
    name: 'Luciana Ferreira',
    position: 'Head de Customer Experience',
    company: 'RetailMax',
    text: 'O sistema de relatórios nos deu insights valiosos sobre o comportamento dos clientes. Conseguimos identificar gargalos e otimizar processos, resultando em 40% menos reclamações.',
    highlight_phrase: '40% menos reclamações',
    rating: 5,
    category: 'retail',
    industry: 'retail',
    company_size: 'large',
    email: 'luciana@retailmax.com',
    approved: true,
    active: true,
    display_order: 7,
    source: 'survey'
  },
  {
    name: 'Eduardo Santos',
    position: 'Diretor Comercial',
    company: 'FinanceHub',
    text: 'A integração com nosso CRM foi perfeita. Agora temos uma visão 360° do cliente e conseguimos personalizar cada interação. Nossa taxa de retenção aumentou 85% após a implementação.',
    highlight_phrase: 'taxa de retenção aumentou 85%',
    rating: 5,
    category: 'finance',
    industry: 'finance',
    company_size: 'large',
    email: 'eduardo@financehub.com',
    approved: true,
    active: true,
    display_order: 8,
    source: 'email'
  },
  {
    name: 'Patricia Alves',
    position: 'Gerente de E-commerce',
    company: 'Fashion Store',
    text: 'Durante a Black Friday, o Chatwoot nos ajudou a gerenciar mais de 10.000 conversas simultâneas sem perder nenhum cliente. O sistema de filas inteligentes foi fundamental.',
    highlight_phrase: '10.000 conversas simultâneas',
    rating: 5,
    category: 'ecommerce',
    industry: 'fashion',
    company_size: 'large',
    email: 'patricia@fashionstore.com',
    approved: true,
    active: true,
    display_order: 9,
    source: 'form'
  },
  {
    name: 'Dr. Amanda Souza',
    position: 'Diretora Médica',
    company: 'Clínica Vida',
    text: 'O agendamento online via chat reduziu em 80% as ligações telefônicas. Nossos pacientes adoraram a praticidade e agilidade no atendimento. A telemedicina ficou muito mais eficiente.',
    highlight_phrase: 'reduziu em 80% as ligações',
    rating: 5,
    category: 'healthcare',
    industry: 'healthcare',
    company_size: 'medium',
    email: 'amanda@clinicavida.com',
    approved: true,
    active: true,
    display_order: 10,
    source: 'manual'
  },
  # Alguns depoimentos não aprovados para demonstração
  {
    name: 'Pedro Rodrigues',
    position: 'Analista de TI',
    company: 'TechStart',
    text: 'Estamos testando o Chatwoot há algumas semanas e os resultados iniciais são promissores. A interface é bem intuitiva.',
    rating: 4,
    category: 'technology',
    industry: 'software',
    company_size: 'startup',
    email: 'pedro@techstart.com',
    approved: false,
    active: true,
    source: 'form'
  },
  {
    name: 'Carla Mendonça',
    position: 'Coordenadora de Vendas',
    company: 'VendaMais',
    text: 'O sistema tem potencial, mas ainda estamos nos adaptando às funcionalidades. Esperamos ver melhorias nos próximos meses.',
    rating: 3,
    category: 'other',
    industry: 'sales',
    company_size: 'small',
    email: 'carla@vendamais.com',
    approved: false,
    active: true,
    source: 'survey'
  }
]

# Cria os depoimentos
created_count = 0
skipped_count = 0

testimonials_data.each do |testimonial_attrs|
  # Verifica se já existe um depoimento com o mesmo nome e empresa
  existing = Testimonial.find_by(name: testimonial_attrs[:name], company: testimonial_attrs[:company])
  
  if existing
    puts "⏭️  Pulando depoimento existente: #{testimonial_attrs[:name]} - #{testimonial_attrs[:company]}"
    skipped_count += 1
    next
  end

  testimonial = Testimonial.create!(testimonial_attrs)
  
  # Define timestamps de aprovação para depoimentos aprovados
  if testimonial.approved?
    testimonial.update!(
      approved_at: rand(30.days).seconds.ago,
      approved_by: User.where(type: 'SuperAdmin').first
    )
  end
  
  puts "✅ Criado: #{testimonial.name} - #{testimonial.company} (#{testimonial.approved? ? 'Aprovado' : 'Pendente'})"
  created_count += 1
end

puts "\n📊 Resumo:"
puts "✅ #{created_count} depoimentos criados"
puts "⏭️  #{skipped_count} depoimentos pulados (já existiam)"
puts "📈 #{Testimonial.published.count} depoimentos publicados"
puts "⏳ #{Testimonial.where(approved: false, active: true).count} depoimentos aguardando aprovação"

# Estatísticas adicionais
if created_count > 0
  puts "\n📈 Estatísticas:"
  puts "⭐ Avaliação média: #{Testimonial.published.average(:rating)&.round(2)}"
  puts "🏢 Empresas representadas: #{Testimonial.published.distinct.count(:company)}"
  puts "📂 Categorias: #{Testimonial.published.distinct.pluck(:category).compact.join(', ')}"
  puts "🏭 Setores: #{Testimonial.published.distinct.pluck(:industry).compact.join(', ')}"
end

puts "\n🎉 Seeds de depoimentos concluídos!"

