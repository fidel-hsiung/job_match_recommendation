# frozen_string_literal: true

require 'csv'
require_relative 'job'

class JobsParser
  attr_reader :jobs_csv_file

  def initialize(jobs_csv_file)
    @jobs_csv_file = jobs_csv_file
  end

  def results
    jobs = []

    CSV.foreach(jobs_csv_file, headers: true) do |row|
      jobs << Job.new(id: row['id'], title: row['title'], required_skills: row['required_skills'])
    end

    jobs
  end
end