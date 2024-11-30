# frozen_string_literal: true

require 'csv'
require_relative 'jobseeker'

class JobseekersParser
  attr_reader :jobseekers_csv_file

  def initialize(jobseekers_csv_file)
    @jobseekers_csv_file = jobseekers_csv_file
  end

  def results
    jobseekers = []

    CSV.foreach(jobseekers_csv_file, headers: true) do |row|
      jobseekers << Jobseeker.new(id: row['id'], name: row['name'], skills: row['skills'])
    end

    jobseekers
  end
end