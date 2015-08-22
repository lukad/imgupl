class CommentsController < ApplicationController
  include Votable

  load_and_authorize_resource

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = 'Your comment was saved'
    else
      flash[:error] = 'Your comment could not be saved'
    end
    redirect_to @comment.upload
  end

  def destroy
    upload = @comment.upload
    if Comment.find(params[:id]).try(:destroy)
      Comment.includes(:children).rebuild!
      flash[:success] = 'Comment was deleted'
    else
      flash[:error] = 'Comment could not be deleted'
    end
    redirect_to upload
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :upload_id, :parent_id)
  end
end
