require 'spec_helper'

describe PagesController do

  render_views

  before(:each) do
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  describe "GET 'home'" do

    describe "when not signed in" do
      it "returns http success" do
        get 'home'
        response.should be_success
      end

      it "should have the right title" do
        get 'home'
        response.body.should have_selector("title",
                                           :text => "#{@base_title} | Home")
      end

      it "should have a non-blank body" do
        get 'home'
        response.body.should_not =~ /<body>\s*<\/body>/
      end
    end

    describe "when signed in" do
      before(:each) do
        @user = test_sign_in(Factory(:user))
        @other_user = Factory(:user, :email => Factory.next(:email))
        @other_user.follow!(@user)
      end

      it "should have the right follower/following counts" do
        get :home
        response.body.should have_link('0 following', :href => following_user_path(@user))
        response.body.should have_link('1 follower', :href => followers_user_path(@user))
      end

      it "should not have delete links to microposts of other users" do
        Factory(:micropost, :user => @other_user)
        @user.follow!(@other_user)
        get :home
        response.should_not have_selector('a', :href => user_path(@other_user),
                                               :content => "delete")
      end

      it "should show the correct micropost count" do
        Factory(:micropost, :user => @user)
        get :home
        response.body.should have_selector('span.microposts', :text => "1 micropost")
        Factory(:micropost, :user => @user)
        get :home
        response.body.should have_selector('span.microposts', :text => "2 microposts")
      end
    end

  end

  describe "GET 'contact'" do
    it "returns http success" do
      get 'contact'
      response.should be_success
    end
    it "should have the right title" do
      get 'contact'
      response.body.should have_selector("title",
                                         :text => "#{@base_title} | Contact")
    end
  end

  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end
    it "should have the right title" do
      get 'about'
      response.body.should have_selector("title",
                                         :text => "#{@base_title} | About")
    end
  end

  describe "GET 'help'" do
    it "returns http success" do
      get 'help'
      response.should be_success
    end
    it "should have the right title" do
      get 'help'
      response.body.should have_selector("title",
                                         :text => "#{@base_title} | Help")
    end
  end
end
