require 'open-uri'

puts 'CREATING Cards'

Card.delete_all

user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_0) AppleWebKit/535.2 (KHTML, like Gecko) Chrome/15.0.854.0 Safari/535.2"

html = "http://www.languagedaily.com/learn-german/vocabulary/common-german-words"

@doc = Nokogiri::HTML(open(html, 'User-Agent' => user_agent), nil, "UTF-8")
@doc.css('div.jsn-article-content table tbody tr').each_with_index { |word, index|
  original_text = word.css('td.bigLetter')
  translated_text = word.css('td')[2]  
  if original_text
    Card.create(original_text: original_text.text, translated_text: translated_text.text, review_date: '2015-01-01')
  end
}
