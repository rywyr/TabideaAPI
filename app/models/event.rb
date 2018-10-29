class Event < ApplicationRecord
    has_many :userevent, :dependent => :destroy
    has_secure_password validations: true
    has_many :user, through: :userevent
end
