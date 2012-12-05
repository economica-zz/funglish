class TimeZone < ActiveRecord::Base
  JAPAN = 664

  attr_accessible :name, :dst, :utc_offset, :disp_seq, :deleted

  def name_for_disp
    dst_str = ""

    if dst
      dst_str = "(DST)"
    end

    name + dst_str + " UTC" + utc_offset
  end

  class << self
    def get_choices
      cache_key = "TimeZone" + Utils::CACHE_KEY_CHOICES

      choices = Rails.cache.read(cache_key)

      if choices.blank?
        choices = TimeZone.where(deleted: false).order("disp_seq").map {|i| [i.name_for_disp, i.id]}
        Rails.cache.write(cache_key, choices, :expires_in => 1.hour)
      end

      choices
    end

    def current_time(user)
      if user.blank?
        return Time.current.in_time_zone("Tokyo")
      end

      if user.time_zone.utc_offset[0..0] == "+"
        return (Time.current.in_time_zone("UTC") + user.time_zone.utc_offset[1..2].to_i.hours + user.time_zone.utc_offset[4..5].to_i.minutes)
      else
        return (Time.current.in_time_zone("UTC") - user.time_zone.utc_offset[1..2].to_i.hours - user.time_zone.utc_offset[4..5].to_i.minutes)
      end
    end

    def convert_time_zone(timestamp, user, is_to_utc)
      if user.blank?
        return timestamp
      end

      if is_to_utc
        if user.time_zone.utc_offset[0..0] == "+"
          return (timestamp - user.time_zone.utc_offset[1..2].to_i.hours - user.time_zone.utc_offset[4..5].to_i.minutes)
        else
          return (timestamp + user.time_zone.utc_offset[1..2].to_i.hours + user.time_zone.utc_offset[4..5].to_i.minutes)
        end
      else
        if user.time_zone.utc_offset[0..0] == "+"
          return (timestamp + user.time_zone.utc_offset[1..2].to_i.hours + user.time_zone.utc_offset[4..5].to_i.minutes)
        else
          return (timestamp - user.time_zone.utc_offset[1..2].to_i.hours - user.time_zone.utc_offset[4..5].to_i.minutes)
        end
      end
    end
  end
end
