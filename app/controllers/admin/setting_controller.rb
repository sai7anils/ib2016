class Admin::SettingController < Admin::ApplicationController
  before_action :load_setting, only: [:edit, :update]

  def edit; end

  def update
    @settings = IdeaBurn.find(params[:id])
    respond_to do |format|
      if @settings.update_attributes(settings_params)
        format.html { redirect_to edit_admin_setting_path(@settings), notice: 'Settings was successfully updated.' }
        format.json { render :edit, status: :updated, location: @settings }
      else
        format.html { render :edit}
        format.json { render json: @settings.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def load_setting
    @settings = IdeaBurn.find(params[:id])
  end

  def settings_params
    params.require(:idea_burn).permit(:name, :url, :seo_title, :meta_description, :meta_keywords, :mail_from_address, :facebook, :linkedin, :instagram, :tumblr, :video)
  end

end
