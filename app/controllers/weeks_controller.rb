class WeeksController < ApplicationController
  def show
    @week = Week.find params[:id]
  end

  def index
    @weeks = Week.all
  end
end
