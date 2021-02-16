# frozen_string_literal: true

module Freee
  module Pigmon
    class << self
      CALLBACK_URL  = 'urn:ietf:wg:oauth:2.0:oob'
      OAUTH2_SITE   = 'https://accounts.secure.freee.co.jp'
      OAUTH2_URL    = '/public_api/token'

      def url_to_generate_code(client_id)
        "https://accounts.secure.freee.co.jp/public_api/authorize?client_id=#{client_id}&redirect_uri=#{CALLBACK_URL}&response_type=code"
      end

      def fetch_token_from_code(client_id, client_secret, authrorize_code)
        client = oauth2_client(client_id, client_secret)
        response = client.auth_code.get_token(authrorize_code,
                                              redirect_uri: CALLBACK_URL)
        token_info_hash(response)
      end

      def token_refresh(
        client_id,
        client_secret,
        access_token,
        refresh_token,
        expires_at
      )
        return false if refresh_token.nil?

        client = oauth2_client(client_id, client_secret)
        oauth2_access_token = OAuth2::AccessToken.new(
          client,
          access_token,
          refresh_token: refresh_token,
          expires_at: expires_at.to_i
        )
        response = oauth2_access_token.refresh!
        token_info_hash(response)
      end

      def oauth2_client(client_id, client_secret)
        OAuth2::Client.new(client_id,
                           client_secret,
                           site: OAUTH2_SITE,
                           token_url: OAUTH2_URL)
      end

      def token_info_hash(response)
        {
          access_token: response.token,
          refresh_token: response.refresh_token,
          expires_at: Time.at(response.expires_at).strftime('%Y-%m-%d %H:%M:%S')
        }
      end
    end
  end
end
