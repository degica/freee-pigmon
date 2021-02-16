# frozen_string_literal: true

module Freee
  module Pigmon
    class APIClient
      HR_API_URL = 'https://api.freee.co.jp'

      attr_accessor :access_token

      def initialize(access_token)
        self.access_token = access_token
      end

      def fetch_user_info_hash
        response = request_api('/hr/api/v1/users/me', :get, nil)
        company_info_hash = response.body['companies'].first
        company_id = company_info_hash['id']
        employee_id = company_info_hash['employee_id']

        {
          company_id: company_id,
          employee_id: employee_id
        }
      end

      def check_available_time_clock_types(employee_id, company_id)
        path = "/hr/api/v1/employees/#{employee_id}/time_clocks/available_types"
        params = { company_id: company_id }
        response = request_api(path, :get, params)
        response.body['available_types']
      end

      def post_time_clock(employee_id, company_id, type)
        path = "/hr/api/v1/employees/#{employee_id}/time_clocks"
        params = { company_id: company_id, type: type }
        response = request_api(path, :post, params)
        response
      end

      def get_time_clocks(employee_id, company_id, from_date: nil, to_date: nil, per: nil, page: nil)
        path = "/hr/api/v1/employees/#{employee_id}/time_clocks"
        params = {
          company_id: company_id,
          from_date:  from_date,
          to_date:    to_date,
          per:        per,
          page:       page,
        }
        response = request_api(path, :get, params)
        response
      end

      def request_api(path, method, params)
        client = api_client
        response = client.send(method) do |req|
          req.url path
          req.body = params.to_json unless params.nil?
        end
        case response.status
        when 401
          raise 'Unauthorized'
        end
        response
      end

      def api_client
        client = Faraday.new(url: HR_API_URL) do |faraday|
          faraday.request :json
          faraday.response :json, content_type: /\bjson$/
          faraday.adapter Faraday.default_adapter
        end
        client.authorization :Bearer, access_token
        client
      end
    end
  end
end
