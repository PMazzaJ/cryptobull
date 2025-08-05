require 'net/http'
require 'json'
require 'uri'

class CepController < ApplicationController
  def lookup
    zipcode = params[:zipcode]
    
    # Validate CEP format (8 digits)
    unless zipcode.match?(/\A\d{8}\z/)
      render json: { error: 'CEP deve ter 8 dígitos' }, status: :bad_request
      return
    end

    services_results = []

    # ViaCEP Service
    begin
      viacep_result = lookup_viacep(zipcode)
      services_results << {
        service_name: 'ViaCEP',
        response: viacep_result
      }
    rescue => e
      services_results << {
        service_name: 'ViaCEP',
        response: { error: e.message }
      }
    end

    # APICEP Service  
    begin
      apicep_result = lookup_apicep(zipcode)
      services_results << {
        service_name: 'APICEP',
        response: apicep_result
      }
    rescue => e
      services_results << {
        service_name: 'APICEP',
        response: { error: e.message }
      }
    end

    # Postmon Service
    begin
      postmon_result = lookup_postmon(zipcode)
      services_results << {
        service_name: 'Postmon',
        response: postmon_result
      }
    rescue => e
      services_results << {
        service_name: 'Postmon',
        response: { error: e.message }
      }
    end

    render json: {
      cep: zipcode,
      services: services_results
    }
  end

  private

  def lookup_viacep(zipcode)
    uri = URI("https://viacep.com.br/ws/#{zipcode}/json/")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.open_timeout = 5
    http.read_timeout = 5
    
    response = http.get(uri.path)
    
    if response.code == '200'
      result = JSON.parse(response.body)
      if result['erro']
        { error: 'CEP não encontrado' }
      else
        result
      end
    else
      { error: "HTTP #{response.code}" }
    end
  end

  def lookup_apicep(zipcode)
    uri = URI("https://api.cep.com.br/v1/#{zipcode}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.open_timeout = 5
    http.read_timeout = 5
    
    response = http.get(uri.path)
    
    if response.code == '200'
      JSON.parse(response.body)
    else
      { error: "HTTP #{response.code}" }
    end
  end

  def lookup_postmon(zipcode)
    uri = URI("http://api.postmon.com.br/v1/cep/#{zipcode}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.open_timeout = 5
    http.read_timeout = 5
    
    response = http.get(uri.path)
    
    if response.code == '200'
      JSON.parse(response.body)
    else
      { error: "HTTP #{response.code}" }
    end
  end
end