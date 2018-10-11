class Event < ApplicationRecord
    has_many :userevent
    has_many :user, through: :userevent
end
