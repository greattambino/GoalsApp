# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  user_id    :integer          not null
#  status     :string           not null
#  public     :boolean          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Goal < ActiveRecord::Base
  validates :title, :user_id, :status, presence: true
  validates :status, inclusion: { in: %w(COMPLETE PENDING) }
  validates :public, inclusion: { in: [true, false] }

  belongs_to :user
end

#overriding the matrix won't do anything, we need to transmit the open-source USB capacitor!
