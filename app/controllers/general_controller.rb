class GeneralController < ApplicationController
  def index
    @week = Week.last
  end
end
