require'rails_helper'

RSpec.describe User, type: :model do
  
  # validation tests
  describe 'Validations' do 
    it 'is valid with valid attributes' do
      person = described_class.new(
      first_name: "Tony",
      last_name:"Stark",
      email: "tony@test.com",
      password: "password",
      password_confirmation: "password"
    )
      expect(person).to be_valid
      expect(person.errors.full_messages).to be_empty
    end 

    it 'is not valid without first_name' do
      person = described_class.new(
      last_name:"Stark",  
      email: "tony@test.com",
      password: "password",
      password_confirmation: "password"
    )
      expect(person).to_not be_valid
      expect(person.errors.full_messages).to include "First name can't be blank"
    end 

    it 'is not valid without last_name' do
      person = described_class.new(
      first_name:"Tony",  
      email: "tony@test.com",
      password: "password",
      password_confirmation: "password"
    )
      expect(person).to_not be_valid
      expect(person.errors.full_messages).to include "Last name can't be blank"
    end 
    it 'is not valid without email' do
      person = described_class.new(
      first_name: "Tony",
      last_name:"Stark",
      password: "password",
      password_confirmation: "password"
    )
      expect(person).to_not be_valid
      expect(person.errors.full_messages).to include ("Email can't be blank")
    end 

    it 'is not valid without password' do
      person = described_class.new(
      first_name: "Tony",
      last_name:"Stark",
      email: "tony@test.com",
      password_confirmation: "password"
    )
      
      expect(person).to_not be_valid
      expect(person.errors.full_messages).to include "Password can't be blank"
    end 

    it 'is not valid without password confirmation' do
      person = described_class.new(
      first_name: "Tony",
      last_name:"Stark",
      email: "tony@test.com",
      password: "password",
    )
      expect(person).to_not be_valid
      expect(person.errors.full_messages).to include "Password confirmation can't be blank"
    end 

    it 'is not valid password confirmation ' do
      person = described_class.new(
      first_name: "Tony",
      last_name:"Stark",
      email: "tony@test.com",
      password: "password",
      password_confirmation: "asdzxc",
    )
      
      expect(person).to_not be_valid
      expect(person.errors.full_messages).to include "Password confirmation doesn't match Password"
    end 

    it 'is not valid when password is shorter than 5 characters' do
      person = described_class.new(
      first_name: "Tony",
      last_name:"Stark",
      email: "tony@test.com",
      password: "asdf",
      password_confirmation: "asdf",
    )
      
      expect(person).to_not be_valid
      expect(person.errors.full_messages).to include "Password is too short (minimum is 5 characters)"
    end 

    it 'is valid when password is 5 characters' do
      person = described_class.new(
      first_name: "Tony",
      last_name:"Stark",
      email: "tony@test.com",
      password: "asdfg",
      password_confirmation: "asdfg",
    )
      
      expect(person).to be_valid
      expect(person.errors.full_messages).to be_empty
    end 
  end 
  
  describe ".authenticate_with_credentials" do
    it "authenticates when credentials are valid" do
      person = described_class.new(
      first_name: "Tony",
      last_name:"Stark",
      email: "tony@test.com",
      password: "asdf12",
      password_confirmation: "asdf12",
    )
      person.save!
      auth = User.authenticate_with_credentials(person.email, person.password)
      expect(auth).to eq person
    end

    it "does not authenticate when email is incorrect" do
      person = described_class.new(
      first_name: "Tony",
      last_name:"Stark",
      email: "tony@test.com",
      password: "asdf12",
      password_confirmation: "asdf12",
    )
      person.save!
      auth = User.authenticate_with_credentials("email@email.com", person.password)
      expect(auth).to eq nil
    end

    it "does not authenticate when password is incorrect" do
      person = described_class.new(
      first_name: "Tony",
      last_name:"Stark",
      email: "tony@test.com",
      password: "asdf1",
      password_confirmation: "asdf1",
    )
      person.save!
      auth = User.authenticate_with_credentials(person.email, "xyz12")
      expect(auth).to eq nil
    end

    it "authenticates when email is correct but contains whitespace around it" do
      person = described_class.new(
      first_name: "Tony",
      last_name:"Stark",
      email: "tony@test.com",
      password: "asdf12",
      password_confirmation: "asdf12",
    )
      person.save!
      auth = User.authenticate_with_credentials(" " + person.email + " ", person.password)
      expect(auth).to eq person
    end
  end  
end  