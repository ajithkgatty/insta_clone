class CommentsController < ApplicationController
	before_action :fetch_picture
	include NotificationsHelper

	def create
    @comment = @picture.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      create_notification(@picture, @comment)		
      respond_to do |format|
      	flash[:success] = "Comment has been added !!"
        # format.html { redirect_to root_path }
        format.js
      end

    else
      flash[:alert] = "Check the comment form, something went wrong."
      render root_path
    end
  end



	def destroy
		@comment = @picture.comments.find(params[:id])
		if @comment.destroy
			respond_to do |format|
				# format.html { redirect_to root_path }
				flash[:success] = "Comment has been deleted !!"
        		format.js
      		end
    	else
	      	flash[:alert] = "Could not delete the comment. Please try again later !!"
	      	render root_path
    	end
	end




private
	def comment_params
		params.require(:comment).permit(:content)	
	end

	def fetch_picture
		@picture = Picture.find(params[:picture_id])
	end

	
end
