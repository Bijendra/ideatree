class HomesController < ApplicationController
  def index
  	@ideas = Assignment.all
  end
end
