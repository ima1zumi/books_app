# frozen_string_literal: true

module OmniauthHelper
  def set_omniauth(provider)
    OmniAuth.config.test_mode = true
    OmniAuth::AuthHash.new({
      provider: "#{provider}",
      uid: '123545',
      info: {
        email: "bob@example.com",
        name: "bob smith",
        nickname: "bob"}
        })
  end
end
