# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :blog_index do
    sequence(:id) {|n| "#{n}"}
    sequence(:title) {|n| "sample title #{n}" }
    sequence(:num_of_image) {|n| "#{n}"}
    sequence(:num_of_text) {|n| "#{n}"}

    trait :as_id_null do
      id nil
    end

    trait :as_title_null do
      title nil
    end

    trait :contents_id_null do
      num_of_image nil
    end

    trait :detail_id_null do
      num_of_text nil
    end
    
    trait :as_update_data do
      title "update_title"
    end
  end
#  factory :params ,class: BlogIndex do
#    "title" "テストのタイトル"
#  end
end
