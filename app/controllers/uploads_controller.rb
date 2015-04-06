class UploadsController < ApplicationController
  def index
    @uploads = Upload.order(created_at: 'desc').limit(50)
    render 'index'
  end

  def show
    @upload = Upload.find(params[:id])
    @next = @upload.next
    @previous = @upload.previous
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

  private

  def upload_params
    params.require(:upload).permit(:image)
  end
end
