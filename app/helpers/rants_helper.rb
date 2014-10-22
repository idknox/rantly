module RantsHelper
  def hashtagable(text)
    new_body = text.split(' ').map do |word|
      if word[0] == '#'
        "<a class='hashtag' href='/search/results?search=%23#{word[1..-1]}'>#{word}</a>"
      else
        word
      end
    end
    markdown(new_body.join(' ').html_safe)
  end
end