require 'rails_helper'

RSpec.describe ApplicationController, type: :routing do
  describe 'root route' do

    it 'routes to courses#index' do
      expect(get: '/').to route_to("courses#index")
    end
  end
end
