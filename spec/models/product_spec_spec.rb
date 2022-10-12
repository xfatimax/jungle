require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "is creating a new product if each 4 parameters are met" do
      @category = Category.create(name: 'Trees')
      @product = Product.create(name: 'Mars Fly Trap', price_cents: 66, quantity: 7, category: @category)
      @product.save!
      expect(@product).to be_valid
    end
    it "is is nil if there's no name" do
      @category = Category.new
      @product = Product.new
      expect(@product.name).to be_nil
    end
    it "is not valid without a price" do
      @category = Category.create(name: 'Trees')
      @product = Product.create(name: 'Mars Fly Trap', price_cents: nil, quantity: 7, category: @category)
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end
    it "is not valid without a quantity" do
      @category = Category.create(name: 'Trees')
      @product = Product.create(name: 'Mars Fly Trap', price_cents: 66, quantity: nil, category: @category)
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end
    it "is not valid without a cagegory" do
      @product = Product.create(name: 'Mars Fly Trap', price_cents: 66, quantity: nil, category: nil)
      expect(@product).not_to be_valid
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end