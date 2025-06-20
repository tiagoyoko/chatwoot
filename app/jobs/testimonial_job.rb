# Job para processar tarefas relacionadas aos depoimentos
class TestimonialJob < ApplicationJob
  queue_as :default

  # Envia notificação de aprovação para o autor do depoimento
  def self.send_approval_notification(testimonial_id)
    perform_later('send_approval_notification', testimonial_id)
  end

  # Solicita depoimentos para usuários satisfeitos
  def self.request_testimonials_from_satisfied_users(account_id)
    perform_later('request_testimonials_from_satisfied_users', account_id)
  end

  # Envia lembrete sobre depoimentos pendentes
  def self.send_pending_approval_reminder
    perform_later('send_pending_approval_reminder')
  end

  # Gera relatório mensal de depoimentos
  def self.generate_monthly_report(account_id, month = nil, year = nil)
    month ||= Date.current.month
    year ||= Date.current.year
    perform_later('generate_monthly_report', account_id, month, year)
  end

  # Limpa depoimentos antigos não aprovados
  def self.cleanup_old_unapproved_testimonials
    perform_later('cleanup_old_unapproved_testimonials')
  end

  # Atualiza estatísticas de depoimentos
  def self.update_testimonial_stats(account_id)
    perform_later('update_testimonial_stats', account_id)
  end

  def perform(action, *args)
    case action
    when 'send_approval_notification'
      send_approval_notification(args[0])
    when 'request_testimonials_from_satisfied_users'
      request_testimonials_from_satisfied_users(args[0])
    when 'send_pending_approval_reminder'
      send_pending_approval_reminder
    when 'generate_monthly_report'
      generate_monthly_report(args[0], args[1], args[2])
    when 'cleanup_old_unapproved_testimonials'
      cleanup_old_unapproved_testimonials
    when 'update_testimonial_stats'
      update_testimonial_stats(args[0])
    else
      raise ArgumentError, "Unknown action: #{action}"
    end
  end

  private

  def send_approval_notification(testimonial_id)
    testimonial = Testimonial.find_by(id: testimonial_id)
    return unless testimonial&.approved?

    TestimonialMailer.approved_notification(testimonial).deliver_now
    Rails.logger.info "Approval notification sent for testimonial #{testimonial_id}"
  rescue StandardError => e
    Rails.logger.error "Failed to send approval notification for testimonial #{testimonial_id}: #{e.message}"
    raise e
  end

  def request_testimonials_from_satisfied_users(account_id)
    account = Account.find_by(id: account_id)
    return unless account

    # Busca usuários com alta satisfação (CSAT >= 4) nos últimos 30 dias
    satisfied_contacts = account.contacts
                               .joins(:csat_survey_responses)
                               .where(csat_survey_responses: { 
                                 rating: 4..5, 
                                 created_at: 30.days.ago..Time.current 
                               })
                               .where.not(email: [nil, ''])
                               .distinct
                               .limit(50) # Limita para não sobrecarregar

    satisfied_contacts.find_each do |contact|
      next unless contact.email.present?

      # Verifica se já foi solicitado depoimento recentemente
      next if testimonial_request_sent_recently?(contact.email)

      TestimonialMailer.request_testimonial(contact, account).deliver_now
      
      # Registra que foi enviado (usando cache ou tabela auxiliar)
      Rails.cache.write("testimonial_request_sent_#{contact.email}", true, expires_in: 90.days)
      
      Rails.logger.info "Testimonial request sent to #{contact.email}"
      
      # Pequena pausa para não sobrecarregar o servidor de email
      sleep(0.5)
    end

    Rails.logger.info "Testimonial requests sent to #{satisfied_contacts.count} satisfied users for account #{account_id}"
  rescue StandardError => e
    Rails.logger.error "Failed to request testimonials for account #{account_id}: #{e.message}"
    raise e
  end

  def send_pending_approval_reminder
    return if Testimonial.where(approved: false, active: true).count.zero?

    TestimonialMailer.pending_approval_reminder.deliver_now
    Rails.logger.info "Pending approval reminder sent"
  rescue StandardError => e
    Rails.logger.error "Failed to send pending approval reminder: #{e.message}"
    raise e
  end

  def generate_monthly_report(account_id, month, year)
    account = Account.find_by(id: account_id)
    return unless account

    TestimonialMailer.monthly_report(account, month, year).deliver_now
    Rails.logger.info "Monthly testimonial report generated for account #{account_id} - #{month}/#{year}"
  rescue StandardError => e
    Rails.logger.error "Failed to generate monthly report for account #{account_id}: #{e.message}"
    raise e
  end

  def cleanup_old_unapproved_testimonials
    # Remove depoimentos não aprovados com mais de 6 meses
    cutoff_date = 6.months.ago
    old_testimonials = Testimonial.where(approved: false, created_at: ...cutoff_date)
    
    count = old_testimonials.count
    old_testimonials.destroy_all
    
    Rails.logger.info "Cleaned up #{count} old unapproved testimonials"
  rescue StandardError => e
    Rails.logger.error "Failed to cleanup old testimonials: #{e.message}"
    raise e
  end

  def update_testimonial_stats(account_id)
    account = Account.find_by(id: account_id)
    return unless account

    # Atualiza estatísticas em cache para dashboard
    stats = {
      total_testimonials: Testimonial.published.count,
      pending_approval: Testimonial.where(approved: false, active: true).count,
      average_rating: Testimonial.published.average(:rating)&.round(2),
      monthly_submissions: Testimonial.where(created_at: 1.month.ago..Time.current).count,
      top_categories: Testimonial.published
                                .group(:category)
                                .count
                                .sort_by { |_, count| -count }
                                .first(5)
                                .to_h,
      recent_testimonials: Testimonial.published
                                     .recent
                                     .limit(5)
                                     .pluck(:id, :name, :company, :rating, :created_at)
    }

    Rails.cache.write("testimonial_stats_#{account_id}", stats, expires_in: 1.hour)
    Rails.logger.info "Testimonial stats updated for account #{account_id}"
  rescue StandardError => e
    Rails.logger.error "Failed to update testimonial stats for account #{account_id}: #{e.message}"
    raise e
  end

  def testimonial_request_sent_recently?(email)
    Rails.cache.exist?("testimonial_request_sent_#{email}")
  end
end

