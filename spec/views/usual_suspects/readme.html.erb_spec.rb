require 'rails_helper'

RSpec.describe "usual_suspects/readme.html.erb", type: :view do
  it 'renders' do
    expect{ render }.to_not raise_error
  end
end
