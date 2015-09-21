# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  session_token   :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  feature "password encryption" do
    scenario "does not save passwords to the database" do
      create_user = FactoryGirl.create(:user)
      save_user = User.find_by_username(create_user.username)

      expect(save_user.password).to_not eq(create_user.password)
    end

    scenario "encrypts the password using BCrypt" do
      expect(BCrypt::Password).to receive(:create)
      FactoryGirl.build(:user)
    end
  end

end
