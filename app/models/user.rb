class User < ApplicationRecord
    has_many :userevent
    has_many :event, through: :userevent
end
