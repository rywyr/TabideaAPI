class Eventcategory < ApplicationRecord
  belongs_to :event
  belongs_to :category

  validates :event_id, :uniqueness => {:scope => :category_id}
end
