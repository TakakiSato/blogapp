# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :blog_image, :class => 'BlogImage' do
    sequence(:id) {|n| "#{n}"}
    blog_index_id 1
    sequence(:image_id ) {|n| "#{n}"}
    sequence(:image) {|n| "/#{n}/#{n}/test.jpg" }
    #sequence(:image) {|n| File.open("spec/file/test#{n}.jpg") }
    trait :as_id_null do
      id nil
    end

    trait :contents_id_null do
      blog_index_id nil
    end

    trait :detail_id_null do
      image_id nil
    end

    trait :as_image_null do
      image nil
    end

    trait :as_update_data do
      image "/update/update/update.jpg"
    end

  end
end
