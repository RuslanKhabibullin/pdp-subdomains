class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, request_keys: %i[subdomain]

  has_many :companies, foreign_key: :owner_id, dependent: :destroy
  belongs_to :company, optional: true

  validates :email, presence: true,
                    format: { with: Devise.email_regexp },
                    uniqueness: { scope: :company_id }
  validates :password, length: { in: Devise.password_length }, confirmation: true

  validates :first_name, :last_name, presence: true

  def self.find_for_authentication(warden_conditions)
    company = Company.find_by(subdomain: warden_conditions[:subdomain])
    find_by(email: warden_conditions[:email], company: company)
  end
end