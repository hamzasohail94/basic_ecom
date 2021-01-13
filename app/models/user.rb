class User < ApplicationRecord
  has_many :orders
  has_many :products

  attr_accessor :password_confirmation

  before_create :update_password
  validates :email, presence: true
  validates :password, presence: true
  validate :confirm_password, if: :new_record?

  enum role: %w[Buyer Admin]

  def valid_password?(password)
    hmac = OpenSSL::HMAC.new('This is my secret', 'sha256')
    hmac << password
    ActiveSupport::SecurityUtils.secure_compare(
      hmac.hexdigest,
      self.password
    )
  end

  private

  def confirm_password
    errors.add(:password, "doesn't match with confirm password") if password_confirmation.present? && password != password_confirmation
  end

  def update_password
    hmac = OpenSSL::HMAC.new('This is my secret', 'sha256')
    hmac << password

    self.password = hmac.hexdigest
  end

end
