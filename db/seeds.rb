# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
m_user = megan.users.create(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'megan@example.com', password: 'securepassword')
b_user = brian.users.create(name: 'Neeru', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'neeru@example.com', password: 'test1234')
jon = User.create(name: 'Jon Snow', address: '123 Wall St', city: 'Wall', state: 'North of Winterfell', zip: 80218, email: 'jon@nightswatch.com', password: 'youknownothing')
dany = User.create(name: 'Daenerys Targaryen', address: '123 Fire St', city: 'Dragonstone', state: 'In The Sea', zip: 80348, email: 'dany@mother_of_dragons.com', password: 'dracarys')

#discounts
megan.discounts.create(percent: 5, quantity: 10)
megan.discounts.create(percent: 10, quantity: 10)
megan.discounts.create(percent: 15, quantity: 20)
brian.discounts.create(percent: 5, quantity: 10)
brian.discounts.create(percent: 20, quantity: 25)
brian.discounts.create(percent: 10, quantity: 20)

#items
ogre = megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 50 )
nessie = megan.items.create!(name: 'Nessie', description: "I'm a Loch Monster!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 50 )
giant = brian.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 30 )
hippo = brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 20 )

#orders
order_1 = jon.orders.create!(status: "pending")
order_2 = dany.orders.create!(status: "pending")
order_1.order_items.create!(item: hippo, price: hippo.price, quantity: 5, fulfilled: false)
order_1.order_items.create!(item: nessie, price: nessie.price, quantity: 10, fulfilled: false)

order_2.order_items.create!(item: giant, price: hippo.price, quantity: 20, fulfilled: false)
order_2.order_items.create!(item: ogre, price: ogre.price, quantity: 2, fulfilled: false)
