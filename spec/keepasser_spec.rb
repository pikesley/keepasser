module Keepasser
  describe Entry do
    it 'makes an entry' do
      source = """
Title:    Secret Stuff
Username: michael.bluth
Url:      https://bluth.com
Password: terrible_mistake
Comment:
      """

      entry = Entry.new source

      expect(entry.title).to eq 'Secret Stuff'
      expect(entry.username).to eq 'michael.bluth'
    end
  end
end
