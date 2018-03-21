module Keepasser
  describe Parser do
    context 'parse simple file' do
      parser = Parser.new 'spec/fixtures/simple.txt'

      it 'has a path' do
        expect(parser.path).to eq 'spec/fixtures/simple.txt'
      end

      it 'has entries' do
        expect(parser.length).to eq 5
      end

      it 'has correct entries' do
        entry = parser[0]
        expect(entry).to be_an Entry
        expect(entry['title']).to eq 'CloudFlare'
        expect(entry['username']).to eq 'sam@fake.com'
        expect(entry['password']).to eq 'someoldpassword'
        expect(entry['group']).to eq 'web'
        expect(entry['id']).to eq 'web::CloudFlare'
      end
    end

    context 'parse a more complex file' do
      parser = Parser.new 'spec/fixtures/two-groups.txt'

      it 'has groups' do
        expect(parser.map { |e| e['group'] }.uniq.length).to eq 2
      end

      it 'has correct entries' do
        entry = parser[6]
        expect(entry['title']).to eq 'Nike'
        expect(entry['username']).to eq 'sam@fake.com'
        expect(entry['password']).to eq 'youdontneedmoresneakers'
        expect(entry['group']).to eq 'shops'
        expect(entry['id']).to eq 'shops::Nike'
      end
    end

    context 'monkey-patched String' do
      it 'detects a group' do
        expect('*** Group: web ***'.is_group?).to be true
        expect('  Title: Slashdot'.is_group?).to be false
      end

      it 'detects a title' do
        expect('  Title: Slashdot'.is_title?).to be true
        expect('  Url: https://slashdot.org'.is_title?).to be false
      end

      it 'extracts a group name' do
        expect("*** Group: web ***\n".group).to eq 'web'
      end
    end
  end
end
