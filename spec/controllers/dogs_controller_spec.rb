require 'rails_helper'

RSpec.describe DogsController, type: :controller do
  describe '#index' do

    before do
      8.times { create(:dog) }
      get :index
    end

    it 'displays the 5 recent dogs' do
      expect(assigns(:dogs).size).to eq(5)
    end
  end
end
