class TypesController < ApplicationController
  def list
  	@lista = Type.last(100)
    render json: {Types: @lista}
  end

  def new
  end

  def update
    received_id = params[:id]
    @tipoprod = Type.where({id: received_id}).first

    @tipoprod.update_attributes({
      name: params[:Type][:name],
      description: params[:Type][:description],
    })

    render json: {Type: @tipoprod}
  end

  def edit
    received_id = params[:id]
    @tipoprod = Type.where({id: received_id}).first
  end

  # ver_tipoprod
  def show
    received_id = params[:id]
    @tipoprod = Type.where({id: received_id}).first
    render json: {Type: @tipoprod}
  end

  def delete
    # permisos <=
    id = params[:id].to_i # param is missing => 0; param != integer => integer
    t = Type.where(id: id).first # Type.delete(id)

    if t.nil?
      respond_to do |format|
        format.any{
          return render json: {}, status: 422
        }
        # format.html{
        #   return redirect_to action: :list
        # }
      end
    else # a Type exists
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
  	t = Type.new({
  			name: params[:type][:name],
  			description: params[:type][:description],
  		})

if t.save
      return render json: {type: t}
    else
      return render json: { errors: t.errors }, status: 422
    end
end
end
