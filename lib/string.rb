# frozen_string_literal: true

class String
  def constantize
    Object.const_get(self)
  end
end
