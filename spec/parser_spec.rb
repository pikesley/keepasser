module Keepasser
  describe Parser do
    context 'parse simple file' do
      parser = Parser.new 'spec/fixtures/simple.txt'

      it 'has a path' do
        expect(parser.path).to eq 'spec/fixtures/simple.txt'
      end

      it 'has entries' do
        expect(parser['Bluth Company'].keys.length).to eq 3
      end

      it 'has correct entries' do
        entry = parser['Bluth Company']['Attorney']
        expect(entry).to be_an Entry
        expect(entry.username).to eq 'bob.loblaw'
        expect(entry['password']).to eq 'bobloblawlowblog'
      end

      specify 'entries have a group' do
        expect(parser['Bluth Company']['Attorney'].group).to eq 'Bluth Company'
      end
    end

    context 'parse a more complex file' do
      parser = Parser.new 'spec/fixtures/multiple-groups.txt'

      it 'has groups' do
        expect(parser.keys.length).to eq 2
      end

      it 'has correct groups' do
        expect(parser['Sitwell Enterprises']['Daughter'].group).to eq 'Sitwell Enterprises'
      end
    end
  end
end
