@user = User.new(
  name: "Admin",
  email: "example@railstutorial.org",
  password: "foobar",
  password_confirmation: "foobar",
  role: 1,
  phone_number: "0123456789",
)
@user.skip_confirmation!
@user.save!

50.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  phone_number = Faker::PhoneNumber.cell_phone
  address = Faker::Address.street_address
  password = "password"
  @user = User.new(
    name: name,
    email: email,
    address: address,
    role: 0,
    phone_number: phone_number,
    password: password,
  )
  @user.skip_confirmation!
  @user.save!
end

Category.create!(name: "Hamberger" )
Category.create!(name: "Sanwich")
Category.create!(name: "Banh My")
Category.create!(name: "Ga KFC")
Category.create!(name: "Cafe")
Category.create!(name: "Thuc uong co ga")

12.times do
  Product.create!(
    name: Faker::Lorem.sentence(5),
    price: Faker::Number.between(10, 900),
    description: Faker::Lorem.paragraph(5),
    image_link: Rails.root.join("app/assets/images/hamberger.jpeg").open,
    quantity: Faker::Number.between(1, 90),
    category_id: 1
  )
end

12.times do
  Product.create!(
    name: Faker::Lorem.sentence(5),
    price: Faker::Number.between(10, 900),
    description: Faker::Lorem.paragraph(5),
    image_link: Rails.root.join("app/assets/images/sandwich.jpeg").open,
    quantity: Faker::Number.between(1, 90),
    category_id: 2
  )
end

12.times do
  Product.create!(
    name: Faker::Lorem.sentence(5),
    price: Faker::Number.between(10, 900),
    description: Faker::Lorem.paragraph(5),
    image_link: Rails.root.join("app/assets/images/banhmy.jpeg").open,
    quantity: Faker::Number.between(1, 90),
    category_id: 3
  )
end

12.times do
  Product.create!(
    name: Faker::Lorem.sentence(5),
    price: Faker::Number.between(10, 900),
    description: Faker::Lorem.paragraph(5),
    image_link: Rails.root.join("app/assets/images/gakfc.jpeg").open,
    quantity: Faker::Number.between(1, 90),
    category_id: 4
  )
end

12.times do
  Product.create!(
    name: Faker::Lorem.sentence(5),
    price: Faker::Number.between(10, 900),
    description: Faker::Lorem.paragraph(5),
    image_link: Rails.root.join("app/assets/images/coffe.jpeg").open,
    quantity: Faker::Number.between(1, 90),
    category_id: 5
  )
end

12.times do
  Product.create!(
    name: Faker::Lorem.sentence(5),
    price: Faker::Number.between(10, 900),
    description: Faker::Lorem.paragraph(5),
    image_link: Rails.root.join("app/assets/images/cocacola.jpeg").open,
    quantity: Faker::Number.between(1, 90),
    category_id: 6
  )
end
