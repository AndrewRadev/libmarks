require 'rails_helper'

describe Bookmark do
  describe "github link" do
    let(:url) { 'http://github.com/AndrewRadev/splitjoin.vim' }
    let(:bookmark) { Bookmark.new(url: url) }

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
