# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
preset = Preset.new(
  working_day: 2,
  focus_timer: 25,
  break_duration: 5,
  name: "Pomodoro"

  )
preset.save!
