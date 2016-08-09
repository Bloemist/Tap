json.(@user, :id, :name, :orders_count, :balance)
json.avatar image_path @user.avatar.url
json.dagschotels do
  json.array! @user.dagschotels do |d|
    json.avatar image_path d.product.avatar.url
    json.order orders_url(@user, user_id: @user.id, order: { product_id: d.product.id })
  end
end