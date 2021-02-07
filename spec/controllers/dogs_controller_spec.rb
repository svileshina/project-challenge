require 'rails_helper'

RSpec.describe DogsController, type: :controller do
  describe '#index' do
    let(:dogs) { create_list(:dog, 6) }

    it 'displays recent dogs' do
      get :index
      expect((dogs).count).to eq(6)
    end
  end
end