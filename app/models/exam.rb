class Exam < ActiveRecord::Base
    has_many :student_exams
    has_many :students, through: :student_exams

    def insert_feedback(student, grade, comment)
        StudentExam.create(grade: grade, student_id: student.id, teacher_comment: comment, exam_id: self.id)

    end  
    
    def class_average

        exams = StudentExam.select do |student_exam|
          student_exam.exam_id == self.id  

        end

        grades = exams.map {|exam| exam.grade}

        grades.inject(0.0) {|sum, grade| sum + grade} / grades.length
    end

    def self.used_exams

        exam_ids = StudentExam.all.map {|student_exam| student_exam.exam_id}.uniq

        exam_ids.map {|id| Exam.find(id)}
    end

    def self.lowest_average

        exam_averages = Exam.all.map {|exam| exam.class_average }

        grades = exam_averages.delete_if {|item| item.nan?}

        grades.min()

    end

    def self.drop_lowest_average

end
