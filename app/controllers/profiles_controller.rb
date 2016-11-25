class ProfilesController < ApplicationController
	def list
  	@lista = Profile.last(100)
    render json: {Profiles: @lista}
  end

  def new
  end

  def update
    received_id = params[:id]
    @perfil = Profile.where({id: received_id}).first

    @perfil.update_attributes({
      name: params[:Profile][:name],
      lastn: params[:Profile][:lastn],
      mail: params[:Profile][:mail],
      phone: params[:Profile][:phone],
    })

    render json: {Profile: @perfil}
  end

  def edit
    received_id = params[:id]
    @perfil = Profile.where({id: received_id}).first
  end

  # ver_perfil
  def show
    received_id = params[:id]
    @perfil = Profile.where({id: received_id}).first
    render json: {Profile: @perfil}
  end

  def delete
    # permisos <=
    id = params[:id].to_i # param is missing => 0; param != integer => integer
    pr = Profile.where(id: id).first # Profile.delete(id)

    if pr.nil?
      respond_to do |format|
        format.any{
          return render json: {}, status: 422
        }
        # format.html{
        #   return redirect_to action: :list
        # }
      end
    else # a Profile exists
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
  	pr = Profile.new({
      name: params[:profile][:name],
      lastn: params[:profile][:lastn],
      mail: params[:profile][:mail],
      phone: params[:profile][:phone],
      user_id: params[:profile][:user]
  		})

  	pr.save
    return render json: {Profile: pr}
  end
end
