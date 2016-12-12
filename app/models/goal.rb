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

class Goal < ActiveRecord::Base

  belongs_to :user

  validates :title, :description, :user, :is_private, :is_completed, presence: true

  after_initialize :ensure_default_bools

  private

  def ensure_default_bools
    self.is_private ||= false
    self.is_completed ||= false
  end

end
