class GalleryController < ApplicationController
  def index
    @images     = GalleryImage.ordered
    @categories = GalleryImage::CATEGORIES
  end
end
