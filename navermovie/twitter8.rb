require 'nokogiri'
require 'open-uri'
require 'twitter-korean-text-ruby'

processor = TwitterKorean::Processor.new
result = Hash.new
result_t = Hash.new

target_word1 = "곡성"


page_uri_prefix = "http://movie.naver.com/movie/board/review/list.nhn?&page="
post_uri_prefix = "http://movie.naver.com/movie/board/review/"


for i in 13548..13550
  page_uri_prefix = "http://movie.naver.com/movie/board/review/list.nhn?&page=#{i}"
  page = Nokogiri::HTML(open(page_uri_prefix))
  titles = page.css("td.title a")

  titles.each do |title|
    #puts title.content
    stemized = processor.stem(title.content).reject{ |c| c == " " }
    #puts stemized.inspect

    # stemized.each do |stem|
    #   unless stem.metadata.pos.to_s == "noun" || stem.metadata.pos.to_s == "proper_noun"
    #     next
    #   end
    #   if result[stem].nil?
    #     result[stem] = 1
    #   else
    #     result[stem] += 1
    #   end
    # end


    if stemized.include?(target_word1)
      puts title.content
      stemized = processor.stem(title.content).reject{ |c| c == " " }
      puts stemized.inspect


      post_uri = post_uri_prefix + title.attr('href')
      post = Nokogiri::HTML(open(post_uri))

      cons = post.css("div.text_area")
      cons.each do |con|
        stemized_con = processor.stem(con.content).reject{ |c| c == " " }

        stemized_con.each do |stem|
          unless stem.metadata.pos.to_s == "noun" || stem.metadata.pos.to_s == "adjective"
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

# result_t.delete_if{ |k,v| v <= 5}

#puts "==================all words===================="
#puts result.sort_by {|key, value| value}.reverse.to_h.inspect
puts "==================영화 #{target_word1} 관련 단어들 ===================="
puts result.sort_by {|key, value| value}.reverse.to_h.inspect
r1 = result_t.sort_by {|key, value| value}.reverse.to_h
puts r1.each { |key, value| puts key}
puts r1.each { |key, value| puts value}
