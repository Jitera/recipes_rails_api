class User < ApplicationRecord
  include ConstantValidatable

  devise :database_authenticatable, :registerable, :rememberable, :validatable,
         :trackable, :recoverable
  devise :timeoutable

  # jitera-anchor-dont-touch: relations

  has_many :recipes, dependent: :destroy

  has_many :ingredients, through: :recipes

  # jitera-anchor-dont-touch: enum

  # jitera-anchor-dont-touch: file

  # jitera-anchor-dont-touch: validation

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP },
                    length: { maximum: 255, minimum: 0, message: I18n.t('.out_of_range_error') }, presence: true, uniqueness: true

  accepts_nested_attributes_for :recipes

  def self.associations
    [:recipes]
  end

  # jitera-anchor-dont-touch: reset_password
  def generate_reset_password_token
    raw, enc = Devise.token_generator.generate(self.class, :reset_password_token)

    self.reset_password_token   = enc
    self.reset_password_sent_at = Time.now.utc
    save(validate: false)
    raw
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope)
  end

  class << self
    def timeout_in
      1.hours
    end

    def password_length
      6..128
    end

    def reset_password_within
      1.hours
    end
  end
end
