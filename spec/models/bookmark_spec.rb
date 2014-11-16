require 'rails_helper'

describe Bookmark do
  describe "github link" do
    let(:url) { 'http://github.com/AndrewRadev/splitjoin.vim' }
    let(:bookmark) { Bookmark.new(url: url) }

    describe ".create_from_list" do
      it "can create a list of valid bookmarks" do
        valid_bookmarks, invalid_bookmarks = Bookmark.create_from_list([
          'http://google.com',
          'http://foo.bar',
        ])

        valid_bookmarks.count.should eq 2
        invalid_bookmarks.should be_empty
      end

      it "finds invalid bookmarks" do
        valid_bookmarks, invalid_bookmarks = Bookmark.create_from_list([
          'http://google.com',
          'foo bar baz',
        ])

        valid_bookmarks.count.should eq 1
        invalid_bookmarks.count.should eq 1
      end
    end

    describe "#fetch_url_info" do
      around :each do |example|
        Timecop.freeze { example.run }
      end

      it "fetches the right info from github" do
        stub_request(:get, 'https://api.github.com/repos/AndrewRadev/splitjoin.vim').to_return({
          body: {
            'description' => 'A vim plugin',
            'language'    => 'VimL',
          }.to_json
        })

        bookmark.fetch_url_info

        bookmark.info_fetched_at.should eq Time.zone.now
        bookmark.source.should eq 'github'
        bookmark.info.should eq({
          'description' => 'A vim plugin',
          'language'    => 'VimL',
        })
      end

      it "handles errors" do
        stub_request(:get, 'https://api.github.com/repos/AndrewRadev/splitjoin.vim').to_return({
          status: 500
        })

        bookmark.fetch_url_info

        bookmark.info_fetched_at.should eq Time.zone.now
        bookmark.source.should eq 'github_error'
        bookmark.info.should have_key("error")
      end
    end
  end
end
