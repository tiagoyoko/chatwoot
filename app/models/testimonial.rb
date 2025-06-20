# Modelo para gerenciar depoimentos de clientes
class Testimonial < ApplicationRecord
  # Associações
  belongs_to :approved_by, class_name: 'User', optional: true
  
  # Validações
  validates :name, presence: true, length: { minimum: 2, maximum: 100 }
  validates :text, presence: true, length: { minimum: 10, maximum: 1000 }
  validates :position, length: { maximum: 100 }, allow_blank: true
  validates :company, length: { maximum: 100 }, allow_blank: true
  validates :highlight_phrase, length: { maximum: 200 }, allow_blank: true
  validates :rating, inclusion: { in: 1..5 }, allow_nil: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :avatar_url, :company_logo_url, :linkedin_url, :company_website,
            format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]) }, 
            allow_blank: true
  validates :category, inclusion: { 
    in: %w[ecommerce saas healthcare education finance technology retail other] 
  }, allow_blank: true
  validates :company_size, inclusion: { 
    in: %w[startup small medium large enterprise] 
  }, allow_blank: true
  validates :source, inclusion: { 
    in: %w[manual form import survey email social] 
  }, allow_blank: true
  
  # Scopes
  scope :active, -> { where(active: true) }
  scope :approved, -> { where(approved: true) }
  scope :published, -> { active.approved }
  scope :by_category, ->(category) { where(category: category) }
  scope :by_industry, ->(industry) { where(industry: industry) }
  scope :by_rating, ->(min_rating) { where('rating >= ?', min_rating) }
  scope :ordered, -> { order(:display_order, :created_at) }
  scope :recent, -> { order(created_at: :desc) }
  scope :with_rating, -> { where.not(rating: nil) }
  scope :with_company, -> { where.not(company: [nil, '']) }
  scope :with_avatar, -> { where.not(avatar_url: [nil, '']) }
  scope :with_logo, -> { where.not(company_logo_url: [nil, '']) }
  
  # Callbacks
  before_save :sanitize_urls
  before_save :extract_highlight_phrase, if: :text_changed?
  after_update :update_approved_timestamp, if: :saved_change_to_approved?
  
  # Métodos de classe
  def self.for_display(limit: 10)
    published.ordered.limit(limit)
  end
  
  def self.random(limit: 5)
    published.order('RANDOM()').limit(limit)
  end
  
  def self.by_category_with_fallback(category, limit: 5)
    testimonials = by_category(category).published.ordered.limit(limit)
    if testimonials.count < limit
      remaining = limit - testimonials.count
      fallback = published.where.not(id: testimonials.ids).ordered.limit(remaining)
      testimonials + fallback
    else
      testimonials
    end
  end
  
  def self.featured(limit: 3)
    published.where('rating >= ?', 4).with_company.ordered.limit(limit)
  end
  
  # Métodos de instância
  def approve!(user = nil)
    update!(
      approved: true,
      approved_at: Time.current,
      approved_by: user
    )
  end
  
  def disapprove!
    update!(
      approved: false,
      approved_at: nil,
      approved_by: nil
    )
  end
  
  def toggle_active!
    update!(active: !active)
  end
  
  def has_avatar?
    avatar_url.present?
  end
  
  def has_company_logo?
    company_logo_url.present?
  end
  
  def has_rating?
    rating.present?
  end
  
  def full_name_with_company
    parts = [name]
    parts << position if position.present?
    parts << "at #{company}" if company.present?
    parts.join(', ')
  end
  
  def to_frontend_hash
    {
      id: id,
      name: name,
      position: position,
      company: company,
      text: text,
      highlightPhrase: highlight_phrase,
      avatar: avatar_url,
      companyLogo: company_logo_url,
      rating: rating,
      category: category,
      industry: industry,
      companySize: company_size
    }.compact
  end
  
  def excerpt(length: 100)
    return text if text.length <= length
    
    "#{text[0...length].strip}..."
  end
  
  def highlighted_text
    return text unless highlight_phrase.present?
    
    text.gsub(
      /#{Regexp.escape(highlight_phrase)}/i,
      "<mark class=\"highlight\">\\0</mark>"
    ).html_safe
  end
  
  private
  
  def sanitize_urls
    %w[avatar_url company_logo_url linkedin_url company_website].each do |url_field|
      url = send(url_field)
      next if url.blank?
      
      # Adiciona protocolo se não tiver
      unless url.match?(/\Ahttps?:\/\//)
        send("#{url_field}=", "https://#{url}")
      end
    end
  end
  
  def extract_highlight_phrase
    return if highlight_phrase.present?
    
    # Tenta extrair frases com números/percentuais como destaque automático
    phrases = text.scan(/\b\d+%[^.!?]*|[^.!?]*\d+[^.!?]*(?:aumento|redução|melhoria|crescimento)[^.!?]*/)
    self.highlight_phrase = phrases.first&.strip if phrases.any?
  end
  
  def update_approved_timestamp
    if approved?
      self.approved_at = Time.current if approved_at.nil?
    else
      self.approved_at = nil
      self.approved_by = nil
    end
  end
end

