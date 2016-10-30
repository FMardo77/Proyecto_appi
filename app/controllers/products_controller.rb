class ProductsController < ApplicationController
	def list
  	@lista = Product.last(100)
    render json: {products: @lista}
  end

  def new
  end

  def update
    received_id = params[:id]
    @products = Product.where({id: received_id}).first

    @products.update_attributes({
      name: params[:Product][:name],
      description: params[:Product][:description],
      tipo: params[:Product][:tipo]
    })

    render json: {Product: @products}
  end

  def edit
    received_id = params[:id]
    @products = Products.where({id: received_id}).first
  end

  # ver_products
  def show
    received_id = params[:id]
    @products = Menu.where({id: received_id}).first
    render json: {Menu: @products}
  end

  def delete
    # permisos <=
    id = params[:id].to_i # param is missing => 0; param != integer => integer
    t = Product.where(id: id).first # Menu.delete(id)

    if t.nil?
      respond_to do |format|
        format.any{
          return render json: {}, status: 422
        }
        # format.html{
        #   return redirect_to action: :list
        # }
      end
    else # a Menu exists
      t.destroy # t.delete
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
  	t = Product.new({
      name: params[:Product][:name],
      description: params[:Product][:description],
      tipo: params[:Product][:tipo]
  		})

  	t.save
    return render json: {product: t}
  end

end
