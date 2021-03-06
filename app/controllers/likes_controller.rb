class LikesController < ApplicationController
  load_and_authorize_resource
  before_action :load_review

  def create
    @like = @review.likes.build
    @like.user_id = current_user.id
    if @like.save
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t ".flash.like_failed"
      redirect_to tours_path
    end
  end

  def destroy
    if @like.destroy
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t ".flash.unlike_failed"
      redirect_to tours_path
    end
  end

  private

  def load_review
    @review = Review.find_by id: params[:review_id]
    return if @review

    flash[:danger] = t ".flash.review_not_found"
    redirect_to tours_path
  end
end
