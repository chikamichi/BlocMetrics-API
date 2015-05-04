require 'faker'

# 1.times do
#   User.create!(
#     token: Faker::Internet.password
#   )
# end
#
# puts "Users total #{User.count}"

# users = User.all

# Create Apps

# puts "Total of #{User.count} users"
#
# 15.times do
#   App.create!(
#     user: users.sample,
#     domain: Faker::Internet.domain_name
#   )
# end
#
# puts "15 new apps created, for a total of #{App.count}"

apps = App.all

# Create Events

200.times do
  Event.create!(
    app: apps.sample,
    event: Faker::Name.name,
    url: Faker::Internet.domain_suffix,
    ip_address: Faker::Internet.ip_v4_address
  )
end

puts "200 Events created for a total of #{Event.count}"

# 10.times do
#   Event.create!(
#     domain: apps_last,
#     event: Faker::Name.name,
#     url: Faker::Internet.domain_suffix,
#     ip_address: Faker::Internet.ip_v4_address
#   )
# end
