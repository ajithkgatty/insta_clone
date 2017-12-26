class PicturesController < ApplicationController

   before_action :find_picture, only: [ :edit, :update, :destroy, :show ]		
   before_action :allowed_to_modify?, only: [ :edit, :update, :destroy ]

  def new
  	@picture = current_user.pictures.build
  end


  def create
  	@picture = current_user.pictures.build(picture_params)
  	respond_to do |format|
      if @picture.save
        
        format.html { redirect_to picture_path(@picture) }
        format.json { render :show, status: :created, location: @picture }
        flash.now[:succuess] = "New Post has been created successfully !!!"
      else
        
        format.html { render :new }
        format.json { render json: @pictures.errors, status: :unprocessable_entity }
        flash.now[:alert] = "Somwthing is wrong in the form. Please check the form !!!"
      end
    end
  end

  def index
  	@pictures = Picture.all.order('created_at DESC').page params[:page]
  end

  def edit
  end


  def update
	respond_to do |format|
      if @picture.update_attributes(picture_params)
        format.html { redirect_to picture_path, notice: "Post is updated successfully !!!!" }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @pictures.errors, status: :unprocessable_entity }
      end  	
    end  
  end

  def show
  end

  def destroy
  	respond_to do |format|
      if @picture.destroy
        format.html { redirect_to pictures_path, notice: "Post is successfully deleted !!!!" }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :index }
        format.json { render json: @pictures.errors, status: :unprocessable_entity }
      end  	
    end  
  end


  private 
  def picture_params
  	params.require(:picture).permit(:name, :description, :image)
  end

  def find_picture
  	@picture =  Picture.find(params[:id])
  end

  def allowed_to_modify?
    unless @picture.user ==current_user
      flash[:alert] = "Opppss!!! You must be the owner of this post to perform this operation !!"
      redirect_to root_path
    end
  end
end
