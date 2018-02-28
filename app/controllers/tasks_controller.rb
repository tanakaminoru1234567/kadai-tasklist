class TasksController < ApplicationController
  before_action :task_select, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def show
    task_select
  end
  
  def create
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = '登録に成功しました'
      redirect_to @task
    else
      flash.now[:danger] = '登録できませんでした'
      render :new
    end
  end

  def new
    @task = Task.new
  end

  def edit
    task_select
  end

  def update
    task_select
    
    if @task.update(task_params)
      flash[:success] = '更新に成功しました'
      redirect_to @task
    else
      flash.now[:danger] = '更新できませんでした'
      render :edit
    end
  end

  def destroy
    task_select
    @task.destroy
    
    flash[:success] = '削除に成功しました'
    redirect_to tasks_url
  end

  private

  def task_select
    @task = Task.find(params[:id])
  end
      
  #ストロングパラメータ
  def task_params
    params.require(:task).permit(:content, :status)
  end

end
