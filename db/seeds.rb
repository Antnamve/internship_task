3.times do |school_index|
  school = School.create! name: Faker::Educator.university

  2.times do |class_index|
    StudyGroup.create! number: rand(1..11), letter: ('A'..'Z').to_a.sample, school_id: (school_index + 1)
  end
end