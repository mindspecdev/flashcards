class CardsController < ApplicationController

  def index
    load_cards
  end

  def show
    load_card
  end

  def new
    build_card
  end

  def create
    build_card
    save_card or render 'new'
  end

  def edit
    load_card
    build_card
  end

  def update
    load_card
    build_card
    save_card or render 'edit' 
  end

  def destroy
    load_card
    @card.destroy
    redirect_to cards_path
  end

  private

  def load_cards
    @cards ||= card_scope.to_a
    respond_to do |format|
      format.html
      format.json
    end    
  end

  def load_card
    @card ||= card_scope.find(params[:id])
  end

  def build_card
    @card ||= card_scope.build
    @card.attributes = card_params
  end

  def save_card
    if @card.save
      redirect_to cards_path
    end
  end

  def card_params
    card_params = params[:card]
    card_params ? card_params.permit(:original_text, :translated_text, :review_date) : {}
  end

  def card_scope
    Card.all
  end
end
