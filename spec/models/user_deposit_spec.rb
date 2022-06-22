require 'rails_helper'

RSpec.describe UserDeposit, type: :model do
  describe 'Columns' do
    it { should have_db_column(:amount).of_type(:integer) }
  end

  describe 'Validations' do
    it { should_not allow_value(-10).for(:amount) }
  end
end
