require 'rails_helper'

RSpec.feature "User clicks on a product in home page", type: :feature, js: true do
# SETUP
before :each do
  @category = Category.create! name: 'Apparel'

  
  @category.products.create!(
    name:  Faker::Hipster.sentence(3),
    description: Faker::Hipster.paragraph(4),
    image: open_asset('apparel1.jpg'),
    quantity: 10,
    price: 64.99
  )
  end

  scenario "They see product details page" do
    visit root_path
    find_link("Details").trigger("click")
    # expect(page).to have_content("Description") 
    # expect(page).to have_content("Quantity")
    expect(page).to have_css 'section.products-show' 
    sleep 5 
    save_screenshot
  end
end