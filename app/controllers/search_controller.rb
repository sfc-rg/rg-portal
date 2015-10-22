class SearchController < ApplicationController
  before_action :require_active_current_user
  before_action :set_keyword, except: :index
  before_action :set_page_results, only: [:show, :pages]
  before_action :set_slack_results, only: [:show, :slack]

  SLACK_SOLR_SERVER_ADDR = 'http://localhost:58983/solr/rg_slack'
  SLACK_ALLOW_FILTER_OPTIONS = [ 'room', 'user', 'mention_user' ].freeze

  def index

  end

  def show

  end

  private

  def set_keyword
    @keyword = params[:keyword]
  end

  def set_page_results
    @page_results = Page.where('content LIKE ?', "%#{@keyword}%")
  end

  def set_slack_results
    options = SLACK_ALLOW_FILTER_OPTIONS.each_with_object([]) do |option, object|
      value = params["slack_#{option}"]
      object << "#{option}:#{value}" if value.present?
    end
    solr = RSolr.connect(url: SLACK_SOLR_SERVER_ADDR)
    result = solr.get('select', params: { q: @keyword, fq: options, sort: 'timestamp desc' })
    @slack_results = result['response']['docs'].map do |doc|
      { id: doc['id'],
        room: doc['room'],
        user: doc['user'],
        mention_user: doc['mention_user'],
        message: doc['message'],
        timestamp: Time.parse(doc['timestamp']),
      }
    end
  end
end
