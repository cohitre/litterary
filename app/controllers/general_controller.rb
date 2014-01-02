class GeneralController < ApplicationController

  def index
    @week = Week.last
  end

  def help

  end
end
