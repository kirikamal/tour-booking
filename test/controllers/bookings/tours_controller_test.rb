require "test_helper"

class Bookings::ToursControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get bookings_tours_new_url
    assert_response :success
  end

  test "should get create" do
    get bookings_tours_create_url
    assert_response :success
  end
end
