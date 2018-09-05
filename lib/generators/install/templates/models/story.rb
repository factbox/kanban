# Simple functional artifact.
class Story < ApplicationRecord
  acts_as :artifact

  validates :story, presence: false
end
