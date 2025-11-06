class Feature < ApplicationRecord
  has_many :vehicle_features, dependent: :destroy
  has_many :vehicles, through: :vehicle_features

  validates :key, presence: true, uniqueness: true

  def name(locale = I18n.locale)
    I18n.t("features.#{key}", locale: locale, default: key.humanize)
  end

  default_scope { order(:position, :key) }
end
