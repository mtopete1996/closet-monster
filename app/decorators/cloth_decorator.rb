class ClothDecorator < ApplicationDecorator
  def picture_url
    h.url_for(picture.variant(resize_to_fill: [180, 180]))
  end
end
