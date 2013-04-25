class LineItem < ActiveRecord::Base
  attr_accessible :order_id, :product_id, :quantity, :total_price

  # 如果一张表包含外键，那么他对应的模型就应该针对每个外键做belongs_to声明
  belongs_to :order
  belongs_to :product

  def self.from_cart_item(cart_item)
    li = self.new
    li.product = cart_item.product
    li.quantity = cart_item.quantity
    li.total_price = cart_item.price
    li
  end
end
