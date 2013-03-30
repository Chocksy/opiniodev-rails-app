require 'spec_helper'

describe "Home" do
  it "should have sign in link" do
    visit root_path
    page.should have_content "Sign in"
  end
end
