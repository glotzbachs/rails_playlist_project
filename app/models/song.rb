class Song < ApplicationRecord
    belongs_to :playlist
    belongs_to :user

    accepts_nested_attributes_for :playlist, reject_if: proc{|attr| attr[:title].blank?}

    validates :title, presence: true
    
    scope :by_genre, ->(genre) { where("genre = ?", genre) }
end
