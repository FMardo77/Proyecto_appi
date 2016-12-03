class CommentsController < ApplicationController
   def list
  	@lista = Comment.last(100)
    render json: {Comments: @lista}
  end

  def new
  end

  def update
    received_id = params[:id]
    @perfil = Comment.where({id: received_id}).first

    @perfil.update_attributes({
      mail: params[:comment][:mail],
      text: params[:comment][:text],
    })

    render json: {Comment: @perfil}
  end

  def edit
    received_id = params[:id]
    @perfil = Comment.where({id: received_id}).first
  end

  # ver_perfil
  def show
    received_id = params[:id]
    @perfil = Comment.where({id: received_id}).first
    render json: {Comment: @perfil}
  end

  def delete
    # permisos <=
    id = params[:id].to_i # param is missing => 0; param != integer => integer
    pr = Comment.where(id: id).first # Comment.delete(id)

    if pr.nil?
      respond_to do |format|
        format.any{
          return render json: {}, status: 422
        }
        # format.html{
        #   return redirect_to action: :list
        # }
      end
    else # a Comment exists
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
  	pr = Comment.new({
      mail: params[:comment][:mail],
      text: params[:comment][:text],
   		})

  	pr.save
    return render json: {Comment: pr}
  end
end
