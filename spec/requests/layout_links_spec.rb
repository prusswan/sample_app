require 'spec_helper'

describe "LayoutLinks" do

  it "should have a Home page at '/'" do
    get '/'
    response.body.should have_selector('title', :text => "Home")
  end

  it "should have a Contact page at '/contact'" do
    get '/contact'
    response.body.should have_selector('title', :text => "Contact")
  end

  it "should have an About page at '/about'" do
    get '/about'
    response.body.should have_selector('title', :text => "About")
  end

  it "should have a Help page at '/help'" do
    get '/help'
    response.body.should have_selector('title', :text => "Help")
  end

  it "should have a signup page at '/signup'" do
    get '/signup'
    response.body.should have_selector('title', :text => "Sign up")
  end

  it "should have a signin page at '/signin'" do
    get '/signin'
    response.body.should have_selector('title', :text => "Sign in")
  end

  it "should have the right links on the layout" do
    visit root_path
    page.body.should have_selector('title', :text => "Home")
    click_link "About"
    page.body.should have_selector('title', :text => "About")
    click_link "Contact"
    page.body.should have_selector('title', :text => "Contact")
    click_link "Home"
    page.body.should have_selector('title', :text => "Home")
    click_link "Sign up now!"
    page.body.should have_selector('title', :text => "Sign up")
    page.body.should have_selector('a[href="/"]>img')
  end

  describe "when not signed in" do
    it "should have a signin link" do
      visit root_path
      page.body.should have_selector("a", :href => signin_path,
                                          :text => "Sign in")
    end
  end

  describe "when signed in" do

    before(:each) do
      @user = Factory(:user)
      visit signin_path
      integration_sign_in(@user)
    end

    it "should have a signout link" do
      visit root_path
      page.body.should have_selector("a", :href => signout_path,
                                          :text => "Sign out")
    end

    it "should have a profile link" do
      visit root_path
      page.body.should have_selector("a", :href => user_path(@user),
                                          :text => "Profile")
    end

    it "should have a settings link" do
      visit root_path
      page.body.should have_selector("a", :href => edit_user_path(@user),
                                          :text => "Settings")
    end

    it "should have a users link" do
      visit root_path
      page.body.should have_selector("a", :href => users_path,
                                          :text => "Users")
    end

  end

end
