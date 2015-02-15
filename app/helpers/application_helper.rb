module ApplicationHelper
  # HTMLで書けない文字の実体参照と改行コードのHTMLへの置換を行う
  def br(text)
  return text if text.nil?
  text = h text
  text.gsub(/\r\n|\r|\n/, "<br />").html_safe
  end
end
