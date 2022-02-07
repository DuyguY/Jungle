require'rails_helper'

RSpec.describe Product, type: :model do

  # validation tests
  describe 'Validations' do 

    it 'is not valid without a name' do
      category = Category.create(name: "test_category")
      product = Product.create(
        price_cents: 779,
        quantity: 10,
        category_id: category.id,
     )
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include "Name can't be blank"
    end 

    it 'is not valid without a price' do
      category = Category.create(name: "test_category")
      product = Product.create(
        name: "test_product",
        quantity: 10,
        category_id: category.id,
     )
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include "Price can't be blank"
    end 

    it 'is not valid without a quantity' do
      category = Category.create(name: "test_category")
      product = Product.create(
        name: "test_product",
        category_id: category.id,
        price_cents: 779,
     )
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include "Quantity can't be blank"
    end 

    it 'is not valid without a category' do
      product = Product.create(
        name: "test_product",
        price_cents: 779,
        quantity: 10,
      )
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include "Category can't be blank"
    end 
  end
end    