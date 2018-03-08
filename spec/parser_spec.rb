module Keepasser
  describe Parser do
    context 'parse simple file' do
      parser = Parser.new 'spec/fixtures/simple.txt'

      it 'has entries' do
        expect(parser.length).to eq 3
      end

      it 'has correct entries' do
        entry = parser[0]
        expect(entry).to be_an Entry
        expect(entry.username).to eq 'bob.loblaw'
      end

      specify 'entries have a group' do
        expect(parser[2].group).to eq 'Bluth Company'
      end
    end
  end
end
