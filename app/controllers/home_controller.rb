class HomeController < ApplicationController
  layout 'home'

  def index
    authorize :home
  end

  def pro
    authorize :home
  end
end
