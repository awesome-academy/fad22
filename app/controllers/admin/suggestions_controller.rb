class Admin::SuggestionsController < Admin::BaseController
  def index
    @suggestions = Suggestion.all
  end
end
