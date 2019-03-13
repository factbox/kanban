# Simple functional artifact.
class Story < ApplicationRecord
  acts_as :artifact
  enum layer: [:todo, :doing, :done]

  validates :story, presence: false

  def self.plugin_name
    'Kanban'
  end
end
