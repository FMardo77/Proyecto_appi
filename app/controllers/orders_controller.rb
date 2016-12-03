class OrdersController < ApplicationController
   def list
  	@lista = Order.last(100)
    render json: {orders: @lista}
  end

  def new
  end

  def update
    received_id = params[:id]
    @perfil = Order.where({id: received_id}).first

    @perfil.update_attributes({
      date: params[:order][:date],
      amount: params[:order][:amount],
      status: params[:order][:status],
      paid: params[:order][:paid],
    })

    render json: {order: @perfil}
  end

  def edit
    received_id = params[:id]
    @perfil = Order.where({id: received_id}).first
  end

  # ver_perfil
  def show
    received_id = params[:id]
    @perfil = Order.where({id: received_id}).first
    render json: {order: @perfil}
  end

  def delete
    # permisos <=
    id = params[:id].to_i # param is missing => 0; param != integer => integer
    pr = Order.where(id: id).first # Order.delete(id)

    if pr.nil?
      respond_to do |format|
        format.any{
          return render json: {}, status: 422
        }
        # format.html{
        #   return redirect_to action: :list
        # }
      end
    else # a Order exists
      pr.destroy # t.delete
      respond_to do |format|
        format.any{
          return render json: {}, status: 200
        }
        # format.html{
        #   return redirect_to action: :list
        # }
      end
    end

  end

  def create
  	# params - Hash
  	pr = Order.new({
      date: params[:order][:date],
      amount: params[:order][:amount],
      status: params[:order][:status],
      paid: params[:order][:paid],
      user_id: params[:order][:user]
  		})

  	pr.save
    return render json: {order: pr}
  end
end
