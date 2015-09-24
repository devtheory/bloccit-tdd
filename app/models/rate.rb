class Rate < ActiveRecord::Base
  enum severity: [:PG, :PG13, :R]
  belongs_to :rateable, polymorphic: true

  has_many :ratings
  has_many :topics, through: :ratings, source: :rateable, source_type: :Topic
  has_many :posts, through: :ratings, source: :rateable, source_type: :Post

  def self.update_rates(rate_string)
    new_rates = []
    return new_rates if rate_string == "" # leaves the method if there is nothing sent in to update

    unless rate_string.nil? || rate_string.empty?
      rate_string.split(",").each do |rate|
        rate_name = rate.strip
        next if !Rate.severities.has_key?(rate_name) #skips current rate if it's not a valid value
        new_rate = Rate.where(severity: Rate.severities[rate_name]).first_or_create
        new_rates << new_rate
        break #prevents more than 1 rating from being given
      end
      new_rates
    end
  end

end
