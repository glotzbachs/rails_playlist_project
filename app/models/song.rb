class Song < ApplicationRecord
    belongs_to :playlist
    belongs_to :users

    accepts_nested_attributes_for :playlist

    validates :title, presence: true
end
