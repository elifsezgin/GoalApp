# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do

  # good_user = FactoryGirl.build(:user)
  it { should validate_presence_of(:username)}
  it { should validate_presence_of(:password_digest)}
  it { should validate_presence_of(:session_token)}
  it { should validate_length_of(:password).is_at_least(6)}

  subject(:kathy) {User.new(username: "kalu", password: "123456")}

  describe "::find_by_credentials" do
    before(:all) do
      User.create(username: "kalu", password: "123456")
      @kathy = User.find_by_username("kalu")
    end
    context 'with valid credentials' do
      it "returns user" do
        user = User.find_by_credentials('kalu', '123456')
        expect(user).to eq(@kathy)
      end
    end
    context 'with invalid credentials' do
      it 'returns nil' do
        user =  User.find_by_credentials('kalu', '1qweqwe23456')
        expect(user).to be_nil
      end
    end
  end

  describe "#password=" do
    it "sets the password_digest" do
      expect(kathy.password_digest).to_not be_nil
    end
  end

  describe "#is_password?" do
    it "returns true if password is correct" do
      expect(kathy.is_password?("123456")).to be_truthy
    end

    it "returns false if password is incorrect" do
      expect(kathy.is_password?("12344e234fsdfsd56")).to be_falsey
    end
  end

  it "creates a session token after initialization" do
    # kathy.valid?
    expect(kathy.session_token).to_not be_nil
  end

  describe "#reset_session_token!" do
    it "resets session token" do
      old_token = kathy.session_token
      kathy.reset_session_token!
      expect(old_token).to_not eq(kathy.session_token)
    end
  end


end
