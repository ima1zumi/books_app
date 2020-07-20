# frozen_string_literal: true

require "test_helper"
require "supports/signin_helper"
require "supports/omniauth_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include SigninHelper
  include OmniauthHelper

  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]
end
