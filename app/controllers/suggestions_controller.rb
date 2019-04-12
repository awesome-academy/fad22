class SuggestionsController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user, only: %i(new create)

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
