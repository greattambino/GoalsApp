require 'spec_helper'
require 'rails_helper'

feature "Goals" do
  feature "Index page" do
    given(:other_user) { FactoryGirl.create(:user) }
    given(:public_goals) { make_goals(other_user) }
    given(:user) { FactoryGirl.create(:user) }

    scenario "shows own goals when signed in" do
      sign_in(user)
      goals = make_goals(user)
      visit goals_url

      expect(page).to have_content(goals.first)
    end

    scenario "shows public goals when signed out" do
      public_goals
      visit goals_url

      expect(page).to have_content(public_goals.first)
    end

    scenario "does not show other users' private goals" do
      private_goal = FactoryGirl.create(
                          :goal,
                          public: false,
                          user_id: other_user.id
                     )
      sign_in(user)

      expect(page).to_not have_content(private_goal.title)
    end
  end

  feature "Creating new goals" do
    scenario "validates goal title" do
      new_goal = FactoryGirl.build(:goal, title: "")
      new_goal.save

      expect(new_goal).to_not be_valid
    end
  end
end
