class TermsOfServiceController < ApplicationController
  def index
    @terms_of_service = TermsOfService.where(deleted: false).first
  end
end
