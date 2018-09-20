class AccountController < ApplicationController
  include Devise::Controllers::SignInOut

  def get_your_account
    authorize :account
    @user = User.find params[:id]

    if !@user.valid_token?(params[:token]) || @user.id != params[:id].to_i
      redirect_to root_path, alert: "Geçersiz bağlantı"
    end
  end

  def update_account
    authorize :account
    @user = User.find params[:id]
    
    redirect_to root_path, alert: "Geçersiz token" unless @user.valid_token?(params[:token])

    if @user.update(account_update_params)
      @user.update_attribute :reset_password_token, nil
      @user.take_ownership
      
      if @user.active_for_authentication?
        sign_in(@user, scope: :user)
        redirect_to announcements_user_index_path, notice: I18n.t("devise.registrations.signed_up")
      else
        expire_data_after_sign_in!
        redirect_to root_path, notice: I18n.t("devise.registrations.signed_up_but_#{@user.inactive_message}")
      end
    else
      render :get_your_account
    end
  end

  def cancel_account
    authorize :account
    @user = User.find params[:id]
    @token = params[:token]

    if @user.valid_token?(@token)

      @user.cancel_by_self
      redirect_to root_path, notice: "Sizin için oluşturulmuş otomatik hesabı başarıyla iptal ettiniz. Rahatsız ettiğimiz için özür dileriz."

    else
      redirect_to root_path, alert: "Geçersiz bağlantı"
    end
  end
  
  private

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email,
                  :phone, :avatar, :password, :password_confirmation)
  end

end