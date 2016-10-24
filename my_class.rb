class MyClass
  attr_accessor :variable

  def set_once(value)
    @variable ||= value
  end

end
