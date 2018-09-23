class Api::V1::DictionariesController < ApplicationController
  before_action :set_dictionary, only: [:show, :update]

  # GET /dictionaries
  def index
    dictionaries = Dictionary.includes(:variants)
    json = Rails.cache.fetch(Dictionary.cache_key(dictionaries)) do
      dictionaries.to_json(include: :variants)
    end

    render json: json
  end

  # POST /dictionaries/translate
  def translate
    json = Rails.cache.fetch('translate') do
      Dictionary.includes(:variants).where(word: params[:word], 
        language: params[:from]).first.variants.where(language: params[:to]).pluck(:word)
    end

    render json: json
  end

  # GET /dictionaries/1
  def show
    render json: @dictionary
  end

  # POST /dictionaries
  def create
    @dictionary = Dictionary.new(dictionary_params)

    if @dictionary.save
      render json: @dictionary, status: :created
    else
      render json: @dictionary.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dictionaries/1
  def update
    if @dictionary.update(dictionary_params)
      render json: @dictionary
    else
      render json: @dictionary.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dictionary
      @dictionary = Dictionary.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def dictionary_params
      params.require(:dictionary).permit(:word, :language, { variant_ids: [] })
    end
end
