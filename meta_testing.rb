class MyClass

  [:title, :body, :view_count].each do |letter|
    define_method letter do
      puts "I'm in method #{letter}"
    end
  end

  def method_missing(*args)
    puts 'Hello'
  end

end
