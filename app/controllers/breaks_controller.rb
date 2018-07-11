require 'date'

class BreaksController < ApplicationController
  def index
    @breaks = Break.all
  end

  def show
    @navbar_render = true
    @activity = Break.find(params[:id]).activity.name
    @break = Break.find(params[:id])
    @playlist = RSpotify::Playlist.search('Meditation')
    @cancion = @playlist.sample.uri
  end

  def new
    @navbar_render = true
    @timersession = TimerSession.find(params[:timer_session_id])
    @break = Break.new
    @preset = Preset.find(@timersession.preset_id)
  end

  def create
    @break = Break.new(break_params)
    @timer_session = TimerSession.find(params[:timer_session_id])
    @break.timer_session = @timer_session
    @break.length = @timer_session.preset.break_duration
    if @break.save
      redirect_to break_path(@break)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @break = Break.find(params[:id])
    @timer_session = @break.timer_session
    @timer_session.starts_at = Time.now
    @timer_session.save
    respond_to do |format|
      format.html
      format.js #views/start_timer_sessions/update.js.erb
    end
  end

  def destroy

  end

  private

  def break_params
    params.require(:break).permit(:timer_session_id, :activity_id, :length)
  end
end
