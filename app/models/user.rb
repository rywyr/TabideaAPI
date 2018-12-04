class User < ApplicationRecord
    has_secure_token
    has_many :userevent, :dependent => :destroy
    has_many :event, through: :userevent
    has_many :tokens
    mount_uploader :icon_image, ImageUploader
    
end
