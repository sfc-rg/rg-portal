class LdapCredential < ActiveRecord::Base
  belongs_to :user

  validates :uid, uniqueness: true
  validates :uid_number, uniqueness: true
  validates :student_id, uniqueness: true

  STUDENT_ID_PATTERN = /\d{8}/

  def self.import(args)
    user = args[:user]
    info = args[:info]
    self.new(
      user: user,
      uid: info[:uid],
      uid_number: info[:uidnumber],
      gid_number: info[:gidnumber],
      gecos: info[:gecos],
      student_id: info[:gecos].match(STUDENT_ID_PATTERN).to_s,
    )
  end
end
