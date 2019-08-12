module Admin
  module ApplicationHelper
    autoload :DeviseHelper,        'devise_helper'

    def render_field(form, field)
      render partial: field.to_partial_path, locals: {form: form, field: field}
    end



  end
end
