module Admin
  module DeviseHelper

    def login_type_user?(path)
      login_type(path) == "user"
    end

    def login_type_admin?(path)
      login_type(path) == "admin"
    end

    def login_type(path)
      case
      when path.match("/users/sign_in")
        return "user"
      when path.match("/admins/sign_in")
        return "admin"
      end
    end




  end
end
