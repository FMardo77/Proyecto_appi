class ProductsController < ApplicationController
   def list
  	@lista = Product.last(100)
    render json: {products: @lista}
  end

  def new
  end

  def update
    received_id = params[:id]
    @perfil = Product.where({id: received_id}).first

    @perfil.update_attributes({
      name: params[:product][:name],
      description: params[:product][:description],
      price: params[:roduct][:price],
      available: params[:product][:available],
    })

    render json: {Product: @perfil}
  end

  def edit
    received_id = params[:id]
    @perfil = Product.where({id: received_id}).first
  end

  # ver_perfil
  def show
    received_id = params[:id]
    @perfil = Product.where({id: received_id}).first
    render json: {Product: @perfil}
  end

  def delete
    # permisos <=
    id = params[:id].to_i # param is missing => 0; param != integer => integer
    pr = Product.where(id: id).first # Product.delete(id)

    if pr.nil?
      respond_to do |format|
        format.any{
          return render json: {}, status: 422
        }
        # format.html{
        #   return redirect_to action: :list
        # }
      end
    else # a Product exists
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
  	pr = Product.new({
      name: params[:product][:name],
      description: params[:product][:description],
      price: params[:product][:price],
      available: params[:product][:available],
      type_id: params[:product][:type]
  		})

  	pr.save
    return render json: {product: pr}
  end
end
