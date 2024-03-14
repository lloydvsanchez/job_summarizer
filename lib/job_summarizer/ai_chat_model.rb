module AiChatModel
  class Base
    def self.call(api_key, source)
      return nil unless source.is_a?(String) && source.length > 0

      new(api_key, source).send(:call)
    end

    private

    attr_reader :user_content, :api_key

    def initialize(api_key, source)
      @user_content = source
      @api_key = api_key
    end

    def call
      client = OpenAI::Client.new(access_token: api_key)
      client.chat(
        parameters: {
          model: model,
          messages: [
            { role: "system", content: system_prompt },
            { role: "user", content: "Job Description: #{user_content}"}
          ],
          temperature: temperature,
          max_tokens: max_tokens
        }
      )
    end

    def max_tokens
      300
    end

    def model
      "gpt-3.5-turbo"
    end

    def temperature
      0.7
    end

    def system_prompt
      raise UnimplementedError
    end
  end

  class RecruiterJobSummary < Base
    def system_prompt
      "You are a recruiter. Summarize the job description below in a list of 3-5 sentences with each sentence containing at most 50 words. Also, make a list of essential keywords from the job description"
    end
  end

  class ApplicantAssistant < Base
    def system_prompt
      "You are a job applicant. Create a list of 5-10 sentences in bullet form containing at most 50 words based on the Job Description below which can be added to your job application to make you standout. Do not start the sentences with I. Also, make a list of essential keywords from the job description"
    end
  end

  class UnimplementedError < StandardError; end
end
