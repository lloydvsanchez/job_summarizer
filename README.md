## Usage

### Description
- Parses job descriptions from jobs sites (Linkedin for now) and uses AI to generate the following:
- As recruiter: summarizes description of the job posting
- As applicant: generates relevant sentences you can add to your resume based on the job posting (fighting fire with fire against job funnels ^_^)

### Usage
- `JobSummarizer::Linkedin.new(<openai access token>, <linkedin url>).generate_as_applicant`
- `JobSummarizer::Linkedin.new(<openai access token>, <linkedin url>).generate_as_recruiter`


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lloydvsanchez/job_summarizer.
