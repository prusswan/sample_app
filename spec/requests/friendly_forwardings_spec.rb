require 'spec_helper'

describe "FriendlyForwardings" do

  it "should forward to the requested page after signin" do
    user = Factory(:user)
    visit edit_user_path(user)
    fill_in "Email",    :with => user.email
    fill_in "Password", :with => user.password
    click_button "Sign in"
    # response.should render_template('users/edit')
    page.should have_selector('title', text: 'Edit user')
    visit signout_path
    integration_sign_in(user)
    # response.should render_template('users/show')
    page.should have_selector('title', text: user.name)
  end

end
