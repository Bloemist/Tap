TabApiJob = Struct.new(:order_id) do
  def perform(*args)
    order = Order.find_by(id: order_id)
    if order && !order.transaction_id
      body = { transaction: { debtor: order.user.uid, cents: order.price_cents, message: order.to_sentence, id_at_client: order.id } }
      headers = { "Authorization" => "Token token=#{Rails.application.secrets.tab_api_key}" }
      result = HTTParty.post("https://zeus.ugent.be/tab/transactions", body: body, headers: headers )
      order.update_attribute(:transaction_id, JSON.parse(result.body)["id"].to_i)
    end
  end

  def error(job, exception)
    Airbrake.notify(exception)
  end
end