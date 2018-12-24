class PicturesController < ApplicationController
  before_action :set_picture, only:[:show, :edit, :update, :destroy]
  def index
    @pictures = Picture.all
  end
  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end
  def create
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    if @picture.save
      redirect_to pictures_path
      PictureMailer.picture_mail(@picture).deliver
      
    else
      render 'new'
    end
  end
  
  def confirm
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    render :new if @picture.invalid?
  end
  
  def show
    #@pictures = Picture.all
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end
  def edit
  end
  def update
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: "ブログを編集しました！"
    else
      render 'edit'
    end
  end
  def destroy
    @picture.destroy
    redirect_to pictures_path, notice:"削除"
  end
  
  private
  
  def picture_params
    params.require(:picture).permit(:image,:image_cache, :content)
  end
  def set_picture
    @picture = Picture.find(params[:id])
  end
end
