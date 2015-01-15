class HomeController < ApplicationController

  def index
     @tags = Tag.all
     @creature = Creature.all
  end
end