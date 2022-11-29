class User < ApplicationRecord
  has_secure_password
  has_many :subscriptions, dependent: :destroy
  
  validates :email, uniqueness: { case_sensitive: false }, presence: true

  def create_stripe_reference
    response = Stripe::Customer.create(email: email)
    self.stripe_id = response.id
    self.save
  end

  def retrieve_stripe_reference
    Stripe::Customer.retrieve(stripe_id)
  end
end