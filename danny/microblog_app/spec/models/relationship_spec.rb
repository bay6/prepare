require 'spec_helper'

describe Relationship do
	let(:fan){FactoryGirl.create(:user)}
	let(:followed){FactoryGirl.create(:user)}
	let(:relationship){fan.relationships.build(followed_id: followed.id)}
	subject {  relationship }

	it { should be_valid }
	
	describe "follow method" do
		it { should respond_to(:fan) }
		it { should respond_to(:followed) }
		its(:fan) { should eq fan }
		its(:followed) { should eq followed }
	end

	describe "when followed is not present" do
		before { relationship.followed_id = nil }
		it { should_not be_valid }
	end

	describe "when fan is not present" do
		before { relationship.fan_id = nil }
		it { should_not be_valid }
	end

end
