require 'spec_helper'

describe "Static pages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1',    text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:page_title) { 'Home' }
    let(:heading)    { 'Sample App' }

    it_should_behave_like "all static pages"

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in(user)
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end

      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before { user.follow!(other_user) }

        it { should have_selector('a', href: following_user_path(user),
                                       content: "0 following") }
        it { should have_selector('a', href: followers_user_path(user),
                                       content: "1 follower") }
      end
    end
  end

  describe "Help page" do
    before { visit help_path }
    let(:page_title) { 'Help' }
    let(:heading)    { page_title }

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }
    let(:page_title) { 'About' }
    let(:heading)    { page_title }

    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }
    let(:page_title) { 'Contact' }
    let(:heading)    { page_title }

    it_should_behave_like "all static pages"
  end

end
