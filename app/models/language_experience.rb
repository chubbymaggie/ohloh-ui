class LanguageExperience < ActiveRecord::Base
  belongs_to :position
  belongs_to :language

  validates :language, presence: true
end
