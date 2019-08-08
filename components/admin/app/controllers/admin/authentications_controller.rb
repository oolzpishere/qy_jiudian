require_dependency "admin/application_controller"

module Admin
  class AuthenticationsController < ApplicationController
    # skip_before_action :verify_authenticity_token, :authenticate_user!
    skip_before_action :authenticate_admin!
    def wechat
      auth = request.env['omniauth.auth']       # 引入回调数据 HASH
      logger.info "!!!!!raw info #{auth.raw_info}"
      data = auth.info                          # https://github.com/skinnyworm/omniauth-wechat-oauth2
      logger.info "#{data}"
      logger.info "raw info: #{auth.extra}"

      redirect_to "/user"
    end
  end
end
