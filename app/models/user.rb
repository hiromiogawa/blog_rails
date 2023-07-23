class User < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates :password, presence: true, length: { minimum: 8 }

  
  # トークンを発行するメソッド
  def generate_jwt
    JwtHelper.encode(self.id)
  end
  

end
