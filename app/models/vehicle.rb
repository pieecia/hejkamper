class Vehicle < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"

  has_many :vehicle_features, dependent: :destroy
  has_many :features, through: :vehicle_features
  has_many_attached :images

  validate :validate_images
  validates :name, :city, :location, :available_from, :model, :transmission, :fuel_type, :brand, :description, presence: true
  validates :price, :length, :sleeps, :beds, :year, numericality: { greater_than: 0 }

  geocoded_by :location
  after_validation :geocode, if: ->(obj) { obj.location.present? && obj.location_changed? }

  scope :available_on, ->(date) {
    where("available_from <= ?", date)
  }

  scope :located_in, ->(location) {
    where(location: location)
  }

  scope :in_city, ->(city) {
    where(city: city)
  }

  scope :recently_added, -> {
    order(created_at: :desc).limit(5)
  }

  def self.search(params)
    vehicles = all
    if params[:date].present?
      begin
        vehicles = vehicles.available_on(Date.parse(params[:date]))
      rescue ArgumentError
        # Invalid date format, return empty result
        return none
      end
    end
    vehicles = vehicles.in_city(params[:city]) if params[:city].present?
    vehicles
  end

  def feature_keys=(keys)
    self.features = keys.reject(&:blank?).map do |key|
      Feature.find_by(key: key)
    end.compact
  end

  def feature_keys
    features.pluck(:key)
  end

  def update_with_images(attributes, new_images = nil)
    # Check if there are actually new images (not just empty array)
    has_new_images = new_images.present? && new_images.reject(&:blank?).any?
    
    if has_new_images
      new_images = new_images.reject(&:blank?)
      if new_images.size != 3
        errors.add(:images, "Dodaj dokładnie 3 zdjęcia")
        assign_attributes(attributes)
        return false
      end
    end

    # Update attributes without triggering image validation if no new images
    unless has_new_images
      # Temporarily skip image validation during update
      @skip_image_validation = true
    end

    result = update(attributes)
    @skip_image_validation = false

    if result && has_new_images
      images.purge
      images.attach(new_images)
    end

    result
  end

  TRANSMISSIONS = {
    "Manualna" => "manual",
    "Automatyczna" => "automatic"
  }.freeze

  TRANSMISSION_LABELS = TRANSMISSIONS.invert.freeze

  def transmission_name
    TRANSMISSION_LABELS[transmission]
  end

  FUEL_TYPES = {
    "Diesel" => "diesel",
    "Benzyna" => "petrol",
    "Elektryczny" => "electric",
    "Hybrydowy" => "hybrid"
  }.freeze

  private

  def validate_images
    # Skip validation if we're updating without new images
    return if defined?(@skip_image_validation) && @skip_image_validation
    
    return unless images.attached?

    if images.count != 3
      errors.add(:images, "Dodaj dokładnie 3 zdjęcia")
    end

    images.each do |image|
      if image.byte_size > 5.megabytes
        errors.add(:images, "#{image.filename} jest za duże (max 5MB)")
      end

      unless image.content_type.in?(%w[image/jpeg image/png image/jpg image/webp])
        errors.add(:images, "#{image.filename} musi być w formacie JPG, PNG lub WEBP")
      end
    end
  end
end
