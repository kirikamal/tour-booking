# Seed data for Prasanna Tours & Transport
# Run with: bin/rails db:seed

puts "Seeding database..."

# ── Admin User ──────────────────────────────────────────────────────────────
AdminUser.find_or_create_by!(email: "admin@prasannatours.com.au") do |u|
  u.password = "admin123!"
  u.password_confirmation = "admin123!"
end
puts "  ✓ Admin user: admin@prasannatours.com.au / admin123!"

# ── Tours ────────────────────────────────────────────────────────────────────
tours_data = [
  {
    name: "Blue Mountains Day Trip",
    description: "Experience the dramatic scenery of the Blue Mountains World Heritage Area. Visit the iconic Three Sisters, Echo Point lookout, and Scenic World with breathtaking valley views. This full-day adventure includes stops at Leura village for coffee and shopping, Wentworth Falls, and the stunning Jamison Valley.",
    price_cents: 7500,
    duration: "1 Day",
    departure_time: "7:00 AM",
    pickup_location: "Parramatta Station",
    max_passengers: 13,
    featured_image_url: "https://images.unsplash.com/photo-1489824904134-891ab64532f1?auto=format&fit=crop&w=900&q=80",
    active: true,
    position: 1
  },
  {
    name: "Canberra Day Trip",
    description: "Discover Australia's capital city on this informative and enjoyable day tour. Visit the Australian War Memorial, Parliament House, National Gallery of Australia, and Lake Burley Griffin. A perfect blend of history, culture, and architecture — all in one day from Sydney.",
    price_cents: 11500,
    duration: "1 Day",
    departure_time: "6:00 AM",
    pickup_location: "Parramatta Station",
    max_passengers: 13,
    featured_image_url: "https://images.unsplash.com/photo-1524820197278-540916411e20?auto=format&fit=crop&w=900&q=80",
    active: true,
    position: 2
  },
  {
    name: "Jervis Bay Day Trip",
    description: "Escape to one of Australia's most pristine coastal destinations. Jervis Bay boasts some of the whitest sand in the world, crystal-clear turquoise waters, and abundant wildlife including dolphins, sea eagles, and kangaroos. Visit Hyams Beach, Huskisson village, and Booderee National Park.",
    price_cents: 11000,
    duration: "1 Day",
    departure_time: "6:30 AM",
    pickup_location: "Parramatta Station",
    max_passengers: 13,
    featured_image_url: "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=900&q=80",
    active: true,
    position: 3
  },
  {
    name: "Kiama & South Coast",
    description: "Explore the charming coastal town of Kiama and its famous Blowhole, then venture through stunning South Coast scenery. Visit Minnamurra Rainforest, the historic Jamberoo, Kiama Lighthouse, and enjoy fresh seafood at the harbour. A perfect mix of natural beauty and local culture.",
    price_cents: 9500,
    duration: "1 Day",
    departure_time: "7:00 AM",
    pickup_location: "Parramatta Station",
    max_passengers: 13,
    featured_image_url: "https://images.unsplash.com/photo-1540202404-a2f29016b523?auto=format&fit=crop&w=900&q=80",
    active: true,
    position: 4
  },
  {
    name: "Nelson Bay & Port Stephens",
    description: "Head north to the magnificent Port Stephens bay area — famous for its resident dolphin pods, pristine beaches, and the towering Stockton Sand Dunes. Experience a dolphin-watching cruise, quad biking on the dunes, and time to relax on the beautiful Fingal Bay or Shoal Bay beaches.",
    price_cents: 11000,
    duration: "1 Day",
    departure_time: "6:30 AM",
    pickup_location: "Parramatta Station",
    max_passengers: 13,
    featured_image_url: "https://images.unsplash.com/photo-1519046904884-53103b34b206?auto=format&fit=crop&w=900&q=80",
    active: true,
    position: 5
  },
  {
    name: "Snowy Mountains Adventure",
    description: "Journey to the rooftop of Australia — the magnificent Snowy Mountains and Kosciuszko National Park. In summer, explore alpine wildflower meadows and crystal-clear streams. In winter, experience the magic of Australia's premier ski resorts. Visit Thredbo, Charlotte Pass, and Lake Jindabyne.",
    price_cents: 25000,
    duration: "1 Day",
    departure_time: "5:30 AM",
    pickup_location: "Parramatta Station",
    max_passengers: 13,
    featured_image_url: "https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=900&q=80",
    active: true,
    position: 6
  }
]

