require 'hashie'
module Canvas
  class Client
    # Defines methods related to users
    module Users
      # Returns extended information of a given user
      #
      # @overload user(id=nil, options={})
      #   @param user [Integer] An Canvas user ID
      #   @return [Hashie::Mash] The requested user.
      #   @example Return extended information for @shayne
      #     Canvas.user(20)
      # @format :json
      # @authenticated false unless requesting it from a protected user
      #
      #   If getting this data of a protected user, you must authenticate (and be allowed to see that user).
      # @rate_limited true
      # @see TODO:docs url
      def user(*args)
        id = args.first
        response = get("users/#{id}")
        response
      end

      # Returns extended information of a given user
      #
      # @overload user(id=nil, options={})
      #   @param user [Integer] An Canvas user ID
      #   @return [Hashie::Mash] The requested user.
      #   @example Return extended information for @shayne
      #     Canvas.user(20)
      # @format :json
      # @authenticated false unless requesting it from a protected user
      #
      #   If getting this data of a protected user, you must authenticate (and be allowed to see that user).
      # @rate_limited true
      # @see TODO:docs url
      def user_profile(*args)
        id = args.first || 'self'
        response = get("users/#{id}/profile")
        response.first
      end

      def account(*args)
        id = args.first
        response = get("accounts/#{id}")
        response
      end

      # Creates a user under a given account ID
      #
      # @overload create_user(account_id, unique_id, options={})
      #   @param account_id [Integer] A Canvas account ID
      #   @param unique_id [String] The login_id for the new user (email address)
      #   @option options [String] :name The name of the user's account
      #   @option options [String] :short_name The nick name of the user's account
      #   @option options [String] :locale The user's preferred language (two-letter ISO 639-1 code)
      #   @option options [String] :send_confirmation Send user notification of account creation
      #   @option options [String] :password User's password
      #   @option options [String] :sis_user_id SIS ID for the user’s account
      #   @return [Hashie::Mash] The user created.
      #   @example Creates a new user account ID 51 with unique ID 'thedude@example.com'
      #     Canvas.create_user(51, "thedude@example.com",
      #                                    :name => "The Dude",
      #                                    :sis_user_id => '12345678')
      # @format :json
      # @see TODO:docs url
      def create_user(account_id, unique_id, options={})

        h = Hashie::Mash.new
        h.user!.name = options[:name] if options[:name]
        h.user!.short_name = options[:short_name] if options[:short_name]
        h.user!.time_zone = options[:time_zone] if options[:time_zone]
        h.user!.locale = options[:locale] || "en"
        h.pseudonym!.unique_id = unique_id
        h.pseudonym!.send_confirmation = options[:send_confirmation] || '1' # default to true
        h.pseudonym!.password = options[:password] if options[:password]
        h.pseudonym!.sis_user_id = options[:sis_user_id] if options[:sis_user_id]
        
        response = post("accounts/#{account_id}/users", h)
        response
      end
    end
  end
end