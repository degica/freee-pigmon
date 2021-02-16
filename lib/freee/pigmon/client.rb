# frozen_string_literal: true
require 'freee/pigmon/api_client'

module Freee
  module Pigmon
    class Client
      attr_accessor :client_id, :client_secret

      def initialize(client_id, client_secret)
        self.client_id = client_id
        self.client_secret = client_secret
      end

      def url_to_generate_code
        Freee::Pigmon.url_to_generate_code(self.client_id)
      end

      def fetch_token_hash(authorize_code)
        token_info_hash = Freee::Pigmon.fetch_token_from_code(client_id, client_secret, authorize_code)
        token_info_hash
      end

      def refresh_access_token(access_token, refresh_token, expires_at)
        token_info_hash = Freee::Pigmon.token_refresh(
          access_token,
          refresh_token,
          expires_at
        )
        token_info_hash
      end

      def fetch_freee_user_info_hash(access_token)
        api_client(access_token).fetch_user_info_hash
      end

      # =========================

      def clock_in(access_token, employee_id, company_id)
        api_client(access_token).post_time_clock(
          employee_id,
          company_id,
          'clock_in'
        )
      end

      def clocked_in?(access_token, employee_id, company_id)
        available_types = api_client(access_token)
                          .check_available_time_clock_types(
                            employee_id,
                            company_id
                          )
        available_types.include? 'clock_out'
      end

      def break_begin(access_token, employee_id, company_id)
        api_client(access_token).post_time_clock(
          employee_id,
          company_id,
          'break_begin'
        )
      end

      def break_end(access_token, employee_id, company_id)
        api_client(access_token).post_time_clock(
          employee_id,
          company_id,
          'break_end'
        )
      end

      def clock_out(access_token, employee_id, company_id)
        api_client(access_token).post_time_clock(
          employee_id,
          company_id,
          'clock_out'
        )
      end

      def get_clocks(access_token, employee_id, company_id, from_date: nil, to_date: nil, per: nil, page: nil)
        api_client(access_token).get_time_clocks(
          employee_id,
          company_id,
          from_date: from_date,
          to_date: to_date,
          per: per,
          page: page
        )
      end

      private

      def api_client(access_token)
        Freee::Pigmon::APIClient.new(access_token)
      end
    end
  end
end
