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

    # context 'parse a more complex file' do
    #   parser = Parser.new 'spec/fixtures/multiple-groups.txt'
    #
    #   it 'has groups' do
    #     expect(parser.map { |e| e['group'] }.uniq.length).to eq 2
    #   end
    #
    #   it 'has correct groups' do
    #     expect(parser[3]['group']).to eq 'Sitwell Enterprises'
    #   end
    # end
  end
end
