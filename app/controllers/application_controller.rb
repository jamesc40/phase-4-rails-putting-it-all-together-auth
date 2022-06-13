class ApplicationController < ActionController::API
  include ActionController::Cookies

  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_res
  
  # returns an arr of error messages
  def unprocessable_entity_res exception
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
  
  # checks if user is logged in; returns an error if they are not.
  def authorize
    render json: { errors: ["you're not logged in bud"] }, 
      status: :unauthorized unless session.include? :user_id
  end

end
