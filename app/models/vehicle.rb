class Vehicle < ActiveRecord::Base
  belongs_to :user
  has_many :vehicle_images
  #mount_uploader :front, FrontUploader
  attr_accessor :front, :front_cache

  default_scope { order('created_at DESC') }
end
