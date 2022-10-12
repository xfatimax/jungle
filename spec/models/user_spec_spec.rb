require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "is created with password and password_confirmation fields filled in" do
      @user = User.create(first_name: "Obi-Wan", last_name: "Kenobi" , email: "hellothere@gmail.com" , password: "highground", password_confirmation: "highground")
      @user.save!
      expect(@user).to be_valid
    end
    
    it "is valid if emails are unique" do
      @user1 = User.create(first_name: "Obi-Wan", last_name: "Kenobi" , email: "hellothere@gmail.com" , password: "highground", password_confirmation: "highground")
      @user1.save!
      
      @user2 = User.create(first_name: "General", last_name: "Grievous" , email: "hellothere@gmail.com" , password: "urabold1", password_confirmation: "urabold1")
      expect(@user2).not_to be_valid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end
    
    it "is not case sensitive when checking user email" do
      @user3 = User.create(first_name: "Sheev", last_name: "Palpatine" , email: "thesenate@gmail.com" , password: "xcuteorder66", password_confirmation: "xcuteorder66")
      @user3.save!
      
      @user3 = User.authenticate_with_credentials('THESENATE@GMAIL.COM', 'xcuteorder66')
      expect(@user3).not_to be (nil)
    end
    
    it "is not valid without email" do
      @user = User.create(first_name: "Obi-Wan", last_name: "Kenobi" , email: nil , password: "highground", password_confirmation: "highground")
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    
    it "is not valid without first_name" do
      @user = User.create(first_name: nil, last_name: "Kenobi" , email: "hellothere@gmail.com" , password: "highground", password_confirmation: "highground")
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    
    it "is not valid without last_name" do
      @user = User.create(first_name: "Obi-Wan", last_name: nil , email: "hellothere@gmail.com" , password: "highground", password_confirmation: "highground")
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    
    it "is not valid if a user's password is under 8 characters long" do
      @user = User.create(first_name: "Obi-Wan", last_name: nil , email: "hellothere@gmail.com" , password: "higrnd", password_confirmation: "higrnd")
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
    end
  end
  
  describe '.authenticate_with_credentials' do
    it "is valid if the user's email and password matches an existing user" do
      @user = User.create(first_name: "Obi-Wan", last_name: "Kenobi" , email: "hellothere@gmail.com" , password: "highground", password_confirmation: "highground")
      expect(User.authenticate_with_credentials('hellothere@gmail.com', 'highground')).to eq(@user)
    end
    
    it "is valid if the user enters their email with spaces before/after email address" do
      @user = User.create(first_name: "Obi-Wan", last_name: "Kenobi" , email: "hellothere@gmail.com" , password: "highground", password_confirmation: "highground")
      @user = User.authenticate_with_credentials(' hellothere@gmail.com ', 'highground')
      expect(@user).not_to be (nil)
      
    end

  end
end