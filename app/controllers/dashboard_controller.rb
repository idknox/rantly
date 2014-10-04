class DashboardController < ApplicationController
  def show
    @dashboard = Dashboard.new(current_user)
  end

  def display_image
    @image_data = Image.find_by(user_id: params[:user_id])
    @image = @image_data.data
    send_data(
      @image,
      type: @image_data.content_type,
      filename: @image_data.filename,
      disposition: 'inline'
    )
  end
end