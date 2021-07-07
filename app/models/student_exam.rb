class StudentExam < ActiveRecord::Base
    belongs_to :student
    belongs_to :exam

    def print_details
        puts "#{self.student.name} took the #{self.exam.subject} exam receiving a score of #{self.grade}"
    end

    def questions_correct_ratio
        questions = self.exam.total_questions
        grade_percentage = self.grade
        questions_right = (grade_percentage * questions) / 100
        string = "#{questions_right} questions out of #{questions} questions total"
    end

end