class LineCredential < ActiveRecord::Base
  belongs_to :user

  validates :encrypted_line_user_id, uniqueness: true

  before_create :generate_associate_key!

  private

  def generate_associate_key!
    self.associate_key = SecureRandom.hex(16)
  end
end
