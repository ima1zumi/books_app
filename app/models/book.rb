# frozen_string_literal: true

class Book < ApplicationRecord
  mount_uploader :picture, PictureUploader
  paginates_per 5
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
end
