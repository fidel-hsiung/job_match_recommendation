# frozen_string_literal: true

require 'optparse'
require 'fileutils'
require_relative 'shared/logger'
require_relative 'job_match_recommendation'

class JobMatchRecommendationApp
  include Shared::Logger

  DEFAULT_JOBSEEKERS_CSV = 'data/jobseekers.csv'.freeze
  DEFAULT_JOBS_CSV = 'data/jobs.csv'.freeze

  attr_reader :jobseekers_csv_path, :jobs_csv_path, :errors

  def initialize
    @options = {}
    @errors = []
    parse_options
    set_csv_paths
    validate_csv_paths
  end

  def run
    if errors.any?
      log_error "#{@errors.join(', ')}."
      exit 1
    end

    job_recommendations = JobMatchRecommendation.new(jobseekers_file: jobseekers_csv_path, jobs_file: jobs_csv_path)
    job_recommendation_results = job_recommendations.results

    output_results(job_recommendation_results)
  end

  private

  def parse_options
    OptionParser.new do |opts|
      opts.banner = "Usage: ruby lib/job_match_recommendation_app.rb [options]"

      opts.on("-u", "--jobseekers JOBSEEKERS_CSV", "Path to the jobseekers CSV file") do |v|
        @options[:jobseekers_csv] = v
      end

      opts.on("-j", "--jobs JOBS_CSV", "Path to the jobs CSV file") do |v|
        @options[:jobs_csv] = v
      end

      opts.on("-h", "--help", "Displays the help message") do
        puts opts
        exit
      end
    end.parse!
  end

  def set_csv_paths
    @jobseekers_csv_path = @options[:jobseekers_csv] || DEFAULT_JOBSEEKERS_CSV
    @jobs_csv_path = @options[:jobs_csv] || DEFAULT_JOBS_CSV

    log('No jobseekers csv provided, using default jobseekers csv.') unless @options[:jobseekers_csv]
    log('No jobs csv provided, using default jobs csv.') unless @options[:jobs_csv]
  end

  def validate_csv_paths
    validate_csv(jobseekers_csv_path)
    validate_csv(jobs_csv_path)
  end

  def validate_csv(csv_path)
    return if File.file?(csv_path) && csv_path.end_with?('.csv')

    errors << "#{csv_path} does not exist or is not a valid csv"
  end

  def output_results(job_recommendations)
    if job_recommendations.empty?
      log('No job recommendations found.')
    else
      log('Job recommendations generated successfully.')
      display_job_recommendations(job_recommendations)
    end
  end

  def display_job_recommendations(job_recommendations)
    puts "\n\nJob Recommendations"
    puts 'jobseeker_id, jobseeker_name, job_id, job_title, matching_skill_count, matching_skill_percent'

    job_recommendations.each do |recommendation|
      puts recommendation.values_at(
        :jobseeker_id, :jobseeker_name, :job_id, :job_title, :matching_skill_count, :matching_skill_percent
      ).join(', ')
    end
  end
end
