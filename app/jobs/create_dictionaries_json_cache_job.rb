class CreateDictionariesJsonCacheJob < ApplicationJob
  queue_as :default

  def perform(*args)
    dictionaries = Dictionary.includes(:variants)
    Rails.cache.fetch(Dictionary.cache_key(dictionaries)) do
      dictionaries.to_json(include: :variants)
    end
  end
end
