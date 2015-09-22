class ApiKey < ActiveRecord::Base
  ACCESS_TOKEN_LENGTH = 32

  belongs_to :user

  def generate_access_token!
    self.access_token = SecureRandom.hex(ACCESS_TOKEN_LENGTH)
  end
end
