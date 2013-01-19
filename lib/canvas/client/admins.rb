require 'hashie'
module Canvas
  class Client
    # Defines methods related to users
    module Admins

      # Flag an existing user as an admin within the account.
      # 
      # @overload make_account_admin(account_id, unique_id, options={})
      #   @param account_id [Integer] A Canvas account ID
      #   @param user_id [Integer] The id of the user to promote.
      #   @option options [String] :role The role to give the user. Defaults to 'AccountAdmin'
      #   @option options [String] :send_confirmation Send a notification email to the new admin if set to '1'; send no email if set to '0'. Default is '1'. 
      #   @return TBD: Undocumented return value
      #   @example Make user with ID 101 an AccountAdmin for account ID 51.
      #     Canvas.make_account_admin(51, 101)
      # @format :json
      # @see https://canvas.instructure.com/doc/api/admins.html
      def make_account_admin(account_id, user_id, options={})
        h = Hashie::Mash.new
        h.user_id = unique_id
        h.role = options[:role] if options[:role]
        h.send_confirmation = options[:send_confirmation] if options[:send_confirmation]

        response = post("accounts/#{account_id}/admins", h)
        response
      end

    end
  end
end