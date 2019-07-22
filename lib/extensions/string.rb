# frozen_string_literal: true

class String
  def constantize
    return if empty?
    Object.const_get(self)
  end
end
