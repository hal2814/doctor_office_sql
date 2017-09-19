require('rspec')
require('pg')
require('specialty')
require('spec_helper')

DB = PG.connect({:dbname => 'doctor_office_test'})

describe(Specialty) do
  describe(".all") do
    it("starts off with no specialties") do
      expect(Specialty.all()).to(eq([]))
    end
  end

  describe("#specialty") do
    it("tells you its specialty") do
      specialty = Specialty.new({:specialty => "Primary care", :id => 1})
      expect(specialty.specialty()).to(eq("Primary care"))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      specialty = Specialty.new({:specialty => "Primary care", :id => 1})
      specialty.save()
      expect(specialty.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
    it("lets you save specialties to the database") do
      specialty = Specialty.new({:specialty => "Primary care", :id => 1})
      specialty.save()
      expect(Specialty.all()).to(eq([specialty]))
    end
  end

  # describe("#==") do
  #   it("is the same specialty if it has the same speciality") do
  #     specialty1 = Specialty.new({:speciality => "Primary care", :id => 1})
  #     specialty2 = Specialty.new({:speciality => "Primary care", :id => 1})
  #     expect(specialty1).to(eq(specialty2))
  #   end
  # end

  describe(".find") do
    it("returns a specialty by its ID") do
      test_specialty = Specialty.new({:specialty => "Primary care", :id => 1})
      test_specialty.save()
      test_specialty2 = Specialty.new({:specialty => "Neurology", :id => 2})
      test_specialty2.save()
      expect(Specialty.find(test_specialty2.id())).to(eq(test_specialty2))
    end
  end

  # describe("#tasks") do
  #   it("returns an array of tasks for that specialty") do
  #     test_doctor = Specialty.new({:speciality => "Primary care", :id => 1})
  #     test_doctor.save()
  #     test_task = Task.new({:description => "Learn SQL", :doctor_id => test_doctor.id(), :deadline => "2017-09-05 00:00:00"})
  #     test_task.save()
  #     test_task2 = Task.new({:description => "Review Ruby", :doctor_id => test_doctor.id(), :deadline => "2017-09-05 00:00:00"})
  #     test_task2.save()
  #     expect(test_doctor).to(eq([test_task, test_task2]))
  #   end
  # end
end
