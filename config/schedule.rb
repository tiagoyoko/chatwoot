# Configuração de tarefas agendadas para depoimentos
# Use a gem 'whenever' para gerenciar cron jobs
# Execute: whenever --update-crontab para aplicar

# Define o ambiente
set :environment, ENV['RAILS_ENV'] || 'production'
set :output, "#{path}/log/cron.log"

# Lembrete semanal sobre depoimentos pendentes (toda segunda-feira às 9h)
every :monday, at: '9:00 am' do
  runner "TestimonialJob.send_pending_approval_reminder"
end

# Relatório mensal de depoimentos (primeiro dia do mês às 8h)
every '0 8 1 * *' do
  runner "Account.find_each { |account| TestimonialJob.generate_monthly_report(account.id) }"
end

# Limpeza de depoimentos antigos não aprovados (todo domingo às 2h)
every :sunday, at: '2:00 am' do
  runner "TestimonialJob.cleanup_old_unapproved_testimonials"
end

# Atualização de estatísticas de depoimentos (a cada 6 horas)
every 6.hours do
  runner "Account.find_each { |account| TestimonialJob.update_testimonial_stats(account.id) }"
end

# Solicitação de depoimentos para usuários satisfeitos (toda sexta-feira às 14h)
every :friday, at: '2:00 pm' do
  runner "Account.find_each { |account| TestimonialJob.request_testimonials_from_satisfied_users(account.id) }"
end

# Backup de depoimentos importantes (todo dia às 3h)
every 1.day, at: '3:00 am' do
  runner <<-RUBY
    # Exporta depoimentos aprovados para backup
    testimonials = Testimonial.published.includes(:approved_by)
    backup_data = testimonials.map(&:to_frontend_hash)
    
    backup_file = Rails.root.join('tmp', 'testimonials_backup.json')
    File.write(backup_file, JSON.pretty_generate(backup_data))
    
    Rails.logger.info "Backup de #{testimonials.count} depoimentos criado em #{backup_file}"
  RUBY
end

