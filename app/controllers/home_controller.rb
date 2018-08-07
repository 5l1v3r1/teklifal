class HomeController < ApplicationController
  layout :layout

  def index
    authorize :home
  end

  def pro
    authorize :home
  end

  private

  def layout
    I18n.locale == :ar ? 'home-arabic' : 'home'
  end
end
