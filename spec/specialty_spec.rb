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

  describe("#special") do
    it("tells you its special") do
      special = Specialty.new({:special => "Primary care", :id => 1})
      expect(special.special()).to(eq("Primary care"))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      special = Specialty.new({:special => "Primary care", :id => 1})
      special.save()
      expect(special.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
    it("lets you save specialties to the database") do
      special = Specialty.new({:special => "Primary care", :id => 1})
      special.save()
      expect(Specialty.all()).to(eq([special]))
    end
  end

  describe("#==") do
    it("checks if it is the same object") do
      special1 = Specialty.new({:special => "Primary care", :id => 1})
      special2 = Specialty.new({:special => "Primary care", :id => 1})
      expect(special1).to(eq(special2))
    end
  end

  describe(".find") do
    it("returns a special by its ID") do
      test_special = Specialty.new({:special => "Primary care", :id => 1})
      test_special.save()
      test_special2 = Specialty.new({:special => "Neurology", :id => 2})
      test_special2.save()
      expect(Specialty.find(test_special2.id())).to(eq(test_special2))
    end
  end

  # describe("#tasks") do
  #   it("returns an array of tasks for that special") do
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
