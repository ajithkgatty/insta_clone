class ProfilesController < ApplicationController

	before_action :find_user
	before_action :allowed_to_modify?, only: [:edit, :update]

  def show
  	begin
  		@pictures = @user.pictures.order("created_at DESC")
  	rescue 
  		flash[:success] = "Oppss!!!!!!! User not found with matching username."
  		redirect_to root_path
  	end
  end

  def edit
  end

  def update
  	respond_to do |format|
      if @user.update_attributes(profile_params)
        format.html { redirect_to profile_path( @user.username), notice: "Profile is updated successfully !!!!" }
        format.json { render :show, status: :created, location: @user }
      else
      	flash[:error] = @user.errors.full_messages
        format.html { render :edit }
        # format.json { render json: @user.errors, status: :unprocessable_entity }
      end  	
    end  

  end

  private

  def find_user
  	@user = User.find_by_username( params[:username] ) unless params[:username].blank?
  end

  def profile_params
  	params.require(:user).permit(:avatar, :bio)
  end

  def allowed_to_modify?
    unless @user ==current_user
      flash[:alert] = "Opppss!!! You can not modify other profiles !!"
      redirect_to root_path
    end
  end
end
