include RandomData

FactoryGirl.define do
  factory :post do
    title RandomData.random_sentence
    body RandomData.random_paragraph
    user
    topic
    rank 0.0
  end
end