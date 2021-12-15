class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts,dependent: :destroy
  has_many :comments,dependent: :destroy
  acts_as_paranoid
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
