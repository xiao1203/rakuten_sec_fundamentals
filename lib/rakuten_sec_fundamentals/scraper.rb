require 'mechanize'
require 'fundamentals/kabu_tec'

module RakutenSecFundamentals
  class Scraper
    def initialize(stock_code)
      # 楽天ダメだったので、日本東京証券取引所で実施
      @fundamental_page = scrape_page("http://quote.jpx.co.jp/jpx/template/quote.cgi?F=tmp/stock_detail&MKTN=T&QCODE=#{stock_code}")
      @closing_table_page = scrape_page("http://quote.jpx.co.jp/jpx/template/tmp/Jkessan.asp?QCODE=#{stock_code}")

      @kabutec_company_fs = scrape_page("https://www.kabutec.jp/company/fs_#{stock_code}.html")
    end


    private

    # スクレイピングを実施し、Mechanizeインスタンスを取得
    def scrape_page(url)
      agent = Mechanize.new
      scrate_instance = nil
      10.times do
        scrate_instance = agent.get(url)
        if (scrate_instance.code == "200")
          break
        else
          sleep(2)
        end
      end

      scrate_instance
    end

  end
end