fred = User.create(username: 'fred', email: 'fred@test.com', password: 'fred', 
  password_confirmation: 'fred')
betty = User.create(username: 'betty', email: 'betty@test.com', 
  password: 'betty', password_confirmation: 'betty')

apartment = Property.create(name: 'Apartment', address: '5389 Evanston', 
  city: 'Indianapolis', state: 'IN', zip: '46220')

one_a = Unit.create(name: '1a', square_feet: 1000, property: apartment)
two_a = Unit.create(name: '2a', square_feet: 1100, property: apartment)

lease_fred = Lease.create(start_date: Date.today, 
  end_date: Date.today + 1.year, unit: one_a, renters: [fred])
lease_betty = Lease.create(start_date: Date.today, 
  end_date: Date.today + 1.year, unit: two_a, renters: [betty])

repair_request = RepairRequest.create(open_date: Date.today - 2.days, 
  close_date: Date.today, submitter: fred, responder: betty)