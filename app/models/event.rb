class Event < ActiveRecord::Base
  belongs_to :organizer, class_name: "User"	
  has_many :taggings
  has_many :tags, through: :taggings

  has_many :attendances
  has_many :users, :through => :attendances

  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]

    def slug_candidates
      [
        :title,
        [:title, :location],
      ]
    end

  	def all_tags=(names)
  	  self.tags = names.split(",").map do |t|
  	    Tag.where(name: t.strip).first_or_create!
  	  end
    end

    def all_tags
     self.tags.map(&:name).join(", ")    
    end


    def self.tagged_with(name)
      Tag.find_by_name!(name).events
    end

    def self.tag_counts
      Tag.select("tags.* count(taggings.tag_id) as count").joins(:taggings).
        group("taggings.tag_id")
    end

    def self.pending_requests(event_id)
      Attendance.where(event_id: event_id, state: 'request_sent')      
    end

end
