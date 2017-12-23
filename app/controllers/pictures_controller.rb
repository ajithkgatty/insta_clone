class PicturesController < ApplicationController

   before_action :find_picture, only: [:edit, :update, :destroy, :show]		

  def new
  	@picture = Picture.new
  end


  def create
  	@picture = Picture.new(picture_params)
  	respond_to do |format|
      if @picture.save
        format.html { redirect_to picture_path(@picture), notice: "New post is added !!!!" }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new }
        format.json { render json: @pictures.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
  	@pictures = Picture.all
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
end
