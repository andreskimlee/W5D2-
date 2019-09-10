# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  url        :string
#  content    :string
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  validates :title, :author_id, presence: true 
  validate :has_sub?

  has_many :post_subs, inverse_of: :post 

  has_many :subs,
  through: :post_subs,
  source: :sub 
  
  
  belongs_to :author,
  foreign_key: :author_id,
  class_name: :User 

  def has_sub?
    !self.subs.empty?    
  end 

end
