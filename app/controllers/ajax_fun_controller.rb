class AjaxFunController < ApplicationController
  def change
    @rails_version = Rails::VERSION::STRING
  end
end
