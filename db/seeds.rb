require 'faker'

# 1.times do
#   User.create!(
#     token: Faker::Internet.password
#   )
# end
#
# puts "Users total #{User.count}"

users = User.all

# Create Apps

puts "Total of #{User.count} users"

# Create Events

100.times do
  Event.create!(
    domain: Faker::Internet.domain_name,
    event: Faker::Name.name,
    url: Faker::Internet.domain_suffix,
    ip_address: Faker::Internet.ip_v4_address
  )
end

puts "100 new events created, for a total of #{Event.count}"
