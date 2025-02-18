module Api
  class TasksController < ApplicationController
    before_action :set_task, only: [:show, :update, :destroy]

    def index
      tasks = Task1.all
      render json: tasks
    end

    def create
      Rails.logger.info "task_params, #{task_params}"

      task = Task1.new(task_params)
      p "task.save #{task.errors.full_messages}"
      if task.save
        render json: { message: 'Task created successfully', task: task }, status: :created
      else
        p "task.save #{task.errors.full_messages}"
        render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def show
      render json: @task
    end
    

    def update
      if @task.update(task_params)
        render json: @task
      else
        render json: @task.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @task.destroy
      head :no_content
    end

    private

    def set_task
      @task = Task1.find(params[:id])
    end

    private

    def task_params
      params.require(:task).permit(:title, :description, :status, :assigned_to)
    end
  end
end
