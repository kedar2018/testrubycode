require "pstore" # https://github.com/ruby/pstore

STORE_NAME = "tendable2.pstore"
@store = PStore.new(STORE_NAME)
@answer_report = {}
@survey_count = 1
QUESTIONS = {
  "q1" => "Can you code in Ruby?",
  "q2" => "Can you code in JavaScript?",
  "q3" => "Can you code in Swift?",
  "q4" => "Can you code in Java?",
  "q5" => "Can you code in C#?"
}.freeze

# TODO: FULLY IMPLEMENT
def do_prompt
  yes_answer = 0
  # Ask each question and get an answer from the user's input.
  QUESTIONS.each_key do |question_key|
    print QUESTIONS[question_key]
    ans = gets.chomp
    yes_answer = yes_answer + 1 if ans == 'y'
  end
  @store.transaction do 
    @store[:yes_rating] ||= Array.new
    @store[:yes_rating].push( ( 100 * yes_answer ) / 5 )
  end
end

def do_report
  # TODO: IMPLEMENT
  @store.transaction do
    p "the rating of yes of last survey #{@store[:yes_rating].last}"
  end
  # average rating of all survey
  @store.transaction do
    total_survey_size = @store[:yes_rating].size 
    total_percentage = @store[:yes_rating].sum
    p "The Average of Toatl Survey only with yes answer #{( total_percentage  / total_survey_size)}"
  end
end
do_prompt
do_report
