# Job Match Recommendation Engine

This project implements a basic job-matching recommendation engine that suggests jobs to jobseekers based on their skills. The engine reads two CSV files: one containing jobseekers and their skills, and the other containing jobs and the required skills. The program matches jobseekers to jobs based on skill overlap and outputs job recommendations, sorted first by jobseeker ID in ascending order, then by the percentage of matching skills in descending order, last by job ID in ascending order.

## Requirements
- Ruby 3.0 or above
- Bundler

## Installation

1. Clone the repository.
2. Run `bundle install` to install dependencies.

## Running the Program

1. Run the program with default csvs, `ruby main.rb`
2. Run the program with custom csvs, `ruby main.rb -u path/to/jobseekers.csv -j path/to/jobs.csv`
3. View help instructions, `ruby main.rb -h`

## Example Output

Here's an example of what the output might look like:

```
jobseeker_id, jobseeker_name, job_id, job_title, matching_skill_count, matching_skill_percent
1, Alice, 5, Ruby Developer, 3, 100
1, Alice, 2, .NET Developer, 3, 75
1, Alice, 7, C# Developer, 3, 75
1, Alice, 4, Dev Ops Engineer, 4, 50
2, Bob, 3, C++ Developer, 4, 100
2, Bob, 1, Go Developer, 3, 75
...
```

## Tests

To run the tests, execute `rspec`
