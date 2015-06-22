module ApplicationHelper
  # HTMLで書けない文字の実体参照と改行コードのHTMLへの置換を行う
  def br(text)
    ans = ''
    in_pre = false
    text.split(/(<pre)|(<\/pre>)/).each do |st|
      if st == '<pre'
      in_pre = true
      ans << st
      next
      elsif st == '</pre>'
      in_pre = false
      ans << st
      next
      end
      ans << ((in_pre == true)? st : st.gsub(/\r\n|\r|\n/, '<br/>'))
    end
    ans.html_safe
  end

  def tag_erase(text)
    ans = ''
    in_pre = false
    text.split(/(<)|(>)/).each do |st|
      if st == '<'
        in_pre = true
        ans << ''
      next
      elsif st == '>'
        in_pre = false
        ans << ''
      next
      end
      ans << ((in_pre == true)? '' : st)
    end
    ans.html_safe
  end
end