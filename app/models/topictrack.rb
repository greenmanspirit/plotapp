class Topictrack < ActiveRecord::Base
	belongs_to :author

	def self.new_in_forum? forum, current_author
		topics = forum.topics.all(:conditions=>['last_post_date >= ?', 14.days.ago])
		topics.each do |topic|
			tt = Topictrack.first(:conditions=>['topic_id = ? AND author_id = ?', topic.id, current_author.id])
			if tt == nil || (topic.last_post_date > tt.last_time_viewed) then
				return true
			end
		end
		return false
	end

	def self.new_in_topic? topic, current_author
		tt = Topictrack.first(:conditions=>['topic_id = ? AND author_id = ?', topic.id, current_author.id])
		if tt == nil || (topic.last_post_date > tt.last_time_viewed) then
			return true
		end
		return false
	end
	def self.for_topic topic
		first(:conditions=>['topic_id = ?', topic.id])
	end
end
