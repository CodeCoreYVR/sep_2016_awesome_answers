class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def error_description
    errors.full_messages.join(", ")
  end
end
