class UsersController < ApplicationController
	def list
  	@lista = User.last(100)
    render json: {users: @lista}
  end

  def new
  end

  def update
    received_id = params[:id]
    @usuario = User.where({id: received_id}).first

    @usuario.update_attributes({
      name: params[:user][:name],
      last_name: params[:user][:last_name],
      phone: params[:user][:phone],
      email: params[:user][:email],
      password_digest: params[:user][:password_digest],
      username: params[:user][:username]
    })

    render json: {User: @usuario}
  end

  def edit
    received_id = params[:id]
    @usuario = User.where({id: received_id}).first
  end

  # ver_usuario
  def show
    received_id = params[:id]
    @usuario = User.where({id: received_id}).first
    render json: {User: @usuario}
  end

  def delete
    # permisos <=
    id = params[:id].to_i # param is missing => 0; param != integer => integer
    t = User.where(id: id).first # User.delete(id)

    if t.nil?
      respond_to do |format|
        format.any{
          return render json: {}, status: 422
        }
        # format.html{
        #   return redirect_to action: :list
        # }
      end
    else # a User exists
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
  	t = User.new({
  			name: params[:user][:name],
        username: params[:user][:username],
        password: params[:user][:password_digest],
        phone: params[:user][:phone],
         email: params[:user][:email],
  			lastn: params[:user][:last_name]
  		})

  	t.save
    return render json: {user: t}
  end
end
