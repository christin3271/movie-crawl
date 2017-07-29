require 'nokogiri'
require 'open-uri'

target_word = "곡성"
result = Array.new

for i in 13450..13470
  page_uri_prefix = "http://movie.naver.com/movie/board/review/list.nhn?&page=#{i}"
  page = Nokogiri::HTML(open(page_uri_prefix))
  titles = page.css("td.title a")

  titles.each do |title|
    words = title.content.gsub(/\s+/, "")
    if words.include?(target_word)
      result.push(1)
      puts words
    end
  end
end

puts result.size
