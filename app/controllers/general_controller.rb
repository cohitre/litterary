class GeneralController < ApplicationController
  def index
    @weeks = Week.all
  end
end
