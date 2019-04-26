class AddOnboardingTextToTrack < ActiveRecord::Migration[5.1]
  def change
    add_column :tracks, :onboarding_text, :string
    add_column :tracks, :onboarding_subtext, :string
  end
end
