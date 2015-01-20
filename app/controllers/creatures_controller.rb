class CreaturesController < ApplicationController
  before_action :locate_creature, only: [:edit, :update, :show, :destroy]
  def new
    @creature = Creature.new
    @tags = Tag.all


  end

  def index
    @creature_list = Creature.all
    @tags = Tag.all
    # @error = @creature_list.errors.messages
  end

  def edit
    @tags = Tag.all

    # @creature = Creature.find(params[:id]) # not needed because I"m calling a before method
  end

  def create
    # @new = @creature.tags.create(tag_params)
    @creature = Creature.new(creature_params)
    @tags = Tag.all

    if @creature.save
     @creature.tags.clear
     tags = params[:creature][:tag_ids].split(",")
     tags.each do |tag_id|
      @creature.tags << Tag.find_or_create_by({name:tag_id}) unless tag_id.blank?
    end
    flash[:success] = "Your creature has been added."
    redirect_to @creature
  else
    @errors = flash_messages(@creature.errors.messages)
    render 'new'
  end
end

def update
  # @creature = Creature.find(params[:id])
  @tags = Tag.all
    # @creature = Creature.find(params[:id]) # not needed because I have a before statement

    if @creature.update(creature_params)

       #this will help integrate tags into our form/update after the update of the creature
       #it will also work in create

       @creature.tags.clear
       tags = params[:creature][:tag_ids].split(",")
       tags.each do |tag_id|

        @creature.tags << Tag.find_or_create_by({name:tag_id}) unless tag_id.blank?
      end
      flash[:success] = "Thank you for editing #{@creature.name}."
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

    def tag
     tag = Tag.find_by_name(params[:tag])
     @creature =  tag ? tag.creatures : []
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

  def tag_params
    params.require(:tag).permit(:name)
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