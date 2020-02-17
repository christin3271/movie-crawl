require 'nokogiri'
require 'open-uri'
require 'twitter-korean-text-ruby'

processor = TwitterKorean::Processor.new
result_t = Hash.new

target_word1 = "부산행"


page_uri_prefix = "http://movie.naver.com/movie/board/review/list.nhn?&page="
post_uri_prefix = "http://movie.naver.com/movie/board/review/"


for i in 10250..10750
  page_uri_prefix = "http://movie.naver.com/movie/board/review/list.nhn?&page=#{i}"
  page = Nokogiri::HTML(open(page_uri_prefix))
  titles = page.css("td.title a")

  titles.each do |title|
    stemized = processor.stem(title.content).reject{ |c| c == " " }


    if stemized.include?(target_word1)
      post_uri = post_uri_prefix + title.attr('href')
      post = Nokogiri::HTML(open(post_uri))

      cons = post.css("div.text_area")
      cons.each do |con|
        stemized_con = processor.stem(con.content).reject{ |c| c == " " }

        stemized_con.each do |stem|
          unless stem.metadata.pos.to_s == "verb" || stem.metadata.pos.to_s == "adjective"
            next
          end
          if result_t[stem].nil?
            result_t[stem] = 1
          else
            result_t[stem] += 1
          end

        end
      end
    end
  end
end

result_t.delete_if{ |k,v| v <= 5}

#puts "==================all words===================="
#puts result.sort_by {|key, value| value}.reverse.to_h.inspect
puts "==================영화 #{target_word1} 관련 단어들 ===================="
r1 = result_t.sort_by {|key, value| value}.reverse.to_h
puts r1.each { |key, value| puts key}
puts r1.each { |key, value| puts value}
