class User < ApplicationRecord
    has_many :userevent, :dependent => :destroy
    has_many :event, through: :userevent
    has_many :tokens
end
