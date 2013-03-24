require 'spec_helper'

describe "Home" do
  it "should have sign up link" do
    visit root_path
    click_link "Sign Up"
  end
  it "should have login link" do
    visit root_path
    click_link "Sign In"
  end
end
