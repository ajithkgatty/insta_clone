class NotificationsController < ApplicationController
  def link_through
  	@notification = Notification.find(params[:id])
  	@notification.update(read: true)
  	redirect_to picture_path(@notification.picture)
  end

  def index
  	@notifications = Notification.all
  end
end
