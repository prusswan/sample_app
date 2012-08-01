require 'spec_helper'

describe "Users" do

  describe "signup" do

    describe "failure" do
      it "should not make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => ""
          fill_in "Email",        :with => ""
          fill_in "Password",     :with => ""
          fill_in "Confirmation", :with => ""
          click_button "Sign up"
          # response.should render_template('users/new')
          page.body.should have_selector('div#error_explanation')
        end.should_not change(User, :count)
      end
    end

    describe "success" do
      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => "Example User"
          fill_in "Email",        :with => "user@example.com"
          fill_in "Password",     :with => "foobar"
          fill_in "Confirmation", :with => "foobar"
          click_button "Sign up"
          page.body.should have_selector('div.flash.success',
                                        :text => "Welcome")
          # response.should render_template('users/show')
        end.should change(User, :count).by(1)
      end
    end

  end

  describe "signin" do

    describe "failure" do
      it "should not sign a user in" do
        visit signin_path
        fill_in "Email",    :with => ""
        fill_in "Password", :with => ""
        click_button "Sign in"
        page.body.should have_selector('div.flash.error',
                                      :text => "Invalid")
        # response.should render_template('sessions/new')
      end
    end

    describe "success" do
      it "should sign a user in and out" do
        user = FactoryGirl.create(:user)
        visit signin_path
        integration_sign_in(user)
        # controller.should be_signed_in
        page.body.should have_link('Sign out', href: signout_path)
        click_link "Sign out"
        # controller.should_not be_signed_in
        page.body.should have_link('Sign in', href: signin_path)
      end
    end

  end

  describe "follow/unfollow" do

    before(:each) do
      @user = FactoryGirl.create(:user)
      @other_user = FactoryGirl.create(:user, :email => FactoryGirl.generate(:email))
      visit signin_path
      integration_sign_in(@user)
    end

    it "should be able to follow and unfollow a user" do
      lambda do
        visit user_path(@other_user.id)
        page.body.should have_selector("input[value='Follow']")
        click_button "Follow"
        page.body.should have_selector("input[value='Unfollow']")
        click_button "Unfollow"
      end.should_not change(@user.following, :count)
    end

  end

end
