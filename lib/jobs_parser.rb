# frozen_string_literal: true

require 'csv'
require_relative 'job'
require_relative 'shared/logger'

class JobsParser
  include Shared::Logger

  attr_reader :jobs_csv_file

  def initialize(jobs_csv_file)
    @jobs_csv_file = jobs_csv_file
  end

  def results
    parse_jobs_from_csv
  end

  private

  def parse_jobs_from_csv
    return enum_for(:parse_jobs_from_csv) unless block_given?

    CSV.foreach(jobs_csv_file, headers: true) do |row|
      yield build_job(row)
    end
  rescue StandardError => e
    log_error "Error while parsing the jobs CSV file(#{jobs_csv_file}): #{e.message}"
  end

  def build_job(row)
    Job.new(id: row['id'], title: row['title'], required_skills: row['required_skills'])
  end
end
