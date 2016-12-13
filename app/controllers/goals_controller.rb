class GoalsController < ApplicationController
  before_action :require_log_in


  def index
    @goals = Goal.where(user_id: current_user.id)
    render :index
  end

  def show
    @goal = Goal.find(params[:id])
    render :show
  end

  def new
    @goal = Goal.new
    render :new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash[:errors] = @goal.errors.full_messages
      redirect_to new_goal_url
    end
  end

  def edit
    @goal = Goal.find(params[:id])
    render :edit
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.user_id == current_user.id
      if @goal.update(goal_params)
        redirect_to goal_url(@goal)
      else
        flash.now[:errors] = @goal.errors.full_messages
        render :edit
      end
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.delete
    redirect_to goals_url
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :description, :is_private, :is_completed)
  end

end
