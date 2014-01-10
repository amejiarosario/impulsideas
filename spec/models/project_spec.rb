require 'spec_helper'

describe Project do
  it { should belong_to(:user) }
  it { should have_many(:contributions) }

  context '.total_contributed' do
    let(:user) { FactoryGirl.create :user }

    describe 'one contributor' do
      before :each do
        @project = FactoryGirl.create :project
        @project.contributions.build({amount: 3.4, user_id: user.id })
        @project.contributions.build({amount: 7.5, user_id: user.id })
        @project.save!
      end

      it 'gets total contributed' do
        @project.total_contributed.should == (3.4+7.5)
      end

      it 'get number of contributors' do
        @project.total_contributors.should == 1
      end
    end

    describe 'multiple contributors' do
      before :each do
        @user = FactoryGirl.create :user
        @project = FactoryGirl.create :project
        @project.contributions.build({amount: 20, user_id: user.id })
        @project.contributions.build({amount: 7503, user_id: @user.id })
        @project.save!
      end

      it 'gets total contributed' do
        @project.total_contributed.should == (7523)
      end

      it 'gets number of contributors' do
        @project.total_contributors.should == 2
      end
    end
  end
end
