class Label < ActiveRecord::Base
  belongs_to :labelable, polymorphic: true
  has_many :labelings
  has_many :topics, through: :labelings, source: :labelable, source_type: :Topic
  has_many :posts, through: :labelings, source: :labelable, source_type: :Post

  def self.update_labels(label_string)
    new_labels = []
    return new_labels if label_string == ""

    unless label_string.nil? || label_string.empty?
      label_string.split(",").each do |label|
        label_name = label.strip
        new_label = Label.find_or_create_by(name: label_name)
        new_labels << new_label
      end
      new_labels
    end
  end
end