require 'rails_helper'
RSpec.describe Tea, type: :model do
  describe 'relationships and validations' do
    it { should have_many :tea_subs }
    it { should have_many(:subscriptions).through(:tea_subs) }
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :temp }
    it { should validate_presence_of :brewtime }
  end
end
