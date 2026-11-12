require "test_helper"

class FlatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @flat = Flat.create!(
      name: "Light & Spacious Garden Flat London",
      address: "10 Clifton Gardens London W9 1DT",
      description: "A lovely summer feel for this spacious garden flat.",
      price_per_night: 75,
      number_of_guests: 3,
      picture_url: "https://images.unsplash.com/photo-1494526585095-c41746248156?auto=format&fit=crop&w=1200&q=80"
    )
    @second_flat = Flat.create!(
      name: "Sunny Loft in Shoreditch",
      address: "42 Redchurch Street London E2 7DP",
      description: "Minimalist industrial loft in East London.",
      price_per_night: 95,
      number_of_guests: 2,
      picture_url: "https://images.unsplash.com/photo-1560448204-e02f11c3d0e2?auto=format&fit=crop&w=1200&q=80"
    )
    @valid_params = {
      flat: {
        name: "Cozy Studio in Soho",
        address: "15 Dean Street London W1D 3RS",
        description: "A bright studio right in the center of Soho.",
        price_per_night: 120,
        number_of_guests: 2,
        picture_url: "https://images.unsplash.com/photo-1502672260266-1c1ef2d93688"
      }
    }
  end

  test "should get root and index" do
    get root_url
    assert_response :success
    assert_select "h2", text: @flat.name

    get flats_url
    assert_response :success
  end

  test "should filter index by query" do
    get flats_url, params: { query: "Shoreditch" }
    assert_response :success
    assert_select "h2", text: @second_flat.name
    assert_select "h2", text: @flat.name, count: 0
  end

  test "should show flat" do
    get flat_url(@flat)
    assert_response :success
    assert_select "h1", text: @flat.name
    assert_select "p", text: @flat.description
  end

  test "should get new" do
    get new_flat_url
    assert_response :success
  end

  test "should create flat with valid params" do
    assert_difference("Flat.count", 1) do
      post flats_url, params: @valid_params
    end

    assert_redirected_to flat_url(Flat.last)
  end

  test "should not create flat with invalid params" do
    assert_no_difference("Flat.count") do
      post flats_url, params: { flat: { name: "" } }
    end

    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_flat_url(@flat)
    assert_response :success
  end

  test "should update flat with valid params" do
    patch flat_url(@flat), params: { flat: { name: "Updated Flat Name" } }
    assert_redirected_to flat_url(@flat)
    assert_equal "Updated Flat Name", @flat.reload.name
  end

  test "should not update flat with invalid params" do
    patch flat_url(@flat), params: { flat: { name: "" } }
    assert_response :unprocessable_entity
    assert_not_equal "", @flat.reload.name
  end

  test "should destroy flat" do
    assert_difference("Flat.count", -1) do
      delete flat_url(@flat)
    end

    assert_redirected_to flats_url
  end
end
