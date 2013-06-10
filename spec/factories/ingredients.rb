# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :ingredient do
    text "MyString"
    amount "9.99"
    food "MyString"
    unit "MyString"
    recipe_id 1
  end
end
