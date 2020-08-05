require 'spec_helper'

feature 'sessions#welcome', js: true do
  scenario 'is accessible' do
    visit '/'
    expect(page).to be_accessible
  end
end