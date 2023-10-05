module Mutations
  class SignInUser < BaseMutation
    null true

    argument :credentials, Types::AuthProviderCredentialsInput, required: false

    field :token, String, null: true
    field :user, Types::UserType, null: true

    def resolve(credentials: nil)
      return unless credentials
      
      user = User.find_by email: credentials[:email]
      
      return unless user
      return unless user.authenticate(credentials[:password])

      secret_key_base = ENV['SECRET_KEY_BASE']
      if secret_key_base.nil? || secret_key_base.empty?
        raise "Secret key not set. Make sure to set the MY_APP_SECRET_KEY_BASE environment variable."
      end

      # use Ruby on Rails - ActiveSupport::MessageEncryptor, to build a token
      crypt = ActiveSupport::MessageEncryptor.new(secret_key_base.byteslice(0..31))
      token = crypt.encrypt_and_sign("user-id:#{ user.id }")

      { user: user, token: token }
    end
  end
end