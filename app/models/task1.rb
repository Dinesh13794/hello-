class Task1 < ApplicationController
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :title, type: String
  field :description, type: String
  field :status, type: String
  field :assigned_to, type: String
  field :created_by, type: String

  validates :title, presence: true
  validates :status, inclusion: { in: %w[open in_progress completed] }
  validates :title, presence: true, uniqueness: { case_sensitive: false, message: "already added" }

end
