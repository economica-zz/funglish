class PaypalController < ApplicationController
  include ActiveMerchant::Billing

  def checkout
    id = params[:id]

    if id.blank?
      redirect_to :root
      return
    end

    @lesson = Lesson.where(id: id, deleted: false).first

    if @lesson.blank? || @lesson.price == 0
      redirect_to :root
      return
    end

    setup_response = gateway.setup_purchase(
      (@lesson.price.to_s + "00").to_i,
      :ip => request.remote_ip,
      :return_url => root_url + "paypal/confirm/" + @lesson.id.to_s,
      :cancel_return_url => root_url + "paypal/cancel/" + @lesson.id.to_s
    )

    redirect_to gateway.redirect_url_for(setup_response.token)
  end

  def confirm
    id = params[:id]
    @token = params[:token]
    @payer_id = params[:PayerID]

    if id.blank? || @token.blank? || @payer_id.blank?
      redirect_to :root
      return
    end

    @lesson = Lesson.where(id: id, deleted: false).first

    if @lesson.blank? || @lesson.price == 0
      redirect_to :root
      return
    end
  end

  def complete
    id = params[:id]
    token = params[:token]
    payer_id = params[:payer_id]

    if id.blank? || token.blank? || payer_id.blank?
      redirect_to :root
      return
    end

    @lesson = Lesson.where(id: id, deleted: false).first

    if @lesson.blank? || @lesson.price == 0
      redirect_to :root
      return
    end

    if @login_user.blank?
      redirect_to :root
      return
    end

    purchase = gateway.purchase(
      (@lesson.price.to_s + "00").to_i,
      :ip => request.remote_ip,
      :payer_id => payer_id,
      :token => token
    )

    if !purchase.success?
      redirect_to :root
      return
    end

    payment = Payment.new
    payment.user_id = @login_user.id
    payment.lesson_id = @lesson.id
    payment.payment_method_id = PaymentMethod::PAYPAL
    payment.amount = @lesson.price
    payment.pay_timestamp = Time.current.in_time_zone("UTC")
    payment.expiration_timestamp = payment.pay_timestamp + 30.days

    if !payment.save
      redirect_to :root
      return
    end

    flash[:success] = I18n.t("payment_complete")

    redirect_to "/lessons/" + @lesson.id.to_s
  end

  def cancel
    id = params[:id]

    if id.blank?
      redirect_to :root
      return
    end

    redirect_to "/lessons/" + id
  end

  private
  def gateway
    @gateway ||= PaypalExpressGateway.new(
      :login => ENV['PAYPAL_API_USERNAME'],
      :password => ENV['PAYPAL_API_PASSWORD'],
      :signature => ENV['PAYPAL_SIGNATURE']
    )
  end
end
