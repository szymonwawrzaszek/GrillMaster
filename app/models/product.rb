class Product < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  before_destroy :not_referenced_by_any_item


  has_many :items

  private

  def not_referenced_by_any_item
    unless items.empty?
      errors.add(:base, 'Items present')
      throw :abort
    end
  end
end
