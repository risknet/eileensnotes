module ApplicationHelper
  
  def title(page_title)
    if page_title == ""
      page_title = "online Q&A site for anyone. Help others with your knowledge"
    end 
    content_for(:title) { page_title }  
  end
  
  def get_user(user_id)
    @user = User.find_by_id(user_id)
  end
  
  def get_user_name(user_id)
    get_user_name_email(user_id)
  end
  
  def get_user_name_email(user_id)
    @get_user = User.find_by_id(user_id)
    if @get_user == nil
      nil
    else
      if @get_user.name
        @get_user.name
      else
        @get_user.email
      end
    end
  end
  
  # render markdown text
  def markdownText(text)
    options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode]
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, 
                                       :autolink => true, 
                                       :hard_wrap => true,
                                       :filter_html => true,
                                       :no_intraemphasis => true,
                                       :fenced_code => true,
                                       :gh_blockcode => true,
                                       :space_after_headers => true)
    # raw markdown.render(text)
    #syntax_highlighter(markdown.render(text)).html_safe
    coderay(markdown.render(text)).html_safe
  end
  
  # this is using CodeRay to do syntax highlighting
  def coderay(text)
    text.gsub(/\<code( lang="(.+?)")?\>(.+?)\<\/code\>/m) do
      # need to check if the language is supported
      if limit_code_type($2) != 'empty'
        code_type = limit_code_type($2)
        CodeRay.scan(unescape($3), code_type).div(:line_numbers => nil)
      end
    end
  end
  
  # this is using Pygments? to do syntax highlighting
  def syntax_highlighter(html)
    doc = Nokogiri::HTML(html)
    doc.search("//pre[@lang]").each do |pre|
      pre.replace Albino.colorize(pre.text.rstrip, pre[:lang])
    end
    doc.to_s
  end
  
  # make coderay support only these languages
  def limit_code_type(code_type)
    if code_type != nil
      code_type = code_type.downcase
      if ['c', 'clojure', 'css', 'delphi', 'diff', 'erb', 'groovy', 'haml', 'html', 'java', 'javascript',
        'json', 'php', 'python', 'ruby', 'sql', 'xml', 'yaml'].include?(code_type) 
        code_type
      else
        'c'
      end
    else
      'empty'
    end
  end
  
  # coderay escaped these characters, so i need to manually unescape to display them in codeblock
  def unescape(content)
    content.gsub!(/(&quot;|&#39;|&amp;|&lt;|&gt;)/) do
      case $1
        when "&quot;"
          '"'
        when "&#39;"
          "'"
        when "&amp;"
          "&"
        when "&lt;"
          "<"
        when "&gt;"
          ">"
      end
    end
  end

end
