def capybara(some_str=nil)
  some_str = rendered if some_str.nil?
  Capybara.string(some_str)
end
