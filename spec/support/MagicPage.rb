class DynamicPage < SitePrism::Page

  def include_sections(*syms)
    syms.each do |sym|
      klass = sym.to_s.camelize.constantize
      self.singleton_class.section(sym, klass, klass.default_locator)
    end
  end
end

class DynamicSection < SitePrism::Section
  def self.set_default_locator(locator)
    @default_locator = locator
  end
  def self.default_locator
    @default_locator
  end
end
