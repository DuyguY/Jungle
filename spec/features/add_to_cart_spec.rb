require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js:true do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "My Cart is updated to show it contains 1 product" do
    visit root_path
    button = page.first("article.product:nth-child(2) .btn")
    button.trigger("click")
    expect(page).to have_css 'section.products-index'
    sleep 5 
    expect(page).to have_content 'My Cart (1)'
    sleep 5 
    save_screenshot
  end 
end
