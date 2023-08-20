module JwtHelper
  def self.encode(user_id)
    payload = { user_id: user_id, exp: (Time.now + ENV['JWT_EXPIRY'].to_i.minutes).to_i }
    secret = Rails.application.credentials.secret_key_base
    JWT.encode payload, secret, 'HS256'
  end

  def self.decode(token)
    secret = Rails.application.credentials.secret_key_base
    Rails.logger.debug ENV['JWT_EXPIRY']


    JWT.decode(token, secret, true, { algorithm: 'HS256' })[0]
  rescue JWT::DecodeError => e
    Rails.logger.error "JWT decode error: #{e.message}"
    nil
  end
end
