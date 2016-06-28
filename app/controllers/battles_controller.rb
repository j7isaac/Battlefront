class BattlesController < ApplicationController
  def new
    @battle = Battle.new
  end

  def create
    @battle = Battle.create(battle_params)
    redirect_to battle
  end

  def show
    @battle = Battle.find(params[:id])
  end

  private

  def battle
    @battle ||= Battle.where(id: params[:id]).last
  end

  def battle_params
    params.require(:battle).permit(:army_a, :army_b)
  end
end
