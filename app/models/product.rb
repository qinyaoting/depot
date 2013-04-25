class Product < ActiveRecord::Base
  attr_accessible :description, :image_url, :title, :price


  has_many :orders, :through => :line_items
  has_many :line_items

  def self.find_products_for_sale
    find(:all,:order => "title")
  end

  validates_presence_of :title, :description, :image_url
  # validates :name, :presence => true
  # validates :title, :presence => true, :length => {:minimum => 5}

  validates_numericality_of :price
  validate :price_must_be_at_least_a_cent
  validates_uniqueness_of :title
  validates_format_of :image_url,
                      :with => %r{\.(gif|jpg|png)$}i,
                      :message => "must be a URL for image"


  protected
  def price_must_be_at_least_a_cent
    errors.add(:price,'Should be at least 0.01') if price.nil? || price < 0.01
  end
end
