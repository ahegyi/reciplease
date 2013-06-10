# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recipe do
    name "MyString"
    author "MyString"
    published_on "2013-06-09"
    description "MyText"
    instructions "MyText"
  end
end
