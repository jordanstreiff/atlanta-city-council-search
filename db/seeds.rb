# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'yaml'

reps_yaml = YAML.load_file(Rails.root.join('lib', 'seeds', 'representatives.yml'))
reps_yaml.collect do |district_id, rep|
  Representative.create(district_id: district_id, full_name: rep["full_name"])
end