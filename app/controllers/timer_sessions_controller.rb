require 'date'

class TimerSessionsController < ApplicationController
  def index

    @navbar_render = true
    @timer_sessions = current_user.timer_sessions
    @stats = current_user.overall_stats
    @daily = current_user.today_activity_stats
    @total_focus = @total_break = @daily_focus = @daily_break = 0

    @timer_sessions.each do |timer_session|
      @total_focus += timer_session.preset.focus_timer * timer_session.breaks.length
      @total_break += timer_session.preset.break_duration * timer_session.breaks.length
      if timer_session.created_at.between?(Time.zone.today.beginning_of_day, Time.zone.today.end_of_day)
        @daily_focus += timer_session.preset.focus_timer * timer_session.breaks.length
        @daily_break += timer_session.preset.break_duration * timer_session.breaks.length
      end
    end
  @stats.unshift(["Focusing", @total_focus])
  @daily["Focusing"] = @daily_focus
  @daily = @daily.to_a.sort_by { |stat| -stat.last}.to_h

  end

  def show
    @navbar_render = true
    @timer_session = TimerSession.find(params[:id])
  end

  def new
    @navbar_render = true
    @timer_session = TimerSession.new
  end

  def create
    @navbar_render = true
    @timer_session = TimerSession.new
    @timer_session.preset = Preset.find(params[:preset_id])
    if @timer_session.save
      redirect_to timer_session_path(@timer_session)
    else
      render :new
    end
  end

  def destroy
  end

  def stats
    @navbar_render = true
    @timer_session = TimerSession.find(params[:id])
    if @timer_session.breaks.first == nil
      redirect_to timer_session_path(@timer_session)
    end
    @stats = {
      # "Workday" => @timer_session.preset.working_day * 60,
      "Focusing" => @timer_session.preset.focus_timer.to_i * @timer_session.breaks.count.to_i
    }
    @timer_session.breaks.each do |b|
      if @stats[b.activity.name].present?
        @stats[b.activity.name] += @timer_session.preset.break_duration
      else
        @stats[b.activity.name] = @timer_session.preset.break_duration
      end
    end
    @working_time = @timer_session.preset.working_day
    if @timer_session.breaks.first != nil
      @breaks_time = @timer_session.breaks.count.to_i * @timer_session.breaks.first.length.to_i
    else
      @breaks_time = 0
    end
    @focus_time = @timer_session.preset.focus_timer.to_i * @timer_session.breaks.count.to_i
    @remaining_time = @working_time * 60 - @focus_time - @breaks_time
  end


  private

  def timer_session_params
    params.require(:timer_session).permit(:ends_at, :starts_at)
  end
end
