FactoryGirl.define do
  factory :event do
    domain "example.com"
    event "pageview"
    url "example.com/about"
    ip_address "1234567"
    application nil
  end
end
