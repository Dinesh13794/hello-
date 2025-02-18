class Api::Auth::AuthController < ApplicationController
  include JsonWebToken

  def register
    user = User.new(user_params)
    if user.save
      token = create_token(user.id.to_s, user.username, user.role)
      user.update(token: token)
      render json: { msg: 'User registered', token: token, user: user.as_json({ except: [:password_digest] }) }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      token = create_token(user.id.to_s, user.username, user.role)
      user.update(token: token)
      render json: { msg: 'Success Login', token: token, user: user.as_json({ except: [:password_digest] }) }, status: :ok
    else
      render json: { msg: 'Invalid credentials' }, status: :unauthorized
    end
  end

  def logout
    user = User.where(token: request.headers['Authorization'].split(' ').last)
    if user
      user.update(token: nil)
      render json: { msg: 'Logged out successfully' }, status: :ok
    else
      render json: { msg: 'Invalid token' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:username, :password, :role)
  end
end
