require "test_helper"

class Bookings::VehiclesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get bookings_vehicles_new_url
    assert_response :success
  end

  test "should get create" do
    get bookings_vehicles_create_url
    assert_response :success
  end
end
