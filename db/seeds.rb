# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


unless User.exists?(email: "mike.nielsen15@outlook.com")
  User.create!(email: "mike.nielsen15@outlook.com",
               password: "admin123",
               first_name: 'Mike',
               last_name: 'Nielesen',
               admin: true,
               qb_id: "7590962" )
end

unless Institution.exists?(name: 'Brown university')
  # need a line of code to validate Brown institution.program.exists?
  institution_list = SmarterCSV.process('./lib/tasks/institution_list.csv')

  institution_list.each do |institution|
    Institution.create!(name: institution[:name],
                        description: institution[:description],
                        city: institution[:city],
                        state: institution[:state],
                        country: institution[:country]
                      )
  end

  program_input_list = SmarterCSV.process('./lib/tasks/program_list.csv')

  program_input_list.each do |program|
    Program.create!(title: program[:program],
                    institution: Institution.find_by(name: program[:institution])
                    )
  end
end

unless Category.exists?(name: 'UX')
  category_list = SmarterCSV.process('./lib/tasks/category_list.csv')
  category_list.each do |category|
    Category.create!(name: category[:name],
                     icons: category[:icons])
  end
end

# This skill seed is deactivated.
# unless Skill.exists?(name: 'Econ 1630')
#   brown_economics_skills = SmarterCSV.process(
#   './lib/tasks/brown_economics_skills.csv')
#   brown_economics_skills.each do |skill|
#     Skill.create!(
#       name: skill[:name],
#       description: skill[:description],
#       points: skill[:points],
#       program: Institution.find_by(name: 'Brown university').programs.select { |n|
#       n[:title] == 'Economics' }[0],
#       user: User.find_by(email: 'linghan_xing@alumni.brown.edu'),
#       category: Category.find_by(name: skill[:category])
#     )
#   end
# end

# 30.times do
#   User.create!(
#     first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     email: Faker::Internet.email,
#     password: "password",
#     description: Faker::Lorem.paragraph(10)
#   )
# end
#
# 3000.times do
#   Skill.create!(
#     name: Faker::Name.name,
#     description: Faker::Lorem.sentence,
#     points: rand(2)+1,
#     program: Program.all.sample,
#     user: User.all.sample,
#     category: Category.all.sample
#   )
# end
#
# 500.times do
#   Review.create!(
#     institution: Institution.all.sample,
#     user: User.all.sample,
#     title: Faker::Lorem.sentence,
#     rating: rand(11),
#     content: Faker::Lorem.paragraph,
#     program: Program.all.sample
#   )
# end
#
# 30.times do
#   Institution.create!(
#     name: Faker::University.name,
#     description: Faker::Lorem.paragraph,
#     city: Faker::Address.city,
#     country: Faker::Address.country,
#     state: Faker::Address.state
#   )
# end
#
# 400.times do
#   Program.create!(
#     title: Faker::Book.title,
#     description: Faker::Lorem.paragraph
#   )
# end
#
# 200.times do
#   UserProgramAttendancy.create!(
#     user: User.all.sample,
#     program: Program.all.sample,
#     start_date: Faker::Date.backward(1200),
#     end_date: Faker::Date.forward(1200),
#     url: Faker::Internet.url
#   )
# end
