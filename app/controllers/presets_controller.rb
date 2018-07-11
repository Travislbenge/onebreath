class PresetsController < ApplicationController
  before_action :set_preset, only: [:show, :edit, :udpate]
  before_action :set_user, only: [:new, :edit ]

  def index
    @pomodoro = Preset.find_by(name: "Pomodoro")
    @presets = Preset.where(user_id: current_user.id)
    @navbar_render = true
  end

  def show
  end

  def new
    @preset = Preset.new
    @navbar_render = true
  end

  def create
    @preset = Preset.new(preset_params)
    @preset.user = current_user
    if @preset.save
      if params[:commit] == "Start Timer"
        timer = TimerSession.create(preset_id: @preset.id)
        timer_session_path(timer)
      else
        redirect_to new_preset_activity_path(@preset)
      end
    else
    render :new
  end
  end

  def edit
    @navbar_render = true
  end

  def update
    @preset = Preset.find(params[:id])
    if params[:commit] == "Start Timer"
      @preset.update(preset_params)
      timer = TimerSession.create(preset_id: @preset.id)
      redirect_to timer_session_path(timer)
    elsif params[:commit] == "done editing breaks"
        params[:preset].each do |activity, value_checked|
        if value_checked == "0"
          act = @preset.activities.find_by(name: activity)
          act.destroy if act
        else
          @preset.activities.find_by(name: activity)
        end
      end
      timer = TimerSession.create(preset_id: @preset.id)
      redirect_to timer_session_path(timer)
    else
      @preset.update(preset_params)
      redirect_to  preset_activities_path(@preset)
    end
  end

  def destroy
    @preset = Preset.find(params[:id])
    @preset.destroy
    redirect_to presets_path
  end

   private

  def preset_params
    params.require(:preset).permit(:name, :working_day, :focus_timer, :break_duration)
  end

  def set_preset
    @preset = Preset.find(params[:id])
  end

  def set_user
    @user = current_user
  end
end
