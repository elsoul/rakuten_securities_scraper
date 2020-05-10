require "rakuten_securities_scraper/version"
require "selenium-webdriver"

module RakutenSecuritiesScraper
  class Error < StandardError; end
  class RakutenScraper
    def initialize login_id, login_pw
      @login = {
        login_id: login_id,
        login_pw: login_pw
      }
    end

    def all_history
      driver = get_selenium_driver(:chrome)
      wait = Selenium::WebDriver::Wait.new(timeout: 100)
      url = "https://www.rakuten-sec.co.jp/ITS/V_ACT_Login.html"
      driver.get url
      driver.find_element(id: "form-login-id").send_keys @login[:login_id]
      driver.find_element(id: "form-login-pass").send_keys @login[:login_pw]
      driver.find_element(id: "login-btn").click
      wait.until { driver.find_element(id: "header-menu-button-asset") }
      driver.action.move_to(driver.find_element(id: "header-menu-button-asset")).perform
      wait.until { driver.find_element(xpath: "/html/body/div[2]/div/div/div[2]/ul[1]/li[1]/ul/li[1]/a") }
      driver.find_element(xpath: "/html/body/div[2]/div/div/div[2]/ul[1]/li[1]/ul/li[1]/a").click

      sleep 3
      span_select = Selenium::WebDriver::Support::Select.new(driver.find_element(:id, "termCd"))
      span_select.select_by(:value, "ALL")

      driver.find_element(css: "input[type='image']").click
      sleep 2
      rows = driver.find_elements(xpath: "//tr")
      page_num = rows[8].text.scan(/(.+)件中/)[0][0].to_i
      trade_table_data driver, page_num
    ensure
      driver.quit
    end

    def todays_history
      driver = get_selenium_driver(:chrome)
      wait = Selenium::WebDriver::Wait.new(timeout: 100)
      url = "https://www.rakuten-sec.co.jp/ITS/V_ACT_Login.html"
      driver.get url
      driver.find_element(id: "form-login-id").send_keys @login[:login_id]
      driver.find_element(id: "form-login-pass").send_keys @login[:login_pw]
      driver.find_element(id: "login-btn").click
      wait.until { driver.find_element(id: "header-menu-button-asset") }
      driver.action.move_to(driver.find_element(id: "header-menu-button-asset")).perform
      wait.until { driver.find_element(xpath: "/html/body/div[2]/div/div/div[2]/ul[1]/li[1]/ul/li[1]/a") }
      driver.find_element(xpath: "/html/body/div[2]/div/div/div[2]/ul[1]/li[1]/ul/li[1]/a").click

      driver.find_element(css: "input[type='image']").click
      sleep 2
      rows = driver.find_elements(xpath: "//tr")
      begin
        page_num = rows[8].text.scan(/(.+)件中/)[0][0].to_i
      rescue
        return "no data"
      end
      trade_table_data driver, page_num
    ensure
      driver.quit
    end

    def trade_table_data driver, page_num
      run_times = page_num.divmod(20)
      trade_records = []
      (1..run_times[0]-1).each do |f|
        rows = driver.find_elements(xpath: "//tr")
        rows[10..29].map do |row|
          cells = row.find_elements(:css, "td").map { |a| a.text.strip.gsub(",", "") }
          trade_records << {
            bit_date: cells[0].split("\n")[0],
            gain_date: cells[0].split("\n")[1],
            stock_name: cells[1].split("\n")[0],
            code: cells[1].split("\n")[1].split(" ")[0],
            market: cells[1].split("\n")[1].split(" ")[1],
            account: cells[2],
            trade_type: cells[3].split("\n")[0],
            buy_sell: cells[3].split("\n")[1],
            credit: cells[4].split("\n")[0],
            due: cells[4].split("\n")[1],
            stocks: cells[5].split("\n")[0].gsub(" 株", ""),
            price: cells[5].split("\n")[1],
            fee: cells[6].split("\n")[0],
            tax: cells[6].split("\n")[1],
            charge: cells[7].split("\n")[0],
            tax_type: cells[7].split("\n")[1],
            total_price: cells[8]
          }
          return trade_records if page_num < 20
        end
        driver.find_element(link: "次の20件").click
      end
      sleep 2
      driver.find_element(link: "次の#{run_times[1]}件").click
      rows = driver.find_elements(xpath: "//tr")
      rows[10.."1#{run_times[1]}".to_i-1].map do |row|
        cells = row.find_elements(:css, "td").map { |a| a.text.strip.gsub(",", "") }
        trade_records << {
          bit_date: cells[0].split("\n")[0],
          gain_date: cells[0].split("\n")[1],
          stock_name: cells[1].split("\n")[0],
          code: cells[1].split("\n")[1].split(" ")[0],
          market: cells[1].split("\n")[1].split(" ")[1],
          account: cells[2],
          trade_type: cells[3].split("\n")[0],
          buy_sell: cells[3].split("\n")[1],
          credit: cells[4].split("\n")[0],
          due: cells[4].split("\n")[1],
          stocks: cells[5].split("\n")[0].gsub(" 株", ""),
          price: cells[5].split("\n")[1],
          fee: cells[6].split("\n")[0],
          tax: cells[6].split("\n")[1],
          charge: cells[7].split("\n")[0],
          tax_type: cells[7].split("\n")[1],
          total_price: cells[8]
        }
      end
      trade_records
    end

    def get_selenium_driver(mode = :chrome)
      case mode
      when :firefox_remote_capabilities
        firefox_capabilities = Selenium::WebDriver::Remote::Capabilities.firefox
        Selenium::WebDriver.for(:remote, url: "http://hub:4444/wd/hub", desired_capabilities: firefox_capabilities)
      when :firefox
        Selenium::WebDriver.for :firefox
      else
        options = Selenium::WebDriver::Chrome::Options.new
        # options.add_argument("--ignore-certificate-errors")
        options.add_argument("--disable-popup-blocking")
        options.add_argument("--disable-translate")
        options.add_argument("-headless")
        Selenium::WebDriver.for :chrome, options: options
      end
    end
  end
end
