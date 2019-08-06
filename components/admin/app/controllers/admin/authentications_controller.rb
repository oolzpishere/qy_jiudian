require_dependency "admin/application_controller"

module Admin
  class AuthenticationsController < ApplicationController
    def wechat
      auth = request.env['omniauth.auth']       # 引入回调数据 HASH
      data = auth.info                          # https://github.com/skinnyworm/omniauth-wechat-oauth2
      logger.info "#{data}"
      logger.info "raw info: #{auth.extra}"
    end
  end
end
