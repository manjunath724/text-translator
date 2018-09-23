class Dictionary < ApplicationRecord
  has_and_belongs_to_many :variants, class_name: 'Dictionary', 
    join_table: 'variants', foreign_key: 'dictionary_a_id', 
    association_foreign_key: 'dictionary_b_id', touch: true, dependent: :destroy

  validates :word, :language, presence: true

  after_save :create_json_cache, :sync_variants

  def self.cache_key(dictionaries)
    {
      serializer: 'dictionaries',
      stat_record: dictionaries.maximum(:updated_at)
    }
  end

  private

  def create_json_cache
    CreateDictionariesJsonCacheJob.perform_later
  end

  def sync_variants
    variants.map { |d| d.variant_ids = (d.variant_ids + [id] - [d.id]).uniq.sort }
  end
end
