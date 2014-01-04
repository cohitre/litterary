class GeneralController < ApplicationController
  def index
    @weeks = Week.order("created_at DESC")
  end
end
