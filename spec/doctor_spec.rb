require('rspec')
require('pg')
require('doctor')
require('spec_helper')

DB = PG.connect({:dbname => 'doctor_office_test'})

describe(Doctor) do
  describe(".all") do
    it("starts off with no doctors") do
      expect(Doctor.all()).to(eq([]))
    end
  end

  describe("#name") do
    it("tells you its name") do
      doctor = Doctor.new({:id => 1, :name => "Doctor Doom", :id_specialties => 1})
      expect(doctor.name()).to(eq("Doctor Doom"))
    end
  end

  describe("#id_specialties") do
    it("sets its ID when you save it") do
      doctor = Doctor.new({:id => 1, :name => "Doctor Doom", :id_specialties => 1})
      doctor.save()
      expect(doctor.id_specialties()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
    it("lets you save doctors to the database") do
      doctor = Doctor.new({:id => 1, :name => "Doctor Doom", :id_specialties => 1})
      doctor.save()
      expect(Doctor.all()).to(eq([doctor]))
    end
  end

  describe("#==") do
    it("is the same doctor if it has the same name") do
      doctor1 = Doctor.new({:id => 1, :name => "Doctor Doom", :id_specialties => 1})
      doctor2 = Doctor.new({:id => 1, :name => "Doctor Doom", :id_specialties => 1})
      expect(doctor1).to(eq(doctor2))
    end
  end

  describe(".find") do
    it("returns a doctor by its ID") do
      test_doctor = Doctor.new({:id => 1, :name => "Doctor Doom", :id_specialties => 1})
      test_doctor.save()
      test_doctor2 = Doctor.new({:id => 2, :name => "Home stuff", :id_specialties => 2})
      test_doctor2.save()
      expect(Doctor.find(test_doctor2.id_specialties())).to(eq(test_doctor2))
    end
  end

  # describe("#tasks") do
  #   it("returns an array of tasks for that doctor") do
  #     test_doctor = Doctor.new({:id => 1, :name => "Doctor Doom", :id_specialties => 1})
  #     test_doctor.save()
  #     test_task = Task.new({:description => "Learn SQL", :doctor_id_specialties => test_doctor.id_specialties(), :deadline => "2017-09-05 00:00:00"})
  #     test_task.save()
  #     test_task2 = Task.new({:description => "Review Ruby", :doctor_id_specialties => test_doctor.id_specialties(), :deadline => "2017-09-05 00:00:00"})
  #     test_task2.save()
  #     expect(test_doctor).to(eq([test_task, test_task2]))
  #   end
  # end
end
