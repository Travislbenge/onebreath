class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def duration(column_name)
    min = self[column_name]
    total_seconds = min * 60
    seconds = total_seconds % 60
    minutes = (total_seconds / 60) % 60
    hours = total_seconds / (60 * 60)

    format("%02d:%02d:%02d", hours, minutes, seconds) #=> "01:00:00"
    # "00:00:05"
  end
end
