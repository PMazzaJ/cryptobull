require 'test_helper'

class CepControllerTest < ActionDispatch::IntegrationTest
  test "should get lookup with valid cep" do
    # Test with a valid CEP format
    get '/cep/01310100'
    assert_response :success
    
    response_data = JSON.parse(response.body)
    assert_equal '01310100', response_data['cep']
    assert response_data['services'].is_a?(Array)
    assert_equal 3, response_data['services'].length
    
    # Check that each service has required fields
    response_data['services'].each do |service|
      assert service.key?('service_name')
      assert service.key?('response')
      assert ['ViaCEP', 'APICEP', 'Postmon'].include?(service['service_name'])
    end
  end

  test "should reject invalid cep format" do
    get '/cep/12345'  # Too short
    assert_response :bad_request
    
    response_data = JSON.parse(response.body)
    assert_equal 'CEP deve ter 8 dígitos', response_data['error']
  end

  test "should reject non-numeric cep" do
    get '/cep/abcd1234'
    # This should not match the route constraint and return 404
    assert_response :not_found
  end
end