class Category < ApplicationRecord
  has_many :eventcategory, :dependent => :destroy
  has_many :event, through: :eventcategory
end
