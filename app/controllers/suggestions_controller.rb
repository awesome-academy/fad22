class SuggestionsController < ApplicationController
  before_action :authenticate_user!, only: %i(new create)
  authorize_resource

  def new
    @suggestion = current_user.suggestions.new
  end

  def create
    @suggestion = current_user.suggestions.create! suggestion_params
    flash[:success] = t ".thank_you"
    redirect_to :root
  end

  private

  def suggestion_params
    params.require(:suggestion).permit :title, :content, :user_id
  end
end
