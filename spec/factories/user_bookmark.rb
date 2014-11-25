FactoryGirl.define do
  factory :user_bookmark do
    url 'http://example.com'
    user
  end
end
