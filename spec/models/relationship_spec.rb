# == Schema Information
# Schema version: 20120121180243
#
# Table name: relationships
#
#  id          :integer         not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Relationship do

  before(:each) do
    @follower = FactoryGirl.create(:user)
    @followed = FactoryGirl.create(:user, :email => FactoryGirl.generate(:email))

    @attr = { :followed_id => @followed.id }
  end

  it "should create a new instance with valid attributes" do
    @follower.relationships.create!(@attr)
  end

  describe "follow methods" do

    before(:each) do
      @relationship = @follower.relationships.create!(@attr)
    end

    it "should have a follower attribute" do
      @relationship.should respond_to(:follower)
    end

    it "should have the right follower" do
      @relationship.follower.should == @follower
    end

    it "should have a followed attribute" do
      @relationship.should respond_to(:followed)
    end

    it "should have the right followed user" do
      @relationship.followed.should == @followed
    end

  end

  describe "validations" do

    it "should require a follower id" do
      Relationship.new(@attr).should_not be_valid
    end

    it "should require a followed id" do
      @follower.relationships.build.should_not be_valid
    end

  end

  describe "user associations" do

    before(:each) do
      @relationship = @follower.relationships.create!(@attr)
    end

    it "should destroy associated relationships when user is destroyed" do
      lambda do
        @follower.destroy
      end.should change(Relationship, :count).by(-1)
    end

    it "should destroy reverse relationships when user is destroyed" do
      lambda do
        @follower.destroy
      end.should change(@followed.followers, :count).by(-1)
    end

  end

  describe "tests for Rails 3.2 tutorial" do

    let(:follower) { FactoryGirl.create(:user) }
    let(:followed) { FactoryGirl.create(:user) }
    let(:relationship) do
      follower.relationships.build(followed_id: followed.id)
    end

    subject { relationship }

    it { should be_valid }

    describe "follower methods" do
      before { relationship.save }

      it { should respond_to(:follower) }
      it { should respond_to(:followed) }
      its(:follower) { should == follower }
      its(:followed) { should == followed }
    end

    describe "when followed id is not present" do
      before { relationship.followed_id = nil }
      it { should_not be_valid }
    end

    describe "when follower id is not present" do
      before { relationship.follower_id = nil }
      it { should_not be_valid }
    end

  end

end
