class SavedsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_business

  def create
    current_user.saveds.find_or_create_by!(business: @business)
    render_business
  end

  def destroy
    current_user.saveds.where(business: @business).destroy_all
    render_business
  end

  private

  def set_business
    @business = Business.find(params[:business_id])
  end

  def render_business
    business = Business.left_joins(:saveds)
                        .where("businesses.id = ?", @business.id)
                        .where("saveds.user_id = ? OR saveds.user_id IS NULL", current_user.id)
                        .select(
                         "businesses.*, CASE WHEN saveds.user_id IS NULL THEN FALSE ELSE TRUE END AS saved"
                       ).first

    render turbo_stream: turbo_stream.replace(
      "business_#{@business.id}",
      partial: "home/business",
      locals: { business: business }
    )
  end
end
