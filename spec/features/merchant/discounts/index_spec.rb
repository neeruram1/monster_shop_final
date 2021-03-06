require 'rails_helper'

RSpec.describe 'Merchant Discount Index Page' do
  describe 'As an employee of a merchant' do
    before :each do
      @merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @m_user = @merchant_1.users.create(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'megan@example.com', password: 'securepassword')
      @discount_1 = @merchant_1.discounts.create(percent: 5, quantity: 10)
      @discount_2 = @merchant_1.discounts.create(percent: 10, quantity: 20)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@m_user)
    end

    it "I see all of my bulk discounts listed with percentage and inventory quantity" do
      visit '/merchant/discounts'

      expect(page).to have_content("Bulk Discounts")

      within ".discount-#{@discount_1.id}" do
        expect(page).to have_content("Discount ID: #{@discount_1.id}")
        expect(page).to have_content("Percent Off: #{@discount_1.percent}")
        expect(page).to have_content("Required Item Quantity: #{@discount_1.quantity} units")
      end

      within ".discount-#{@discount_2.id}" do
        expect(page).to have_content("Discount ID: #{@discount_2.id}")
        expect(page).to have_content("Percent Off: #{@discount_2.percent}")
        expect(page).to have_content("Required Item Quantity: #{@discount_2.quantity} units")
      end
    end

    it "I see a link to create a new discount" do
      visit '/merchant/discounts'

      click_on "Create A Discount"

      expect(current_path).to eq('/merchant/discounts/new')
    end

    it "I see a link to update an existing discount" do
        visit '/merchant/discounts'

        within ".discount-#{@discount_1.id}" do
          click_on "Edit"
        end

        expect(current_path).to eq("/merchant/discounts/#{@discount_1.id}/edit")
      end

      it "I can deactivate a discount" do
        visit '/merchant/discounts'

        within ".discount-#{@discount_1.id}" do
          click_on "Deactivate"
        end

        expect(current_path).to eq('/merchant/discounts')
        expect(page).to have_content("Discount #{@discount_1.id} has been successfully deactivated")

        within ".discount-#{@discount_1.id}" do
          expect(page).to_not have_content("Deactivate")
          expect(page).to have_content("Activate")
        end
      end

      it "I can activate a discount" do
        @discount_1.update(status: 1)

        visit '/merchant/discounts'

        within ".discount-#{@discount_1.id}" do
          click_on "Activate"
        end

        expect(current_path).to eq('/merchant/discounts')
        expect(page).to have_content("Discount #{@discount_1.id} has been successfully activated")

        within ".discount-#{@discount_1.id}" do
          expect(page).to have_content("Deactivate")
          expect(page).to_not have_content("Activate")
        end
      end

      it "I see a link to delete only inactive discounts" do
        @discount_1.update(status: 1)

        visit '/merchant/discounts'

        within ".discount-#{@discount_2.id}" do
          expect(page).to_not have_link("Delete")
        end

        within ".discount-#{@discount_1.id}" do
          click_on "Delete"
        end

        expect(current_path).to eq("/merchant/discounts")
        expect(page).to have_content("Discount has been successfully deleted")

        expect(page).to_not have_content(@discount_1.id)
      end

      it "Discount IDs are links to their show page" do
        visit '/merchant/discounts'

        within ".discount-#{@discount_2.id}" do
          click_on "#{@discount_2.id}"
        end

        expect(current_path).to eq("/merchant/discounts/#{@discount_2.id}")
      end
    end
  end
