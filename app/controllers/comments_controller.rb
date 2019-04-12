class CommentsController < ApplicationController
  before_action :load_comment, only: %i(destroy edit update)
  before_action :authenticate_user!, only: :create
  authorize_resource
  def create
    @comment = Comment.new comment_params
    respond_to do |format|
      if @comment.save
        format.js
        format.html{redirect_to @comment.product}
      else
        format.html{render :root}
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html{redirect_to @comment.product}
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @comment.update_attributes comment_params
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def authenticate_user!
    if user_signed_in?
      super
    else
      flash[:danger] = t "devise.failure.unauthenticated"
      redirect_to new_user_session_path
    end
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]
  end

  def comment_params
    params.require(:comment).permit :content, :rate, :product_id, :user_id
  end
end
