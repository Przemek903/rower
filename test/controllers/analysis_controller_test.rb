require 'test_helper'

class AnalysisControllerTest < ActionController::TestCase
  test "should get availability" do
    get :availability
    assert_response :success
  end

end
