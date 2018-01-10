module PicturesHelper
	
	# def likers_of( picture )
	#     votes = picture.votes_for.up.by_type(User)
	#     user_names = []
	#     unless votes.blank?
	#       votes.voters.each do |voter|
	#         user_names.push(link_to voter.username,
	#                                 profile_path(voter.username),
	#                                 class: 'user-name')
	#       end
	#       user_names.to_sentence.html_safe + like_plural(votes)
	#     end
 #  	end

	  def liked_picture picture
	  	return 'glyphicon-heart' if current_user.voted_for? picture
	  	'glyphicon-heart-empty'
	  end

	   def like_unlike picture
	  	return "like_picture" if current_user.voted_for? picture
	  	"unlike_picture"
	   end


	  def display_likes picture
	  	votes = picture.votes_for.up.by_type(User)
	  	return list_likers(votes) if votes.size <= 8
	  	count_likers votes
	  end

  private

	  def like_plural(votes)
	    return ' like this' if votes.count > 1
	    ' likes this'
	  end

	  def count_likers votes
	 	return votes.count.to_s + "likes"
	  end

	  def list_likers(votes)
	  	user_names = []
	    unless votes.blank?
	      votes.voters.each do |voter|
	        user_names.push(link_to voter.username,
	                                profile_path(voter.username),
	                                class: 'user-name')
	      end
	      user_names.to_sentence.html_safe + like_plural(votes)
	    end
	  end
  end

