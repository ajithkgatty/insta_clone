module NotificationsHelper
	def create_notification(picture, comment=false)
		return if picture.user.id == current_user.id
		if comment
			Notification.create! user_id: picture.user.id, notified_by_id: current_user.id, picture_id: picture.id, identifier: comment.id, notice_type: 'comment'
		else
			Notification.create! user_id: picture.user.id, notified_by_id: current_user.id, picture_id: picture.id, identifier: -1, notice_type: 'like'
		end	
	end
end
