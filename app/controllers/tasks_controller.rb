class TasksController < ApplicationController
  #before_action :authenticate
  #before_action :doorkeeper_authorize!

  def list
  	@lista = Task.last(100)
    render json: {tasks: @lista}
  end

  def new
  end

  def update
    received_id = params[:id]
    @tarea = Task.where({id: received_id}).first

    @tarea.update_attributes({
      title: params[:title],
      due_date: params[:due_date],
      description: params[:description]
    })

    redirect_to({action: :show})
  end

  def edit
    received_id = params[:id]
    @tarea = Task.where({id: received_id}).first
  end

  # ver_tarea
  def show
    received_id = params[:id]
    @tarea = Task.where({id: received_id}).first
    render json: {task: @tarea}
  end

  def delete
    # permisos <=
    id = params[:id].to_i # param is missing => 0; param != integer => integer
    t = Task.where(id: id).first # Task.delete(id)

    if t.nil?
      respond_to do |format|
        format.any{
          return render json: {}, status: 422
        }
        # format.html{
        #   return redirect_to action: :list
        # }
      end
    else # a task exists
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
  	t = Task.new({
  			title: params[:task][:title],
  			due_date: params[:task][:due_date],
  			description: params[:task][:description]
  		})

  	t.save
    return render json: {task: t}
  end

  private
    def authenticate
      return redirect_to :login if cookies[:user_id].to_s.empty?
    end
end
