# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :blog_index do
    sequence(:id) {|n| "#{n}"}
    title "BLOG TEST TITLE"
    contents_id 1
    sequence(:detail_id) {|n| "#{n}"}
  end
end
