class OmniauthController < ApplicationController
  def callback
    auth = request.env['omniauth.auth']

    if logged_in?
      if Registration.already_created?(auth)
        flash[:error] = 'A registration already exists with those credentials.'
      else
        current_user.registrations.create!(uid: auth['uid'], provider: auth['provider'])
        flash[:notice] = 'Added registration.'
      end

      redirect_to profile_path
    else
      user = User.find_or_create_from_omniauth(auth)
      session[:user_id] = user.id
      cookies.signed['remember_user_token'] = {
        :httponly => true,
        :value    => user.to_cookie,
        :expires  => user.remember_token_expires_at,
      }
      redirect_to root_path
    end
  end
end
