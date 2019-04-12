class CommentsController < ApplicationController
  before_action :load_comment, only: %i(destroy edit update)
  before_action :logged_in_user, only: :create
  include SessionsHelper

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

  def load_comment
    @comment = Comment.find_by id: params[:id]
  end

  def comment_params
    params.require(:comment).permit :content, :rate, :product_id, :user_id
  end
end
