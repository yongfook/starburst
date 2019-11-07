require_dependency 'starburst/application_controller'

module Starburst
	class AnnouncementsController < ApplicationController
		def mark_as_read
			announcement = Announcement.with_hashids(params[:id]).first
			if respond_to?(Starburst.current_user_method) && send(Starburst.current_user_method) && announcement
				if AnnouncementView.where(user_id: send(Starburst.current_user_method).id, announcement_id: announcement.id).first_or_create(user_id: send(Starburst.current_user_method).id, announcement_id: announcement.id)
					render :json => :ok
				else
					render json: nil, :status => :unprocessable_entity
				end
			else
					render json: nil, :status => :unprocessable_entity
			end
		end
	end
end
