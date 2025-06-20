# Controller para API de depoimentos
class Api::V1::TestimonialsController < Api::V1::BaseController
  before_action :set_testimonial, only: [:show, :update, :destroy, :approve, :disapprove]
  before_action :check_authorization, except: [:index, :show, :public_index]
  
  # GET /api/v1/testimonials
  # Lista depoimentos (admin) ou depoimentos públicos
  def index
    if current_user&.administrator?
      @testimonials = filter_testimonials(Testimonial.all)
    else
      redirect_to action: :public_index
    end
  end
  
  # GET /api/v1/testimonials/public
  # Lista depoimentos públicos (aprovados e ativos)
  def public_index
    @testimonials = filter_testimonials(Testimonial.published)
    render json: {
      testimonials: @testimonials.map(&:to_frontend_hash),
      meta: {
        total: @testimonials.count,
        categories: Testimonial.published.distinct.pluck(:category).compact,
        industries: Testimonial.published.distinct.pluck(:industry).compact
      }
    }
  end
  
  # GET /api/v1/testimonials/featured
  # Depoimentos em destaque para homepage
  def featured
    @testimonials = Testimonial.featured(params[:limit]&.to_i || 5)
    render json: {
      testimonials: @testimonials.map(&:to_frontend_hash)
    }
  end
  
  # GET /api/v1/testimonials/random
  # Depoimentos aleatórios
  def random
    @testimonials = Testimonial.random(params[:limit]&.to_i || 5)
    render json: {
      testimonials: @testimonials.map(&:to_frontend_hash)
    }
  end
  
  # GET /api/v1/testimonials/by_category/:category
  # Depoimentos por categoria
  def by_category
    category = params[:category]
    limit = params[:limit]&.to_i || 10
    
    @testimonials = Testimonial.by_category_with_fallback(category, limit: limit)
    render json: {
      testimonials: @testimonials.map(&:to_frontend_hash),
      category: category,
      total: @testimonials.count
    }
  end
  
  # GET /api/v1/testimonials/:id
  def show
    if @testimonial.published? || current_user&.administrator?
      render json: { testimonial: @testimonial.to_frontend_hash }
    else
      render json: { error: 'Testimonial not found' }, status: :not_found
    end
  end
  
  # POST /api/v1/testimonials
  def create
    @testimonial = Testimonial.new(testimonial_params)
    @testimonial.source = 'manual'
    
    if @testimonial.save
      render json: { 
        testimonial: @testimonial.to_frontend_hash,
        message: 'Testimonial created successfully'
      }, status: :created
    else
      render json: { 
        errors: @testimonial.errors.full_messages 
      }, status: :unprocessable_entity
    end
  end
  
  # PATCH/PUT /api/v1/testimonials/:id
  def update
    if @testimonial.update(testimonial_params)
      render json: { 
        testimonial: @testimonial.to_frontend_hash,
        message: 'Testimonial updated successfully'
      }
    else
      render json: { 
        errors: @testimonial.errors.full_messages 
      }, status: :unprocessable_entity
    end
  end
  
  # DELETE /api/v1/testimonials/:id
  def destroy
    @testimonial.destroy
    render json: { message: 'Testimonial deleted successfully' }
  end
  
  # POST /api/v1/testimonials/:id/approve
  def approve
    @testimonial.approve!(current_user)
    render json: { 
      testimonial: @testimonial.to_frontend_hash,
      message: 'Testimonial approved successfully'
    }
  end
  
  # POST /api/v1/testimonials/:id/disapprove
  def disapprove
    @testimonial.disapprove!
    render json: { 
      testimonial: @testimonial.to_frontend_hash,
      message: 'Testimonial disapproved successfully'
    }
  end
  
  # POST /api/v1/testimonials/:id/toggle_active
  def toggle_active
    @testimonial.toggle_active!
    status = @testimonial.active? ? 'activated' : 'deactivated'
    render json: { 
      testimonial: @testimonial.to_frontend_hash,
      message: "Testimonial #{status} successfully"
    }
  end
  
  # POST /api/v1/testimonials/bulk_approve
  def bulk_approve
    ids = params[:testimonial_ids] || []
    testimonials = Testimonial.where(id: ids)
    
    testimonials.each { |t| t.approve!(current_user) }
    
    render json: { 
      message: "#{testimonials.count} testimonials approved successfully",
      count: testimonials.count
    }
  end
  
  # POST /api/v1/testimonials/submit
  # Endpoint público para submissão de depoimentos
  def submit
    @testimonial = Testimonial.new(public_testimonial_params)
    @testimonial.source = 'form'
    @testimonial.approved = false # Requer aprovação manual
    
    if verify_recaptcha(model: @testimonial) && @testimonial.save
      # Notifica administradores sobre novo depoimento
      TestimonialMailer.new_submission(@testimonial).deliver_later
      
      render json: { 
        message: 'Obrigado pelo seu depoimento! Ele será analisado e publicado em breve.',
        testimonial_id: @testimonial.id
      }, status: :created
    else
      render json: { 
        errors: @testimonial.errors.full_messages 
      }, status: :unprocessable_entity
    end
  end
  
  private
  
  def set_testimonial
    @testimonial = Testimonial.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Testimonial not found' }, status: :not_found
  end
  
  def check_authorization
    return if current_user&.administrator?
    
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
  
  def testimonial_params
    params.require(:testimonial).permit(
      :name, :position, :company, :text, :highlight_phrase,
      :avatar_url, :company_logo_url, :rating, :active,
      :display_order, :category, :industry, :company_size,
      :email, :linkedin_url, :company_website, :notes
    )
  end
  
  def public_testimonial_params
    params.require(:testimonial).permit(
      :name, :position, :company, :text, :rating,
      :email, :linkedin_url, :company_website, :category, :industry
    )
  end
  
  def filter_testimonials(scope)
    # Filtros de busca
    scope = scope.where('name ILIKE ? OR company ILIKE ? OR text ILIKE ?', 
                       "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present?
    
    scope = scope.by_category(params[:category]) if params[:category].present?
    scope = scope.by_industry(params[:industry]) if params[:industry].present?
    scope = scope.by_rating(params[:min_rating]) if params[:min_rating].present?
    scope = scope.where(approved: params[:approved]) if params[:approved].present?
    scope = scope.where(active: params[:active]) if params[:active].present?
    
    # Ordenação
    case params[:sort]
    when 'name'
      scope = scope.order(:name)
    when 'company'
      scope = scope.order(:company)
    when 'rating'
      scope = scope.order(rating: :desc)
    when 'created_at'
      scope = scope.order(created_at: :desc)
    else
      scope = scope.ordered
    end
    
    # Paginação
    limit = [params[:limit]&.to_i || 20, 100].min
    offset = params[:offset]&.to_i || 0
    
    scope.limit(limit).offset(offset)
  end
end

