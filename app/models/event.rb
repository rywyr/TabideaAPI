class Event < ApplicationRecord
    has_many :userevent
    has_many :mmo
    has_many :user, through: :userevent
end
