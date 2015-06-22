# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :blog_text, :class => 'BlogText' do
    sequence(:id) {|n| "#{n}"}
    blog_index_id 1
    sequence(:text_id) {|n| "#{n}"}
    sequence(:text) {|n| "sample text #{n}" }

    trait :as_id_null do
      id nil
    end

    trait :contents_id_null do
      index_id nil
    end

    trait :detail_id_null do
      text_id nil
    end

    trait :as_text_null do
      text nil
    end

    trait :as_update_data do
      text "update text"
    end
    
  end
end
