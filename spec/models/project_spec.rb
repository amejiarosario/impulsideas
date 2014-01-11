require 'spec_helper'

describe Project do
  it { should belong_to(:user) }
  it { should have_many(:contributions) }

  let(:user) { FactoryGirl.create :user }
  let(:project) { FactoryGirl.create :project, funding_goal: 1000 }

  context '.funding_percentage' do
    it 'should have zero when no contribution' do
      project.funding_percentage.should be 0
    end

    it 'should calculate percentage when contributions' do
      project.contributions.create!({amount: 200, user: user, payment_status: 'ACTIVE' })
      project.funding_percentage.should be 20.0
    end
  end

  context '.total_contributed' do
    describe 'with no contributors' do
      it 'should be zero' do
        @project = FactoryGirl.create :project
        @project.total_contributed.should be 0.0
      end
    end

    describe 'with one contributor' do
      before :each do
        @project = FactoryGirl.create :project
        @project.contributions.create!({amount: 3.4, user_id: user.id, payment_status: 'ACTIVE' })
        @project.contributions.create!({amount: 7.5, user_id: user.id, payment_status: 'ACTIVE' })
        @project.save!
      end

      it 'gets total contributed' do
        @project.total_contributed.should == (3.4 + 7.5)
      end

      it 'get number of contributors' do
        @project.total_contributors.should == 1
      end
    end

    describe 'with multiple contributors' do
      before :each do
        @user = FactoryGirl.create :user
        @project = FactoryGirl.create :project
        @project.contributions.build({amount: 20, user_id: user.id, payment_status: 'ACTIVE'  })
        @project.contributions.build({amount: 7503, user_id: @user.id, payment_status: 'ACTIVE'  })
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
