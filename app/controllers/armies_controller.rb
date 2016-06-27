class ArmiesController < ApplicationController
  def create
    @army = Army.create(army_params)
    redirect_to root_path
    flash[:notice] = 'army successfully saved'
  end

  private

  def army_params
    params.require(:army).permit(
      :name,
      :infantry,
      :archers,
      :knights
    )
  end
end
