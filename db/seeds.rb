require 'faker'

20.times do
  User.create(email: Faker::Internet.email,
              password: 'password' )
end

100.times do
  user = User.find(rand(1..20))
  user.posts << Post.create(title: Faker::Lorem.sentence,
                            description: Faker::Lorem.paragraphs)
end

tags = []
30.times { tags << Faker::Lorem.word }

1.upto(100) do |post_id|
  post = Post.find(post_id)
  post_tags = tags.sample(rand(0..5)).join(', ')
  post.update_tags(post_tags)
end
