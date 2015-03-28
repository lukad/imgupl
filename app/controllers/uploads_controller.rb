class UploadsController < ApplicationController
  def latest
    @uploads = Upload.order(:created_at).limit(50)
    render 'index'
  end

  def show
    upload = Upload.find(params[:id])
    redirect_to upload.image.url
  end

  def new
    @upload = Upload.new
    @user = current_user
  end

  def create
    @upload = Upload.new(upload_params)
    @upload.user = current_user
    if @upload.save!
      redirect_to @upload
    else
      flash[:error] = 'Something went wrong :('
      render 'new'
    end
  end

  private

  def upload_params
    params.require(:upload).permit(:image)
  end
end
