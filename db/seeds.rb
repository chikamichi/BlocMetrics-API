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

app = App.find(1)

# Create Events

10.times do
  Event.create!(
    app: app,
    event: 'signed_up',
    url: Faker::Internet.domain_suffix,
    ip_address: Faker::Internet.ip_v4_address
  )
end

6.times do
  Event.create!(
    app: app,
    event: 'pageview',
    url: Faker::Internet.domain_suffix,
    ip_address: Faker::Internet.ip_v4_address
  )
end

8.times do
  Event.create!(
    app: app,
    event: 'click',
    url: Faker::Internet.domain_suffix,
    ip_address: Faker::Internet.ip_v4_address
  )
end

3.times do
  Event.create!(
    app: app,
    event: 'new_list',
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
