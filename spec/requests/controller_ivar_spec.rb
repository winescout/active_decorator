require 'spec_helper'

feature 'decorating controller ivar' do
  background do
    @matz = Author.create! :name => 'matz'
    Author.create! :name => 'takahashim'
  end
  
  after do
    Author.delete_all
  end

  scenario 'decorating a model object in ivar' do
    visit "/authors/#{@matz.id}"
    page.should have_content 'matz'
    page.should have_content 'matz'.capitalize
  end

  scenario 'decorating model scope in ivar' do
    visit '/authors'
    page.should have_content 'takahashim'
    page.should have_content 'takahashim'.reverse
  end

  scenario "decorating models' array in ivar" do
    visit '/authors?variable_type=array'
    page.should have_content 'takahashim'
    page.should have_content 'takahashim'.reverse
  end

  scenario "decorating Model with arbitrary decorator" do
    visit "/authors/#{@matz.id}"
    page.should have_content @matz.name.insert(0, 'Awesome he is, ')
  end
end
