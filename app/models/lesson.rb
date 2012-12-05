class Lesson < ActiveRecord::Base
  belongs_to :course, :conditions => {:deleted => false}
  belongs_to :main_lesson, :class_name => "Lesson", :foreign_key => "main_lesson_id", :conditions => {:deleted => false}

  attr_accessible :course_id, :number, :name, :price, :cloudinary_public_id, :description, :is_released, :scheduled_release_date, :release_date, :panda_video_id, :is_main_lesson, :main_lesson_id, :deleted

  def get_price
    if is_released
      if price == 0
        I18n.t("free")
      else
        price.to_s + I18n.t("yen")
      end
    else
      I18n.l(scheduled_release_date) + " " + I18n.t("release_scheduled")
    end
  end

  def get_price_class
    if is_released
      if price == 0
        "label-info"
      else
        "label-important"
      end
    else
      ""
    end
  end

  def lesson_label
    lesson_label = ""

    if number == 0
      lesson_label = I18n.t("trial_lesson")
    else
      lesson_label = I18n.t("lesson") + number.to_s
    end

    if !is_main_lesson
      lesson_label += I18n.t("complementary_lesson")
    end

    lesson_label
  end

  def full_lesson_name
    course.name + I18n.t("space_zenkaku") + lesson_label + I18n.t("space_zenkaku") + name
  end

  class << self
    def get_choices
      cache_key = "Lesson" + Utils::CACHE_KEY_CHOICES

      choices = Rails.cache.read(cache_key)

      if choices.blank?
        choices = [[I18n.t("lesson_nashi_free_talk"), nil]] + Lesson.where(is_main_lesson: true, deleted: false).order("number, id").map {|i| [i.full_lesson_name, i.id]}
        Rails.cache.write(cache_key, choices, :expires_in => 1.hour)
      end

      choices
    end
  end
end
