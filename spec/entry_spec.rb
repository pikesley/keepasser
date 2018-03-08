module Keepasser
  describe Entry do
    context 'make a simple entry' do
      source = """
Title:    Secret Stuff
Username: michael.bluth
Url:      https://bluth.com
Password: terrible_mistake
Comment:
      """
      entry = Entry.new source

      it 'has fields' do
        expect(entry.title).to eq 'Secret Stuff'
        expect(entry.username).to eq 'michael.bluth'
      end

      it 'rejects blank fields' do
        expect(entry.comment).to be nil
      end
    end

    context 'entry with multi-line comment' do
      source = """
Title:    Commented stuff
Username: gob.bluth
Url:
Password: loose_seal
Comment:   comments
           more comments
           yet more comments
      """
      entry = Entry.new source

      it 'has comments' do
        expect(entry.password).to eq 'loose_seal'
        expect(entry.comment).to eq [
          'comments',
          'more comments',
          'yet more comments'
        ]
      end
    end

    context 'assign a group' do
      source = """
Title:    Secret Stuff
Username: michael.bluth
      """
      entry = Entry.new source

      it 'takes a group' do
        entry.group = 'Blue Man Group'
        expect(entry.group).to eq 'Blue Man Group'
      end
    end
  end
end
