puts "Destroying companies..."
Company.destroy_all
Company.create!(
  name: "kpmg"
)
Company.create!(
  name: "pwc"
)
puts "Finished!"
puts "Destroying restaurants..."
Restaurant.destroy_all
puts "Creating restaurants..."
Restaurant.create!(
  name: "Le Dindon en Laisse",
  address: "18 Rue Beautreillis, 75004 Paris, France", 
  company: Company.first
)
Restaurant.create!(
  name: "Neuf et Voisins",
  address: "Van Arteveldestraat 1, 1000 Brussels, Belgium", 
  company: Company.second
)
puts "Finished!"

User.destroy_all

puts 'Creating 3 fake users...'
user =
  User.new(
    email: "accountant@kpmg.com", 
    password: 'password',
    company: Company.first
  )
user.save!

user =
  User.new(
    email: 'manager@kpmg.com',
    password: 'password',
    company: Company.first
  )
user.save!

user =
  User.new(
    email: 'eavesdropper@pwc.com',
    password: 'password',
    company: Company.second
  )
user.save!
puts "Finished!"