require './lib/sms'

module Administration
  class BaseController < ApplicationController
    layout "administration"

    before_action :authorize_dasboard

    def show
    end

  private

    def authorize_dasboard
      authorize :dashboard, :show?
    end

  end
end