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

    context 'parse a more complex file' do
      parser = Parser.new 'spec/fixtures/multiple-groups.txt'

      it 'has entries' do
        expect(parser.length).to eq 4
      end

      it 'has correct groups' do
        expect(parser[0].group).to eq 'Bluth Company'
        expect(parser[3].group).to eq 'Sitwell Enterprises'
      end
    end
  end
end
