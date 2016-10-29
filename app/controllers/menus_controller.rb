class MenusController < ApplicationController
	def list
  	@lista = Menu.last(100)
    render json: {menus: @lista}
  end

  def new
  end

  def update
    received_id = params[:id]
    @menus = Menu.where({id: received_id}).first

    @menus.update_attributes({
      name: params[:Menu][:name],
      price: params[:Menu][:price],
      description: params[:Menu][:description],
      complete: params[:Menu][:complete]
    })

    render json: {Menu: @menus}
  end

  def edit
    received_id = params[:id]
    @menus = Menu.where({id: received_id}).first
  end

  # ver_menus
  def show
    received_id = params[:id]
    @menus = Menu.where({id: received_id}).first
    render json: {Menu: @menus}
  end

  def delete
    # permisos <=
    id = params[:id].to_i # param is missing => 0; param != integer => integer
    t = Menu.where(id: id).first # Menu.delete(id)

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
  	t = Menu.new({
  			name: params[:menu][:name],
  			price: params[:menu][:price],
  			description: params[:menu][:description],
  			tipe: params[:menu][:tipe]
  		})

  	t.save
    return render json: {menu: t}
  end

end
