# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.find_or_create_by(email: "admin@busappy.com") do |u|
  u.name = "admin"
  u.password = "Password@123!"
  u.password_confirmation = "Password@123!"
end

@user = User.find_by_email("admin@busappy.com")
@user.add_role :admin if @user.roles.blank?