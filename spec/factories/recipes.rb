# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :recipe do
    name "Foo Fi Fo Fum Recipe Text"
    author "Aron Hegyi"
    published_on "2013-06-09"
    description "Take this string and shove it. <b>Bold</b>"
    instructions "Recipe instructions."
  end
end
