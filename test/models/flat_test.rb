require "test_helper"

class FlatTest < ActiveSupport::TestCase
  setup do
    @valid_attributes = {
      name: "Light & Spacious Garden Flat London",
      address: "10 Clifton Gardens London W9 1DT",
      description: "A lovely summer feel for this spacious garden flat.",
      price_per_night: 75,
      number_of_guests: 3
    }
  end

  test "valid with all required attributes" do
    flat = Flat.new(@valid_attributes)
    assert flat.valid?
  end

  test "invalid without name" do
    flat = Flat.new(@valid_attributes.except(:name))
    assert_not flat.valid?
    assert_includes flat.errors[:name], "can't be blank"
  end

  test "invalid without address, description, price_per_night, or number_of_guests" do
    %i[address description price_per_night number_of_guests].each do |attr|
      flat = Flat.new(@valid_attributes.except(attr))
      assert_not flat.valid?, "Expected flat without #{attr} to be invalid"
    end
  end

  test "invalid with negative price or zero guests" do
    assert_not Flat.new(@valid_attributes.merge(price_per_night: -1)).valid?
    assert_not Flat.new(@valid_attributes.merge(number_of_guests: 0)).valid?
  end

  test "search filters by name or address case-insensitively" do
    london_flat = Flat.create!(@valid_attributes)
    shoreditch_flat = Flat.create!(
      name: "Sunny Loft in Shoreditch",
      address: "42 Redchurch Street London E2 7DP",
      description: "Minimalist industrial loft in East London.",
      price_per_night: 95,
      number_of_guests: 2
    )

    assert_equal [ shoreditch_flat ], Flat.search("shoreditch").to_a
    assert_equal [ london_flat ], Flat.search("clifton").to_a
  end
end
