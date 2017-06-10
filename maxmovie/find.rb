require 'nokogiri'
require 'open-uri'
require 'mechanize'
agent= Mechanize.new
agent.request_headers = { "Accept-Encoding" => "" }    #Mechanize 객체 하나를 생성

i = 1
until i == 4
  page_raw = agent.get("http://extmovie.maxmovie.com/xe/index.php?mid=movietalk&page=#{i}")  #get 메소드를 사용하여 get 요청을 보낸 값을 가져옵니다.
  page = Nokogiri::HTML(page_raw.content)

  for x in 18..52
  titles = page.css("table//tbody//tr:nth-child(#{x})//td.title//a.pjax")
    titles.each do |title|
      puts title.content
    end
  end

  i += 1
end
