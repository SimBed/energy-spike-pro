require 'twilio-ruby'

class TwilioMessage
  def initialize(attributes = {})
    @content_sid = attributes[:content_sid]
    @content_variables = attributes[:content_variables] || {}
  end

  def send_whatsapp
    twilio_initialise
    client = Twilio::REST::Client.new(@account_sid, @auth_token)
    client.api.v2010.messages.create(
      content_sid: @content_sid,
      to: "whatsapp:#{@to_number}",
      from: "whatsapp:#{@from_number}",
      content_variables: @content_variables.to_json
    )
  end

  private

  def twilio_initialise
    @account_sid = ENV['TWILIO_ACCOUNT_SID']
    @auth_token = ENV['TWILIO_AUTH_TOKEN']
    @from_number = ENV['TWILIO_WHATSAPP_NUMBER']
    @to_number = ENV['ME']
  end

end