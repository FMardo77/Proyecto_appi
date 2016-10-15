class SessionsController < ApplicationController
  def new
  	return redirect_to :lista_tareas if !cookies[:user_id].to_s.empty?
  end

  def destroy
  	cookies[:user_id] = nil
  	redirect_to action: :new
  end

  def create
  	# params[:username]
  	# params[:password]
  	u = User.where(username: params[:username]).first
  	if !u.nil? and u.authenticate(params[:password])
  		# Username and password were correct!
      respond_to do |format|
        format.html{
          cookies[:user_id] = u.id
          redirect_to :lista_tareas
        }
        format.json{
          payload = { data: u.id }
          token = JWT.encode(payload, Rails.application.secrets.jwt_secret, 'HS256')
          return render json: {token: token}
        }
      end

  	else
  		# Username and password are incorrect!
      respond_to do |format|
        format.html{
          flash[:notice] = 'Username or password are incorrect'
          render action: :new
        }
        format.json{
          return render json: { errors: ['Username or password are incorrect'] }, status: 401
        }
      end

  	end

  end
end
