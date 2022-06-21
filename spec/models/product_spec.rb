require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Columns' do
    it { should have_db_column(:name).of_type(:string) }
    it { should have_db_column(:code).of_type(:integer) }
    it { should have_db_column(:price).of_type(:integer) }
  end

  describe 'Associations' do
    it { should have_one(:stock_record) }
    it { should have_many(:cashbox_records) }
  end

  describe 'Validations' do
    it { should_not allow_value('').for(:name) }
    it { should allow_value('Cookie').for(:name) }
    it { should_not allow_value('price').for(:price) }
    it { should_not allow_value('some_code').for(:code) }
    it { should_not allow_value(-2).for(:price) }
  end
end
