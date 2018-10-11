class Userevent < ApplicationRecord
    belong_to :user
    belong_to :event
end
