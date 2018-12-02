class Event < ApplicationRecord
    has_many :userevent, :dependent => :destroy
    has_many :user, through: :userevent
    has_many :eventcategory, :dependent => :destroy
    has_many :category, through: :eventcategory
end
