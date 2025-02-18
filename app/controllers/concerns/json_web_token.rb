require 'jwt'

module JsonWebToken
  extend ActiveSupport::Concern
  SECRET_KEY = Rails.application.secret_key_base

  def create_token(user_id, username, role)
    payload = {
      user_id: user_id,
      username: username,
      role: role,
      exp: 24.hours.from_now.to_i
    }
    JWT.encode(payload, SECRET_KEY)
  end

  def decode_token(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  rescue
    nil
  end
end
