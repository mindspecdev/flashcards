require "open-uri"

puts 'CREATING CARDS'

Card.delete_all

url = "http://www.languagedaily.com/learn-german/vocabulary/common-german-words"

doc = Nokogiri::HTML(open(url))
doc.css('div.jsn-article-content table tbody tr').each do |word|
  original_text = word.css('td.bigLetter')
  translated_text = word.css('td')[2]  
  if original_text
    Card.create(original_text: original_text.text, translated_text: translated_text.text, review_date: '2015-01-01')
  end
end
