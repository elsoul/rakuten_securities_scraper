RSpec.describe RakutenSecuritiesScraper do
  before(:each) do
    @a1 = RakutenSecuritiesScraper::RakutenScraper.new(ENV["LOGIN_ID"], ENV["LOGIN_PW"])
  end
  # it "has a version number" do
  #   expect(RakutenSecuritiesScraper::VERSION).not_to be nil
  # end

  # it "Get All Trade History" do
  #   a1 = @a1.all_history
  #   expect(a1[0][:stocks].to_i).to be > 0
  # end

  # it "Get Today's Trade History" do
  #   a1 = @a1.todays_history
  #   expect(a1).to eq "no data"
  # end

  # it "Get Today's Transaction" do
  #   a1 = @a1.todays_order
  #   expect(a1[0][:order_id].size).to eq 4
  # end

  # it "Save Favorite List" do
  #   codes = ["4755", "3853", "6580"]
  #   a1 = @a1.favorite 3, codes
  #   expect(a1[:status]).to eq "success"
  # end

  it "Delete Favorite List" do
    a1 = @a1.delete_favorite 3
    expect(a1[:status]).to eq "success"
  end
end
