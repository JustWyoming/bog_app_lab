class HomeController < ApplicationController

  def index
    @creature = Creature.all
     @tags = Tag.select("tags.*,count(creatures.id) AS creature_count").joins(:creatures).group("tags.id").order("creature_count DESC").limit(15)
     @tags.to_a.shuffle!
     #Tag.all


  end
end