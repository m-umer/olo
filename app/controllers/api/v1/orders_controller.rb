class Api::V1::OrdersController < ApiController
  before_action :get_table, only: [:create]

	def create
    @order = Order.create(table_no: @device.first.id)
    order_detail = params[:order_detail]
    
    # binding.pry
    order_detail.each do |detail|
      # binding.pry
      OrderDetail.create(order_id: @order.id, menu_id: detail[:menu_id], quantity: detail[:quantity])
    end
    
    render :json => { message: "Order created successfully.", :status => 200 }
  end

  private
    def get_table
      device_id = params[:device_id]
      @device = DeviceTableMapping.where(device_id: device_id)

      return render :json => { message: "Invalid Device ID.", :status => 422 } unless @device.any?
    end
end
