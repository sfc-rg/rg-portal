module SearchHelper
  DEFAULT_DATE_FORMAT = '%Y年%m月%d日 %H:%M %p'
  HIGHLIGHT_TRANCATE_LENGTH = 100

  def highlight_content(keyword, content)
    i = content.index(keyword)
    min_index = [i - HIGHLIGHT_TRANCATE_LENGTH, 0].max
    max_index = [i + HIGHLIGHT_TRANCATE_LENGTH, content.size - 1].min
    match_content = content[min_index..max_index]
    match_content = match_content.gsub(keyword, "<span class=\"highlight\">\\0</span>")
    "#{min_index != 0 ? '...' : ''}#{match_content}#{max_index != content.size - 1 ? '...' : ''}"
  end

  def slack_log_url(result)
    "https://sfc-rg.slack.com/archives/#{result[:room]}/p#{result[:id].gsub(/\./, '')}"
  end

  def slack_log_date(timestamp)
    timestamp.strftime(DEFAULT_DATE_FORMAT)
  end
end
