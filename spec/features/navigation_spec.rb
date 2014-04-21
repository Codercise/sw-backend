require 'spec_helper'

describe "Navigation Menu", js: true do
  it "changes active menu element depending on route" do
    visit '/'
    expect(find('.active').find('a').text).to eq('Home')

    click_link('Edges')
    expect(find('.active').find('a').text).to eq('Edges')
  end
end