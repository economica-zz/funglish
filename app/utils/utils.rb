class Utils
  CACHE_KEY_CHOICES = "_choices"

  class << self
    def get_choices(class_name, order)
      cache_key = class_name + CACHE_KEY_CHOICES

      choices = Rails.cache.read(cache_key)

      if choices.blank?
        choices = get_mst_records(class_name, order).map {|i| [i.name, i.id]}
        Rails.cache.write(cache_key, choices, :expires_in => 1.hour)
      end

      choices
    end

    def get_mst_records(class_name, order)
      class_name.constantize.where(deleted: false).order(order)
    end
  end
end
