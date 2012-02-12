class SessionsController < ApplicationController

  before_filter :force_ssl, :only => [:new, :create]

  def new
    @title = "Sign in"
  end

  def create
    # user = User.authenticate_old(params[:session][:email],
    #                              params[:session][:password])
    user = User.find_by_email(params[:session][:email])
    if user.nil? || !user.authenticate(params[:session][:password])
      flash.now[:error] = "Invalid email/password confirmation."
      @title = "Sign in"
      render 'new'
    else
      sign_in user
      redirect_back_or user
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  private

    def force_ssl
      if request.ssl? && !Rails.env.production?
        flash.now[:info] = "Request is ssl"
      else
        # flash.now[:info] = "Request is not ssl"
        # redirect_to :protocol => 'https'
      end
    end

end
