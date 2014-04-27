require 'spec_helper'

feature "edges page", js: true do #if making an Angular app you need to have js: true or your app won't run because it will only make normal http requests
  scenario "see the list of all edges" do
    create_list(:edge, 3)
    p Edge.all
    visit('/#/edges') #need to add # or else it can't find the URL. Remchi originally wrote this as /edges but it wouldn't work.
    expect(page).to have_css('ul#edges>li', count: 3)
  end

  scenario 'clicking on edge toggles description' do
    create(:edge, description: 'desc1')
    visit('/#/edges')
    expect(page).not_to have_content('desc1')
    first('ul#edges>li').click
    expect(page).to have_content('desc1')
    first('ul#edges>li').click
    expect(page).to_not have_content('desc2')
  end

  scenario 'only one descrption is active' do
    create(:edge, description: 'desc1')
    create(:edge, description: 'desc2')
    visit('/#/edges')

    expect(page).not_to have_content('desc1')
    first('ul#edges>li').click
    expect(page).to have_content('desc1')
    all('ul#edges>li')[2].click
    expect(page).not_to have_content('desc1')
  end

  scenario 'search for edge' do
    create(:edge, name: 'first')
    create(:edge, name: 'second')
    visit('/#/edges')

    find(:xpath, '//input[@type="search"]').set('fi')
    expect(page).to have_css('ul#edges>li', count: 1)
  end

  scenario 'filtering by category' do
    cat1 = create(:category, name: 'Background')
    cat2 = create(:category, name: 'Combat')
    create_list(:edge, 3, category: cat1)
    create_list(:edge, 2, category: cat2)
    visit('/#/edges')

    find(:xpath, '//option[contains(text(), "Background")]', 'Background').select_option
    expect(page).to have_css('ul#edges>li', count: 3)
    find(:xpath, '//option[contains(text(), "Combat")]', 'Combat').select_option
    expect(page).to have_css('ul#edges>li', count: 2)
  end

  scenario "filtering by rank" do
    create_list(:edge, 2)
    edge = create(:edge)
    rank = create(:requirement, mode: 'rank', name: nil, value: 'Novice', edge: edge)
    visit('/#/edges')

    find(:xpath, '//option[contains(text(), "Novice")]', 'Novice').select_option
    expect(page).to have_css('ul#edges>li', count: 1)
  end
end