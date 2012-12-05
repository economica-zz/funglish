class Schedule < ActiveRecord::Base
  belongs_to :user, :conditions => {:deleted => false}
  belongs_to :lesson, :conditions => {:deleted => false}
  belongs_to :conversation_form, :class_name => "ConversationForm", :foreign_key => "conversation_form_id", :conditions => {:deleted => false}
  belongs_to :location_prefecture, :class_name => "Prefecture", :foreign_key => "location_prefecture_id", :conditions => {:deleted => false}

  has_many :guests, :conditions => {:deleted => false}

  attr_accessible :user_id, :start_timestamp, :end_timestamp, :time, :lesson_id, :conversation_form_id, :location_prefecture_id, :location_name, :location_reference_url, :maximum_number_of_guests, :message, :deleted
  attr_accessor :start_year, :start_month, :start_day

  validate :check_start_date
  validates :location_prefecture_id, :presence => true, :if => "conversation_form_id == ConversationForm::FACE_TO_FACE"
  validates :location_name, :presence => true, :if => "conversation_form_id == ConversationForm::FACE_TO_FACE"
  validates :location_name, :length => { :maximum => 255 }
  validates :location_reference_url, :length => { :maximum => 255 }
  validates :message, :length => { :maximum => 255 }

  def schedule_time(login_user)
    if TimeZone.convert_time_zone(start_timestamp, login_user, false).to_date == TimeZone.convert_time_zone(end_timestamp, login_user, false).to_date
      I18n.l(TimeZone.convert_time_zone(start_timestamp, login_user, false), :format => :ymdahm) + " - " + TimeZone.convert_time_zone(end_timestamp, login_user, false).strftime("%H:%M")
    else
      I18n.l(TimeZone.convert_time_zone(start_timestamp, login_user, false), :format => :ymdahm) + " - " + I18n.l(TimeZone.convert_time_zone(end_timestamp, login_user, false), :format => :ymdahm)
    end
  end

  private
  def check_start_date
    unless Date.valid_date?(@start_year, @start_month, @start_day)
      self.start_timestamp = nil
      errors.add(:start_timestamp, :invalid)
    end
  end
end
