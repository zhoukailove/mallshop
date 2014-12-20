# -*- encoding : utf-8 -*-
class ProductDrawing < ActiveRecord::Base
  belongs_to :product
  mount_uploader :product_drawing, ProductDrawingUploader

  def product_drawing_file(size = :mid)
    product_drawing.url(size) || "#{size}_avatar.png"
  end
end
