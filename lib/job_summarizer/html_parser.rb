module HtmlParser
  class Base
    def self.call(url)
      new(url).send(:parse)
    end

    private

    def initialize(url)
      @url = url
    end

    attr_reader :url

    def html_element
      browser = Watir::Browser.new :chrome, headless: true
      browser.goto url
      browser.element(css: css_selector).wait_until(&:present?)
    end

    def parse
      element = Nokogiri::HTML(html_element.inner_html)
      element.inner_text.delete("\n").gsub(/\s\s+/,'')
    end

    def css_selector
      raise UnimplementedError
    end
  end

  class LinkedinJob < Base
    def css_selector
      ".show-more-less-html"
    end
  end

  class UnimplementedError < StandardError; end
end
