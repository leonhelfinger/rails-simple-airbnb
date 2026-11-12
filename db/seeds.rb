# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

flats = [
  {
    name: "Light & Spacious Garden Flat London",
    address: "10 Clifton Gardens London W9 1DT",
    description: "A lovely summer feel for this spacious garden flat. Two double bedrooms, open plan living area, large kitchen and a beautiful conservatory.",
    price_per_night: 75,
    number_of_guests: 3,
    picture_url: "https://images.unsplash.com/photo-1494526585095-c41746248156?auto=format&fit=crop&w=1200&q=80"
  },
  {
    name: "Stylish House Close to River Thames",
    address: "5 Queensmill Road London SW6 6JP",
    description: "Bright Victorian terrace minutes from the river path. Features a sunny patio, modern kitchen, and comfortable workspace.",
    price_per_night: 110,
    number_of_guests: 4,
    picture_url: "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=1200&q=80"
  },
  {
    name: "St Pancras Clock Tower Guest Suite",
    address: "Euston Rd London N1C 4QP",
    description: "A unique high-ceiling suite steps from King's Cross St Pancras, ideal for travelers looking for character and convenience.",
    price_per_night: 145,
    number_of_guests: 2,
    picture_url: "https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?auto=format&fit=crop&w=1200&q=80"
  },
  {
    name: "Sunny Loft in Shoreditch",
    address: "42 Redchurch Street London E2 7DP",
    description: "Minimalist industrial loft in the heart of East London with floor-to-ceiling windows, exposed brick, and rooftop access.",
    price_per_night: 95,
    number_of_guests: 2,
    picture_url: "https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?auto=format&fit=crop&w=1200&q=80"
  }
]

flats.each do |attributes|
  flat = Flat.find_or_initialize_by(name: attributes[:name])
  flat.update!(attributes)
end
