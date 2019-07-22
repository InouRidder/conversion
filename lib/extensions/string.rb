# frozen_string_literal: true

module ConversionStringExentension
  def constantize
    return if empty?
    Object.const_get(self)
  end
end

String.prepend ConversionStringExentension
