class UploadsController < ApplicationController
  load_and_authorize_resource

  def index
    @uploads = Upload.order(created_at: 'desc').limit(50)
  end

  def show
    @upload = Upload.find(params[:id])
    @next = @upload.next
    @previous = @upload.previous
    @comments = @upload.comments.includes(:user).hash_tree
    @comment = Comment.new(upload: @upload)
    render 'show', layout: 'fluid'
  end

  def new
    @upload = Upload.new
  end

  def create
    @upload = Upload.new(upload_params)
    @upload.user = current_user
    if @upload.save
      redirect_to @upload
    else
      flash[:error] = 'Image could not be uploaded'
      render 'new'
    end
  end

  def destroy
    Upload.find(params[:id]).destroy
    redirect_to uploads_path, flash[:success] = 'Upload deleted'
  end

  private

  def upload_params
    params.require(:upload).permit(:image)
  end
end
