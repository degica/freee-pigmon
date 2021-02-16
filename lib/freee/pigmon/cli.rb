# frozen_string_literal: true

require 'thor'

module Freee
  module Pigmon
    class CLI < Thor

      desc 'set_client {id} {secret}', 'set client_id and client_secret'
      def set_client(client_id, client_secret)
        Freee::Pigmon.configure(
          freee_client_id: client_id,
          freee_client_secret: client_secret
        )
      end

      desc 'authorize {authorize_code}', 'set authorized code and set up.'
      def authorize(authorize_code)
        token_hash = pigmon.fetch_token_hash(authorize_code)
        Freee::Pigmon.configure(
          access_token: token_hash[:access_token],
          refresh_token: token_hash[:refresh_token],
          expires_at: token_hash[:expires_at]
        )
        user_info_hash = pigmon.fetch_freee_user_info_hash(access_token)
        Freee::Pigmon.configure(
          employee_id: user_info_hash[:employee_id],
          company_id: user_info_hash[:company_id]
        )
      end

      desc 'generate_code', 'display generate_code url'
      def generate_code
        puts Freee::Pigmon.url_to_generate_code(client_id)
      end

      desc 'clock_in', 'send clock_in request to freee.'
      def clock_in
        token_refresh if token_expired?
        puts pigmon.clock_in(access_token, employee_id, company_id).body
      end

      desc 'break_begin', 'send break_begin request to freee.'
      def break_begin
        token_refresh if token_expired?
        puts pigmon.break_begin(access_token, employee_id, company_id).body
      end

      desc 'break_end', 'send break_end request to freee.'
      def break_end
        token_refresh if token_expired?
        puts pigmon.break_end(access_token, employee_id, company_id).body
      end

      desc 'clock_out', 'send clock_out request to freee.'
      def clock_out
        token_refresh if token_expired?
        puts pigmon.clock_out(access_token, employee_id, company_id).body
      end

      private

      def pigmon
        Freee::Pigmon::Client.new(client_id, client_secret)
      end

      def client_id
        Freee::Pigmon.config[:freee_client_id]
      end

      def client_secret
        Freee::Pigmon.config[:freee_client_secret]
      end

      def access_token
        Freee::Pigmon.config[:access_token]
      end

      def refresh_token
        Freee::Pigmon.config[:refresh_token]
      end

      def expires_at
        Freee::Pigmon.config[:expires_at]
      end

      def employee_id
        Freee::Pigmon.config[:employee_id]
      end

      def company_id
        Freee::Pigmon.config[:company_id]
      end

      def token_expired?
        return false if expires_at.nil?

        Time.parse(expires_at) <= Time.now
      end

      def token_refresh
        token_hash = Freee::Pigmon.token_refresh(
          client_id,
          client_secret,
          access_token,
          refresh_token,
          expires_at
        )

        Freee::Pigmon.configure(
          access_token: token_hash[:access_token],
          refresh_token: token_hash[:refresh_token],
          expires_at: token_hash[:expires_at]
        )
      end

      def warn_to_get_code
        puts "Get code from here: #{url_to_generate_code}\n"
        true
      end

      def token_is_ok_message
        puts 'You already prepared token. No problem.'
        true
      end
    end
  end
end
