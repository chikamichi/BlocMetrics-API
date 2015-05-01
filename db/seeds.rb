require 'faker'

# Create Apps

users = User.all

puts "Total of #{User.count} users"

15.times do
  App.create!(
    user: users.sample,
    domain: Faker::Internet.domain_name
    )
end

puts "15 new apps created, for a total of #{App.count}"


