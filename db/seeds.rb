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

puts "Creating two line item dates..."
lineitemdate = 
LineItemDate.new( 
    restaurant: Restaurant.first, 
    date: Date.current
  )
  lineitemdate.save!

  lineitemdate = 
  LineItemDate.new(
    restaurant: Restaurant.second, 
    date: Date.current + 1.week
  )
  lineitemdate.save!
  puts "Finished!"

  puts "Creating four line items..."
  lineitem = 
  LineItem.new(
    line_item_date: LineItemDate.first,
    name: "Meeting room",
    description: "A cosy meeting room for 10 people", 
    quantity: 1, 
    unit_price: 1000, 
    # line_item_date_id: Restaurant.first
  )
  lineitem.save!
  lineitem = 
  LineItem.new(
    line_item_date: LineItemDate.second, 
    name: "Meal tray", 
    description: "Our delicious meal tray",
    quantity: 10,
    unit_price: 25,
    # line_item_date_id: Restaurant.second
  )
  lineitem.save!
  lineitem = 
  LineItem.new(
    line_item_date: LineItemDate.last, 
    name: "Meeting room", 
    description: "A cosy meeting room for 10 people",
    quantity: 1,
    unit_price: 1000,
    # line_item_date_id: Restaurant.third
  )
  lineitem.save!
  lineitem = 
  LineItem.new(
    line_item_date: LineItemDate.first, 
    name: "Delete",
    description: "Our delicious meal tray",
    quantity: 10,
    unit_price: 25,
    # line_item_date_id: Restaurant.last
  )
  lineitem.save!
  puts "...Finished!"