class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"], request.env["omniauth.params"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.omniauth_data"] = params_setup(@user)
      redirect_to new_user_registration_url
    end
  end

  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"], request.env["omniauth.params"])
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Google") if is_navigational_format?
    else
      session["devise.omniauth_data"] = params_setup(@user)
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end

  def params_setup(user)
    {
      email: user.email,
      first_name: user.first_name,
      last_name: user.last_name
    }
  end
end
