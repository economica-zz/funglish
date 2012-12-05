require 'mail'

class User < ActiveRecord::Base
  belongs_to :sex, :conditions => {:deleted => false}
  belongs_to :nationality_country, :class_name => "Country", :foreign_key => "nationality_country_id", :conditions => {:deleted => false}
  belongs_to :occupation, :conditions => {:deleted => false}
  belongs_to :location_country, :class_name => "Country", :foreign_key => "location_country_id", :conditions => {:deleted => false}
  belongs_to :location_prefecture, :class_name => "Prefecture", :foreign_key => "location_prefecture_id", :conditions => {:deleted => false}
  belongs_to :time_zone, :class_name => "TimeZone", :foreign_key => "time_zone_id", :conditions => {:deleted => false}

  attr_accessible :last_name, :first_name, :last_name_kana, :first_name_kana, :sex_id, :birthday, :nationality_country_id, :occupation_id, :location_country_id, :location_prefecture_id, :location_city, :time_zone_id, :email_address, :telephone_number, :skype_name, :google_account, :self_introduction, :facebook_id, :facebook_link, :terms_of_service_id, :privacy_policy_id, :deleted, :is_email_address_confirmed, :email_address_confirmation_code
  attr_accessor :terms_of_service_and_privacy_policy, :birthday_1i, :birthday_2i, :birthday_3i

  validates :last_name, :presence => true, :length => { :maximum => 255 }
  validates :first_name, :presence => true, :length => { :maximum => 255 }
  validates :last_name_kana, :presence => true, :length => { :maximum => 255 }
  validates :first_name_kana, :presence => true, :length => { :maximum => 255 }
  validates :sex_id, :presence => true
  validate :check_birthday
  validates :nationality_country_id, :presence => true
  validates :occupation_id, :presence => true
  validates :location_country_id, :presence => true
  validates :location_prefecture_id, :presence => true
  validates :location_city, :length => { :maximum => 255 }
  validates :time_zone_id, :presence => true
  validates :email_address, :presence => true, :length => { :maximum => 255 }
  validate :check_email_address_validness
  validate :check_email_address_existence
  validates :telephone_number, :length => { :maximum => 255 }
  validates :skype_name, :length => { :maximum => 255 }
  validates :google_account, :length => { :maximum => 255 }
  validates :self_introduction, :length => { :maximum => 1200 }
  validates_acceptance_of :terms_of_service_and_privacy_policy, :if => Proc.new{|p| p.new_record?}

  def user_name
    last_name + " " + first_name
  end

  def user_name_kana
    last_name_kana + " " + first_name_kana
  end

  def user_name_add_kana
    user_name + I18n.t("beginning_parenthesis") + user_name_kana + I18n.t("ending_parenthesis")
  end

  private
  def check_birthday
    if birthday.blank?
      if birthday_1i.present? || birthday_2i.present? || birthday_3i.present?
        errors.add(:birthday, :invalid)
      end
    end
  end

  def check_email_address_validness
    if email_address.present?
      begin
        m = Mail::Address.new(email_address)
        r = m.domain && m.address = email_address
        t = m.__send__(:tree)
        r &&= (t.domain.dot_atom_text.elements.size >1)
      rescue Exception => e
        r = false
      end
      errors.add(:email_address, :invalid) unless r
    end
  end

  def check_email_address_existence
    if email_address.present?
      if id.present?
        if User.where(email_address: email_address, deleted: false).where("id <> ?", id).count > 0
          errors.add(:email_address, :email_address_already_exists)
        end
      else
        if User.where(email_address: email_address, deleted: false).count > 0
          errors.add(:email_address, :email_address_already_exists)
        end
      end
    end
  end
end
