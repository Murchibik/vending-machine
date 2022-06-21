FactoryBot.define do
  factory :cashbox_record do
    transaction_direction { :income }
    amount { 120 }
    product_id { nil }
    comment { 'Initial setting for change' }
  end
end
