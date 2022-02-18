require_relative '../api/user'

RSpec.describe User do

  describe 'creating user' do
    context 'if have name and age valid' do
      let(:name) { 'Anton' }
      let(:age) { 30 }

      it 'checks valid is user?' do
        u1 = User.new
        u1.name = name
        u1.age = age

        expect(u1.valid?).to eq(true)
      end
    end

    context 'if have name invalid' do
      let(:name) {}
      let(:age) { 30 }

      it 'checks valid is user?' do
        u1 = User.new
        u1.name = name
        u1.age = age

        expect(u1.valid?).to eq(false)
      end
    end

    context 'if age 0' do
      let(:name) { 'Anton' }
      let(:age) { 0 }

      it 'checks valid is user?' do
        u1 = User.new
        u1.name = name
        u1.age = age

        expect(u1.valid?).to eq(false)
      end
    end
  end
end
