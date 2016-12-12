# == Schema Information
#
# Table name: goals
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  title        :string           not null
#  description  :text             not null
#  is_private   :boolean          not null
#  is_completed :boolean          not null
#

require 'rails_helper'

RSpec.describe Goal, type: :model do

  it { should validate_presence_of(:user)}
  it { should validate_presence_of(:title)}
  it { should validate_presence_of(:description)}
  it { should validate_presence_of(:is_private)}
  it { should validate_presence_of(:is_completed)}

it { should belong_to(:user)}
end
