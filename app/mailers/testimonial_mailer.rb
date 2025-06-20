# Mailer para notificações relacionadas a depoimentos
class TestimonialMailer < ApplicationMailer
  default from: ENV.fetch('MAILER_SENDER_EMAIL', 'notifications@chatwoot.com')

  # Notifica administradores sobre novo depoimento submetido
  def new_submission(testimonial)
    @testimonial = testimonial
    @admin_emails = User.where(type: 'SuperAdmin').pluck(:email)
    
    return if @admin_emails.empty?
    
    mail(
      to: @admin_emails,
      subject: "Novo depoimento submetido: #{@testimonial.name}",
      template_name: 'new_submission'
    )
  end

  # Notifica o autor quando depoimento é aprovado
  def approved_notification(testimonial)
    @testimonial = testimonial
    
    return unless @testimonial.email.present?
    
    mail(
      to: @testimonial.email,
      subject: 'Seu depoimento foi aprovado!',
      template_name: 'approved_notification'
    )
  end

  # Solicita depoimento para clientes satisfeitos
  def request_testimonial(user, account = nil)
    @user = user
    @account = account
    @testimonial_url = "#{ENV.fetch('FRONTEND_URL', 'https://app.chatwoot.com')}/testimonials/submit"
    
    mail(
      to: @user.email,
      subject: 'Compartilhe sua experiência com o Chatwoot',
      template_name: 'request_testimonial'
    )
  end

  # Lembrete para administradores sobre depoimentos pendentes
  def pending_approval_reminder
    @pending_count = Testimonial.where(approved: false, active: true).count
    @admin_emails = User.where(type: 'SuperAdmin').pluck(:email)
    
    return if @pending_count.zero? || @admin_emails.empty?
    
    @dashboard_url = "#{ENV.fetch('FRONTEND_URL', 'https://app.chatwoot.com')}/app/accounts/#{Current.account&.id}/settings/testimonials"
    
    mail(
      to: @admin_emails,
      subject: "#{@pending_count} depoimentos aguardando aprovação",
      template_name: 'pending_approval_reminder'
    )
  end

  # Relatório mensal de depoimentos
  def monthly_report(account, month = Date.current.month, year = Date.current.year)
    @account = account
    @month = month
    @year = year
    @date_range = Date.new(year, month, 1)..Date.new(year, month, -1)
    
    @stats = {
      total_submitted: Testimonial.where(created_at: @date_range).count,
      total_approved: Testimonial.where(approved_at: @date_range).count,
      total_published: Testimonial.published.where(created_at: @date_range).count,
      average_rating: Testimonial.where(created_at: @date_range).average(:rating)&.round(1),
      top_categories: Testimonial.where(created_at: @date_range)
                                .group(:category)
                                .count
                                .sort_by { |_, count| -count }
                                .first(5)
    }
    
    @admin_emails = User.where(type: 'SuperAdmin').pluck(:email)
    
    return if @admin_emails.empty?
    
    mail(
      to: @admin_emails,
      subject: "Relatório mensal de depoimentos - #{Date::MONTHNAMES[month]} #{year}",
      template_name: 'monthly_report'
    )
  end
end

