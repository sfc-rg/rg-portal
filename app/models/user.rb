class User < ActiveRecord::Base
  has_one :slack_credential
end
