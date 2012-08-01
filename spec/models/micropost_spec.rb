# == Schema Information
# Schema version: 20120121084609
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Micropost do

  before(:each) do
    @user = Factory(:user)
    @attr = { :content => "lorem ipsum" }
  end

  it "should create a new instance with valid attributes" do
    @user.microposts.create!(@attr)
  end

  describe "user associations" do

    before(:each) do
      @micropost = @user.microposts.create(@attr)
    end

    it "should have a user attribute" do
      @micropost.should respond_to(:user)
    end

    it "should have the right associated user" do
      @micropost.user_id.should == @user.id
      @micropost.user.should == @user
    end

  end

  describe "validations" do

    it "should have a user id" do
      Micropost.new(@attr).should_not be_valid
    end

    it "should require nonblank content" do
      @user.microposts.build(:content => "    ").should_not be_valid
    end

    it "should reject long content" do
      @user.microposts.build(:content => "a" * 141).should_not be_valid
    end

  end

  describe "from_users_followed_by" do

    before(:each) do
      @other_user = Factory(:user, :email => Factory.next(:email))
      @third_user = Factory(:user, :email => Factory.next(:email))

      @user_post  = @user.microposts.create!(:content => "foo")
      @other_post = @other_user.microposts.create!(:content => "bar")
      @third_post = @third_user.microposts.create!(:content => "baz")

      @user.follow!(@other_user)
    end

    it "should have a from_users_followed_by method" do
      Micropost.should respond_to(:from_users_followed_by)
    end

    it "should include the followed user's microposts" do
      Micropost.from_users_followed_by(@user).
        should include(@other_post)
    end

    it "should include the user's own microposts" do
      Micropost.from_users_followed_by(@user).
        should include(@user_post)
    end

    it "should not include an unfollowed user's microposts" do
      Micropost.from_users_followed_by(@user).
        should_not include(@third_post)
    end

  end

  describe "tests for Rails 3.2 tutorial" do

    let(:user) { FactoryGirl.create(:user) }
    before { @micropost = user.microposts.build(content: "Lorem ipsum") }

    subject { @micropost }

    it { should respond_to(:content) }
    it { should respond_to(:user_id) }
    it { should respond_to(:user) }
    its(:user) { should == user }

    it { should be_valid }

    describe "when user_id is not present" do
      before { @micropost.user_id = nil }
      it { should_not be_valid }
    end

    describe "with blank content" do
      before { @micropost.content = " " }
      it { should_not be_valid }
    end

    describe "with content that is too long" do
      before { @micropost.content = "a" * 141 }
      it { should_not be_valid }
    end

    describe "from_users_followed_by" do

      let(:user)       { FactoryGirl.create(:user) }
      let(:other_user) { FactoryGirl.create(:user) }
      let(:third_user) { FactoryGirl.create(:user) }

      before { user.follow!(other_user) }

      let(:own_post)        {       user.microposts.create!(content: "foo") }
      let(:followed_post)   { other_user.microposts.create!(content: "bar") }
      let(:unfollowed_post) { third_user.microposts.create!(content: "baz") }

      subject { Micropost.from_users_followed_by(user) }

      it { should include(own_post) }
      it { should include(followed_post) }
      it { should_not include(unfollowed_post) }

    end

  end

end
