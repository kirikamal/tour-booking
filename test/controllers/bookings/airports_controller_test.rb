require "test_helper"

class Bookings::AirportsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get bookings_airports_new_url
    assert_response :success
  end

  test "should get create" do
    get bookings_airports_create_url
    assert_response :success
  end
end
