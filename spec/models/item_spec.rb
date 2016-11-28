require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

RSpec.describe Item, :type => :model do
  it { should belong_to :wishlist }
  it { should respond_to :url }
  it { should respond_to :name }

  it "identify that the link is from amazon" do
    DatabaseCleaner.clean
    user = FactoryGirl.create(:user)
    wishlist = FactoryGirl.create(:wishlist, user: user)
    url = "https://www.amazon.com/Aldo-ACAWIEN-Acawien-Cognac/dp/B01L1KUI0E/ref=sr_1_18?m=ATVPDKIKX0DER&s=apparel&ie=UTF8&qid=1480273653&sr=1-18&nodeID=15743631&refinements=p_6%3AATVPDKIKX0DER%2Cp_36%3A-7498"
    item = FactoryGirl.create(:item, wishlist_id: wishlist.id, url: url)
    expect(item.amazon?).to eq(true)
  end

  it "identify when the link is not from amazon" do
    DatabaseCleaner.clean
    user = FactoryGirl.create(:user)
    wishlist = FactoryGirl.create(:wishlist, user: user)
    url = "http://bananarepublic.gap.com/browse/product.do?cid=1005911&vid=1&pid=378981002"
    item = FactoryGirl.create(:item, wishlist_id: wishlist.id, url: url)
    expect(item.amazon?).to eq(false)
  end

  it  "should return the correct asin from an amazon url" do
    DatabaseCleaner.clean
    user = FactoryGirl.create(:user)
    wishlist = FactoryGirl.create(:wishlist, user: user)
    url = "https://www.amazon.com/Aldo-ACAWIEN-Acawien-Cognac/dp/B01L1KUI0E/ref=sr_1_18?m=ATVPDKIKX0DER&s=apparel&ie=UTF8&qid=1480273653&sr=1-18&nodeID=15743631&refinements=p_6%3AATVPDKIKX0DER%2Cp_36%3A-7498"
    item = FactoryGirl.create(:item, wishlist_id: wishlist.id, url: url)
    expect(item.asin).to eq('B01L1KUI0E')
  end

  it "should return the correct iframe for the amazon url" do
    DatabaseCleaner.clean
    user = FactoryGirl.create(:user)
    wishlist = FactoryGirl.create(:wishlist, user: user)
    url = "https://www.amazon.com/Aldo-ACAWIEN-Acawien-Cognac/dp/B01L1KUG92/ref=sr_1_18?m=ATVPDKIKX0DER&s=apparel&ie=UTF8&qid=1480273653&sr=1-18&nodeID=15743631&refinements=p_6%3AATVPDKIKX0DER%2Cp_36%3A-7498&th=1"
    item = FactoryGirl.create(:item, wishlist_id: wishlist.id, url: url)
    expect(item.iframe_url).to eq('//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ss&ref=as_ss_li_til&ad_type=product_link&tracking_id=apple-4-20&marketplace=amazon&region=US&placement=B01L1KUG92&asins=B01L1KUG92&linkId=6c2c423f1257586f2d9165eafdd5df63&show_border=true&link_opens_in_new_window=true')
  end

  it "should return the price from a non-amazon url" do
    DatabaseCleaner.clean
    user = FactoryGirl.create(:user)
    wishlist = FactoryGirl.create(:wishlist, user: user)
    url = "http://bananarepublic.gap.com/browse/product.do?cid=1014739&pid=485777002&mlink=1014329,10559146,485777002&clink=10559146,Striped%20Off%20The%20Shoulder%20Dress"
    item = FactoryGirl.create(:item, wishlist_id: wishlist.id, url: url)
    expect(item.get_price).to eq('$52.99')
  end
end
