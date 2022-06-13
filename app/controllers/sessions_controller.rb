class SessionsController < ApplicationController
  # excludes create from the .authorize method because you can't verify user prior to login
  before_action :authorize, only: [:destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_res

  def create
    user = User.find_by!( username: params[:username] )
    
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: user, status: :accepted
    else
      head :unauthorized
    end

  end

  def destroy
    session.delete :user_id
    head :no_content
  end


  private 

  def not_found_res invalid
    render json: { errors: [invalid] }, status: :unauthorized
  end

end
