RSpec.describe RakutenSecuritiesScraper do
  before(:each) do
    @a1 = RakutenSecuritiesScraper::RakutenScraper.new(ENV["LOGIN_ID"], ENV["LOGIN_PW"])
  end
  it "has a version number" do
    expect(RakutenSecuritiesScraper::VERSION).not_to be nil
  end

  it "Get All Trade History" do
    a1 = @a1.all_history
    expect(a1[0][:stocks].to_i).to be > 0
  end

  it "Get Today's Trade History" do
    a1 = @a1.todays_history
    expect(a1).to eq "no data"
  end
end
