# frozen_string_literal: true
#
require 'watir'
require 'nokogiri'
require 'ruby/openai'
require 'open-uri'

require_relative "job_summarizer/version"
require_relative "job_summarizer/ai_chat_model"
require_relative "job_summarizer/html_parser"

module JobSummarizer
  class Linkedin
    attr_reader :api_key, :url

    def initialize(openai_api_key, linkedin_url)
      @api_key = openai_api_key
      @url = linkedin_url
    end

    def generate_as_applicant
      result = AiChatModel::ApplicantAssistant.call(api_key, html)
      message_content(result)
    end

    def generate_as_recruiter
      result = AiChatModel::RecruiterJobSummary.call(api_key, html)
      message_content(result)
    end

    def html
      @html ||= HtmlParser::LinkedinJob.call(url)
    end

    def message_content(hash)
      hash.dig("choices").first.dig("message", "content")
    end
  end

  class Error < StandardError; end
end
