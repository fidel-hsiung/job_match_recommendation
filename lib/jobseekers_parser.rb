# frozen_string_literal: true

require 'csv'
require_relative 'jobseeker'

class JobseekersParser
  attr_reader :jobseekers_csv_file

  def initialize(jobseekers_csv_file)
    @jobseekers_csv_file = jobseekers_csv_file
  end

  def results
    parse_jobseekers_from_csv
  end

  private

  def parse_jobseekers_from_csv
    return enum_for(:parse_jobseekers_from_csv) unless block_given?

    CSV.foreach(jobseekers_csv_file, headers: true) do |row|
      yield build_jobseeker(row)
    end
  end

  def build_jobseeker(row)
    Jobseeker.new(id: row['id'], name: row['name'], skills: row['skills'])
  end
end
