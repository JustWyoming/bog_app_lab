class TagsController < ApplicationController

  def new
    @tags = Tag.new
    @creature = Creature.all

  end

  def create

    @tags = Tag.new(tag_params)
    @tags.save
    flash[:success] = "Your tag has been added."
    redirect_to '/creatures'

  end

private

  def tag_params
    params.require(:tag).permit(:name)
  end


end
