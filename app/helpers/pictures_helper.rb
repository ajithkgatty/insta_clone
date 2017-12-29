module PicturesHelper
	def likers_of( picture )
	    votes = picture.votes_for.up.by_type(User)
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

  private

  def like_plural(votes)
    return ' like this' if votes.count > 1
    ' likes this'
  end
end
