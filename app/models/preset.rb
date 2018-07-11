class Preset < ApplicationRecord
  belongs_to :user, optional: true
  has_many :timer_sessions, dependent: :destroy
  has_many :activities,  dependent: :destroy
  has_many :breaks, through: :timer_sessions
  #validates :activity, presence: true
  validates :working_day, presence: true
  validates :focus_timer, presence: true
  validates :break_duration, presence: true
  validates :name, presence: true

  after_create :populate_default_activities

  def string_duration
    total_seconds = focus_timer * 60
    seconds = total_seconds % 60
    minutes = (total_seconds / 60) % 60
    hours = total_seconds / (60 * 60)

    format("%02d:%02d:%02d", hours, seconds, minutes) #=> "01:00:00"

  end

  private

  def populate_default_activities
    ["Meditation", "Social Media", "Reading"].each do |act|
      Activity.create(name: act, chosen: true, preset: self)
   end
  end
 end

