class ApiKey < ActiveRecord::Base
  ACCESS_TOKEN_LENGTH = 32

  belongs_to :user

  validates :access_token, presence: true, uniqueness: true
  validates :user, presence: true

  def generate_access_token!
    self.access_token = SecureRandom.hex(ACCESS_TOKEN_LENGTH/2)
  end

  def revoked?
    self.revoked_at.present?
  end

  def revoke!
    self.revoked_at = Time.now
    self.save!(validate: false)
  end
end
