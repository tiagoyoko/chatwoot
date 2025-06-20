# Migration para criar tabela de depoimentos
# Execute com: rails generate migration CreateTestimonials
# Depois: rails db:migrate

class CreateTestimonials < ActiveRecord::Migration[7.0]
  def change
    create_table :testimonials do |t|
      # Informações básicas do depoimento
      t.string :name, null: false, limit: 100
      t.string :position, limit: 100
      t.string :company, limit: 100
      t.text :text, null: false
      t.string :highlight_phrase, limit: 200
      
      # URLs das imagens
      t.string :avatar_url, limit: 500
      t.string :company_logo_url, limit: 500
      
      # Avaliação (1-5 estrelas)
      t.integer :rating, limit: 1
      
      # Metadados
      t.boolean :active, default: true, null: false
      t.integer :display_order, default: 0
      t.string :category, limit: 50
      t.string :industry, limit: 50
      t.string :company_size, limit: 20
      
      # Informações de contato (opcionais)
      t.string :email, limit: 100
      t.string :linkedin_url, limit: 200
      t.string :company_website, limit: 200
      
      # Dados de aprovação
      t.boolean :approved, default: false, null: false
      t.datetime :approved_at
      t.references :approved_by, foreign_key: { to_table: :users }, null: true
      
      # Dados de origem
      t.string :source, limit: 50 # 'manual', 'form', 'import', etc.
      t.text :notes # Notas internas
      
      # Timestamps
      t.timestamps
      
      # Índices
      t.index :active
      t.index :approved
      t.index :category
      t.index :industry
      t.index :display_order
      t.index [:active, :approved, :display_order], name: 'index_testimonials_for_display'
    end
    
    # Adiciona constraints
    add_check_constraint :testimonials, 'rating >= 1 AND rating <= 5', name: 'rating_range'
    add_check_constraint :testimonials, 'length(name) >= 2', name: 'name_min_length'
    add_check_constraint :testimonials, 'length(text) >= 10', name: 'text_min_length'
  end
end

