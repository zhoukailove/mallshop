class Product < ActiveRecord::Base
  belongs_to :user
  has_many :product_drawings ,dependent: :delete_all
end
