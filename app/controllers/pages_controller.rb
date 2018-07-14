class PagesController < ApplicationController
  include HighVoltage::StaticPage

  before_action :authorize_content


  private

  def authorize_content
    authorize :pages, :show?
  end

end
