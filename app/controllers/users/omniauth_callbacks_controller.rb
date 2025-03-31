class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # THIS WILL THROW ERROR WHEN YOU LOGIN WITH GOOGLE FOR NON EXISTING
  # USER (ERROR: UNKNOWN VARIABLE- UID, AND PROVIDER)
  
  # def google_oauth2
  #   user = User.from_google(from_google_params)

  #   if user.present?
  #     sign_out_all_scopes
  #     flash[:notice] = t 'devise.omniauth_callbacks.success', kind: 'Google'
  #     sign_in_and_redirect user, event: :authentication
  #   else
  #     flash[:alert] = t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth. info.email} is not authorized."
  #     redirect_to new_user_session_path
  #   end
  # end

  # def from_google_params
  #   @from_google_params ||= {
  #     uid: auth.uid,
  #     email: auth.info.email
  #   }
  # end

  # def auth
  #   @auth ||= request.env['omniauth.auth']
  # end

  def google_oauth2
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      flash[:notice] = "Signed in successfully!"
    else
      redirect_to new_user_registration_url, alert: "Failed to sign in."
    end
  end


end