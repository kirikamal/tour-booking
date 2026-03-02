require "test_helper"

class BookingsControllerTest < ActionDispatch::IntegrationTest
  test "should get confirmation" do
    get bookings_confirmation_url
    assert_response :success
  end
end
