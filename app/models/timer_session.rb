class TimerSession < ApplicationRecord
  belongs_to :preset
  has_many :breaks,  dependent: :destroy
  # has_many :timer_sessions
end
