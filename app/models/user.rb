class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic
  include ActiveModel::SecurePassword


  require 'bcrypt'

  

  
  field :username, type: String
  field :password_digest, type: String
  field :role, type: String 
  field :token, type: String

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :role, inclusion: { in: ['admin', 'user'] }

  has_secure_password


end
