class Category < ApplicationRecord
  has_many :eventcategory
  has_many :event, through: :eventcategory
end
