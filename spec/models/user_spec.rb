
RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(FactoryGirl.build(:user)).to be_valid
  end

  describe "public instance methods" do
    it "#full_name" do
      expect(FactoryGirl.build(:user)).to respond_to(:full_name)
    end

    context 'when called' do
      let(:user) { FactoryGirl.build(:user) }

      it 'returns user full name' do
        expect(user.full_name).to eq(user.first_name + ' ' + user.last_name)
      end
    end
  end
end
