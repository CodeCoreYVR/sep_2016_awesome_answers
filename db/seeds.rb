10.times do
  Tag.create(name: Faker::GameOfThrones.house)
end

puts Cowsay.say('Generated up to 10 tags', 'random')

tags = Tag.all

100.times do
  Question.create({ title:      Faker::Company.catch_phrase,
                    body:       Faker::Hacker.say_something_smart,
                    tags:       tags.sample(rand(3) + 1),
                    view_count: rand(1000) })
end

puts Cowsay.say('Generated 200 questions', 'random')
