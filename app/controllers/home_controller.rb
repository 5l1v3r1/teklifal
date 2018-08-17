class HomeController < ApplicationController
  layout :layout, only: [:index]

  def index
    authorize :home
  end

  def pro
    authorize :home
  end

  private

  def layout
    'home-arabic'
  end
end
