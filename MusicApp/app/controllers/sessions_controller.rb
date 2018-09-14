class SessionsController < ApplicationController
  # before_action :require_login, only: [:destroy]
  # before_action :require_logout, only: [:new, :create]
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )

    if @user
      login!(@user)
      redirect_to bands_url(@user)
    else
      flash.now[:errors] = ["Invalid password"]
      render :new
    end
  end

  def destroy
    log_out!
    redirect_to new_user_url
  end

end
