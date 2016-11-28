class Item < ApplicationRecord
  belongs_to :wishlist

  def amazon?
    self.url != nil && self.url.include?("amazon")
  end

  def asin
    if self.amazon?
      page = MetaInspector.new(url)
      parsed_page = page.parsed
      long_list = parsed_page.css("li span.a-list-item").text
      return long_list.slice(long_list.index("ASIN:")+47,10)
    end
  end

  def iframe_url
    if self.amazon?
      iframe_url = "//ws-na.amazon-adsystem.com/widgets/q?ServiceVersion=20070822&OneJS=1&Operation=GetAdHtml&MarketPlace=US&source=ac&ref=tf_til&ad_type=product_link&tracking_id=thenewoutpro-20&marketplace=amazon&region=US&placement="+self.asin+"&asins="+self.asin+"&show_border=false&link_opens_in_new_window=true&price_color=333333&title_color=819bb3&bg_color=ffffff"

    end
  end

  def get_price
    if !self.amazon?
      page = MetaInspector.new(url)
      parsed_page = page.parsed
      long_list = parsed_page.css("h5.product-price").text
      return long_list.slice(long_list.index("$"),7)
    end
  end
end
