FactoryBot.define do
  factory :product do
    name { 'Cookies' }
    code { 1 }
    price { 10 }

    trait :single do
      after(:create) do |product|
        create(:stock_record, product: product, quantity: 1)
      end
    end

    trait :affordable do
      transient do
        quantity { 1 }
      end
      after(:create) do |product|
        create(:stock_record, product: product, quantity: evaluator.quantity)
      end
    end

    trait :single_expensive do
      single
      after(:create) do |product|
        create(:stock_record, product: product, quantity: 1)
      end
    end
  end
end
