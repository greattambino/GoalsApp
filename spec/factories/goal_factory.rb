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

FactoryGirl.define do
  factory :goal do
    title { Faker::Hacker.say_something_smart }
    user_id 1
    status "PENDING"
    public true
  end
end
