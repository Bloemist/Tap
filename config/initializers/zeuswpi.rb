require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Zeuswpi < OmniAuth::Strategies::OAuth2

      option :provider_ignores_state, true

      # Give your strategy a name.
      option :name, "zeuswpi"

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, {
        site:          "https://kelder.zeus.ugent.be",
        authorize_url: "/oauth/oauth2/authorize/",
        token_url:     "/oauth/oauth2/token/",
      }

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid{ raw_info['username'] }

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/oauth/api/current_user/').parsed
      end
    end
  end
end
