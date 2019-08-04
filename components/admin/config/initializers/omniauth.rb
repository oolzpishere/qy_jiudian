
Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :wechat, ENV["QIANYANJICHU_APP_ID"], ENV["QIANYANJICHU_APP_SECRET"]
  # test account
  provider :wechat, ENV["WECHAT_TEST_APP_ID"], ENV["WECHAT_TEST_APP_SECRET"], :authorize_params => {:scope => "snsapi_base"}

end
