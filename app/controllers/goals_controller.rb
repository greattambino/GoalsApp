class GoalsController < ApplicationController
  before_action :ensure_logged_in, except: :index

  def new
    @goal = Goal.new
  end

  def create
    @goal = current_user.goals.new(goal_params)

    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:messages] = @goal.errors.full_messages
      render :new
    end
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def index
    if current_user
      @goals = Goal.all.order(:created_at).where("public = ?", true).where("user_id != ?", current_user.id)
    else
      @goals = Goal.all.order(:created_at).where("public = ?", true)
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])

    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:messages] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy if @goal
    redirect_to goals_url
  end


  private
  def goal_params
    params.require(:goal).permit(:title, :status, :public)
  end
end
