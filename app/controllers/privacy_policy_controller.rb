class PrivacyPolicyController < ApplicationController
  def index
    @privacy_policy = PrivacyPolicy.where(deleted: false).first
  end
end
