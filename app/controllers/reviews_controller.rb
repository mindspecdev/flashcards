class ReviewsController < ApplicationController

  def edit
    load_card
    build_card
  end

  def upate
    load_card
    build_card
    save_card or render 'edit' 
  end

  private

  def load_card
    @card ||= card_scope.order("RANDOM()").first
  end

  def build_card
    @card ||= card_scope.build
    @card.attributes = card_params
  end

  def save_card
    if @card.save
      redirect_to root_path
    end
  end

  def card_params
    card_params = params[:card]
    card_params ? card_params.permit(:original_text, :translated_text, :review_date, :entered_translated_text) : {}
  end

  def card_scope
    Card.need_review
  end  

end