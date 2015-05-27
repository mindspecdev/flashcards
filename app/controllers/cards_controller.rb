class CardsController < ApplicationController

  def index
    load_resources
  end

  def show
    load_resource
  end

  def new
    build_resource
  end

  def create
    build_resource
    save_resource or render 'new'
  end

  def edit
    load_resource
    build_resource
  end

  def update
    load_resource
    build_resource
    save_resource or render 'edit' 
  end

  def destroy
    load_resource
    @resource.destroy
    redirect_to cards_path
  end

  private

  def load_resources
    @resources ||= resource_scope.to_a
    respond_to do |format|
      format.html
      format.json
    end    
  end

  def load_resource
    @resource ||= resource_scope.find(params[:id])
  end

  def build_resource
    @resource ||= resource_scope.build
    @resource.attributes = resource_params
  end

  def save_resource
    if @resource.save
      redirect_to cards_path
    end
  end

  def resource_params
    resource_params = params[:card]
    resource_params ? resource_params.permit(:original_text, :translated_text, :review_date) : {}
  end

  def resource_scope
    Card.all
  end
end
