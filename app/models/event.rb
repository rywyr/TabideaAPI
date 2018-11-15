class Event < ApplicationRecord
    has_many :userevent, :dependent => :destroy
    has_many :user, through: :userevent
end
