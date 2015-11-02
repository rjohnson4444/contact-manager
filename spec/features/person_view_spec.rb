require 'rails_helper'

describe 'the person view', type: :feature do
  let(:person) { Person.create(first_name: 'John', last_name: 'Doe') }

  describe 'phone numbers' do
    before(:each) do
      person.phone_numbers.create(number: '555-1234')
      person.phone_numbers.create(number: '555-6789')
      visit person_path(person)
    end

    it 'shows the phone numbers' do
      person.phone_numbers.each do |phone|
        expect(page).to have_content(phone.number)
      end
    end

    it 'has a link to add a new phone number' do
      expect(page).to have_link('Add phone number', href: new_phone_number_path(contact_id: person.id, contact_type: 'Person'))
    end

    it 'adds a new phone number' do
      page.click_link('Add phone number')
      page.fill_in('Number', with: '555-8888')
      page.click_button('Create Phone number')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('555-8888')
    end

    it 'has links to edit phone numbers' do
      person.phone_numbers.each do |phone|
        expect(page).to have_link('edit', href: edit_phone_number_path(phone))
      end
    end

    it 'edits a phone number' do
      phone = person.phone_numbers.first
      old_number = phone.number

      first(:link, 'edit').click
      page.fill_in('Number', with: '555-9191')
      page.click_button('Update Phone number')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('555-9191')
      expect(page).to_not have_content(old_number)
    end

    it 'has links to destroy phone number' do
      person.phone_numbers.each do |phone|
        expect(page).to have_link('destroy', href: phone_number_path(phone))
      end
    end

    it 'deletes a phone number' do
      phone_number = person.phone_numbers.first

      first(:link, 'destroy').click
      expect(current_path).to eq(person_path(person))
      expect(page).to_not have_content(phone_number)
      expect(page).to_not have_link('destroy', href: phone_number_path(phone_number))
      expect(page).to_not have_link('edit', href: edit_phone_number_path(phone_number))
    end
  end

  describe 'email addresses' do
    before(:each) do
      person.email_addresses.create(address: 'yoyoyo@live.com')
      person.email_addresses.create(address: 'thatsthetruth@live.com')
      visit person_path(person)
    end

    it 'shows email addresses' do
      expect(page).to have_selector('li', text: 'yoyoyo@live.com')
      expect(page).to have_selector('li', text: 'thatsthetruth@live.com')
    end

    it 'has an add email address link' do
      expect(page).to have_link('Add email address', href: new_email_address_path(person_id: person.id))
    end

    it 'adds a new email address' do
      page.click_link('Add email address')
      page.fill_in('Address', with: 'thisIsMyEmail@live.com')
      page.click_button('Create Email address')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('thisIsMyEmail@live.com')
    end

    it 'has a link to edit a email address' do
      person.email_addresses.each do |email|
        expect(page).to have_link('edit', href: edit_email_address_path(email))
      end
    end

    it 'edits a email address' do
      email = person.email_addresses.first
      old_email_address = email.address

      first(:link, 'edit').click
      page.fill_in('Address', with: 'NewEmail@yahoo.com')
      page.click_button('Update Email address')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('NewEmail@yahoo.com')
      expect(page).to_not have_content(old_email_address)
    end

    it 'has a destroy link' do
      person.email_addresses.each do |email|
        expect(page).to have_link('destroy', href: email_address_path(email))
      end
    end

    it 'deletes a email' do
      email_address = person.email_addresses.first

      first(:link, 'destroy').click
      expect(current_path).to eq(person_path(person))
      expect(page).to_not have_link('destroy', href: email_address_path(person))
      expect(page).to_not have_content(email_address)
    end
  end
end
