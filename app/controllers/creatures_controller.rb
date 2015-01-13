class CreaturesController < ApplicationController
  before_action :locate_creature, only: [:edit, :update, :show, :destroy]
  def new
    @creature = Creature.new

  end

  def index
    @creature_list = Creature.all
    # @error = @creature_list.errors.messages
  end

  def edit

    # @creature = Creature.find(params[:id]) # not needed because I"m calling a before method
  end

  def create

    @creature = Creature.new(creature_params)

    if @creature.save
      flash[:success] = "Your creature has been added."
      redirect_to @creature
    else
      @errors = flash_messages(@creature.errors.messages)
      render 'new'
    end
  end

 def update

    # @creature = Creature.find(params[:id]) # not needed because I have a before statement

    if @creature.update(creature_params)
      redirect_to @creature

    else
      render 'edit'
    end
  end

  def show
    # @creature = Creature.find_by_id(params[:id]) # not needed because I have a before statement
      not_found unless @creature
    @search = @creature.name
    list = flickr.photos.search :text => @search, :sort => 'relevance'

    @results = list.map do |photo|
      [FlickRaw.url_s(photo),
      FlickRaw.url_b(photo)]
    end
  end

  def destroy
     # @creature = Creature.find(params[:id]) # not needed because of the before statement
     @creature.destroy
     redirect_to @creature
  end

    private

    def creature_params
      params.require(:creature).permit(:name, :desc)
    end

    def locate_creature
      redirect_to '/404.html' unless  @creature = Creature.find_by_id(params[:id])
    end

    def flash_messages message
      if message
        flash[:success] = message
        return flash[:success]
      end
  end
end # end of class CreaturesController