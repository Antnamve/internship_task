class Token < ApplicationRecord
  belongs_to :student
  before_validation :generate_token, on: :create
  validates :token, presence: :true, uniqueness: true


  # encrypts :token, deterministic: true

  private

  def generate_token
    self.token = BCrypt::Password.create(SecureRandom.hex)
  end
end
