class User < ActiveRecord::Base
  has_many :gifts

  has_secure_password

end
