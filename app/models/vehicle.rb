class Vehicle < ActiveRecord::Base
  belongs_to :user

  has_many :vehicle_images
  has_many :registry_requests

  #accepts_nested_attributes_for :vehicle_images

  default_scope { order('created_at DESC') }
  scope :approved, -> { joins(:registry_requests).where("registry_requests.approved_at IS NOT NULL") }
  scope :pending, -> { joins(:registry_requests).where("registry_requests.approved_at IS NULL AND registry_requests.denied_at IS NULL") }
  scope :denied, -> { joins(:registry_requests).where("registry_requests.denied_at IS NOT NULL AND registry_requests.archived_at IS NULL") }
  scope :filter_by_make, ->(makes) { where(make: makes) }
  scope :filter_by_year, ->(ranges) { where(year: convert_years(ranges)) }

  validates :make, presence: true
  validates :model, presence: true
  validates :production_date, presence: true
  validates :engine, presence: true
  validates :transmission, presence: true
  validates :trim, presence: true
  validates :color, presence: true
  validates :options, presence: true
  validates :location, presence: true
  validates :description, presence: true

  #validate :image_size_validation, :if => :image

  def self.makes
    ["Pontiac", "Acadian", "Beaumont"]
  end

  def self.year_ranges
    ["1900-1909", "1910-1919", "1920-1929", "1930-1939",
     "1940-1949", "1950-1959", "1960-1969", "1970-1979",
     "1980-1989"]
  end

  def self.convert_years(ranges)
    ranges.map do |range|
      first, last = range.split("-")
      first..last
    end
  end

  def primary_and_all_vehicle_images
    primary = primary_image
    [primary, vehicle_images]
  end

  def primary_image
    vehicle_images.where(primary: true).take
  end

  def vehicle_request_notes
    registry_requests.pluck(:notes)
  end

  def vehicle_request_approved_notes
    registry_requests.pluck(:notes).join(" ")
  end

  def active_registry_request
    registry_requests.order(created_at: :desc).take
  end

  private

  NUM_BYTES_LIMIT = 500000
  def image_size_validation
    errors.add(:image, "image size cannot exceed 500KB") if image_size_validation > NUM_BYTES_LIMIT
  end
end
