module SearchHelper
  DEFAULT_DATE_FORMAT = '%Y年%m月%d日 %H:%M %p'

  def slack_log_url(result)
    "https://sfc-rg.slack.com/archives/#{result[:room]}/p#{result[:id].gsub(/\./, '')}"
  end

  def slack_log_date(timestamp)
    timestamp.strftime(DEFAULT_DATE_FORMAT)
  end
end