tours_data.each do |attrs|
  Tour.find_or_create_by!(name: attrs[:name]) do |t|
    t.assign_attributes(attrs)
  end
end
puts "  ✓ #{Tour.count} tours created"

# ── Vehicles ──────────────────────────────────────────────────────────────────
vehicles_data = [
  { name: "Toyota Camry (Sedan)", vehicle_type: "Sedan",   capacity: 4,  description: "Comfortable executive sedan, perfect for airport transfers and small groups.", available: true, position: 1 },
  { name: "Toyota Kluger (SUV)",  vehicle_type: "SUV",     capacity: 7,  description: "Spacious 7-seater SUV with generous luggage space. Great for family trips.", available: true, position: 2 },
  { name: "Toyota HiAce (Van)",   vehicle_type: "Van",     capacity: 13, description: "Full-size van for medium groups. Air-conditioned with individual seating.", available: true, position: 3 },
  { name: "Hyundai iMax (Van)",   vehicle_type: "Van",     capacity: 8,  description: "8-seater people-mover with reclining seats and extra comfort features.", available: true, position: 4 },
  { name: "Rosa Minibus",         vehicle_type: "Minibus", capacity: 24, description: "24-seat minibus for larger groups, school excursions, and corporate events.", available: true, position: 5 }
]

vehicles_data.each do |attrs|
  Vehicle.find_or_create_by!(name: attrs[:name]) do |v|
    v.assign_attributes(attrs)
  end
end
puts "  ✓ #{Vehicle.count} vehicles created"

# ── Reviews ───────────────────────────────────────────────────────────────────
blue_mountains = Tour.find_by(name: "Blue Mountains Day Trip")
jervis_bay     = Tour.find_by(name: "Jervis Bay Day Trip")
canberra       = Tour.find_by(name: "Canberra Day Trip")

reviews_data = [
  { author_name: "Sarah M.",    rating: 5, body: "Absolutely incredible experience! The Blue Mountains tour was breathtaking. Our driver was so knowledgeable and made the whole day so special. Will definitely book again!",                        tour: blue_mountains, approved: true },
  { author_name: "James K.",    rating: 5, body: "Prasanna Tours exceeded all expectations. The Jervis Bay trip was the highlight of our Sydney visit. Stunning beaches, amazing wildlife, and a fantastic guide. 100% recommend!",              tour: jervis_bay,     approved: true },
  { author_name: "Priya N.",    rating: 5, body: "We booked the airport transfer and it was seamless. Driver was on time, vehicle was spotless, and he helped with all our luggage. Will always use Prasanna Tours for our airport runs.",         tour: nil,            approved: true },
  { author_name: "Tom W.",      rating: 5, body: "Went to Canberra for the first time and it was amazing. Our guide knew everything about Australian history and politics. The War Memorial was incredibly moving. Great value for money.",           tour: canberra,       approved: true },
  { author_name: "Mei L.",      rating: 5, body: "My family of 6 hired the HiAce van for a day trip and it was perfect. Spacious, comfortable, and our driver was like a local friend showing us his favourite spots. Highly recommended!",      tour: nil,            approved: true },
  { author_name: "David P.",    rating: 4, body: "Very professional service from start to finish. The Snowy Mountains tour was long but worth every minute. Stunning scenery. Only minor suggestion: an earlier bathroom stop would be helpful.",  tour: nil,            approved: true },
  { author_name: "Aisha R.",    rating: 5, body: "Used Prasanna Tours three times now — Blue Mountains, airport transfer, and vehicle hire. Every single experience has been top notch. Punctual, friendly, and very reasonable prices.",           tour: blue_mountains, approved: true },
  { author_name: "Michael B.",  rating: 5, body: "Took my parents on the Jervis Bay tour for Mum's birthday and it was magical. The dolphins were incredible and the beach was like something from a postcard. Thank you Prasanna Tours!",          tour: jervis_bay,     approved: true }
]

reviews_data.each do |attrs|
  Review.find_or_create_by!(author_name: attrs[:author_name], body: attrs[:body].first(50)) do |r|
    r.assign_attributes(attrs)
  end
end
puts "  ✓ #{Review.count} reviews created"

puts "\nDatabase seeded successfully! 🎉"
puts "Admin login: admin@prasannatours.com.au / admin123!"
