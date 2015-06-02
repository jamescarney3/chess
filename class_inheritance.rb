class Employee
  attr_reader :salary

  def initialize(fname, lname, title, salary)
    @name = "#{fname.capitalize} #{lname.capitalize}"
    @title = title
    @salary = salary
    @boss = nil
  end

  def assign_manager(boss)
    raise "Not a manager" unless boss.is_a?(Manager)
    boss.subordinates << self
    @boss = boss

    nil
  end

  def bonus(multiplier)
    salary * multiplier
  end

end

class Manager < Employee

  attr_accessor :subordinates

  def initialize(fname, lname, title, salary)
    super
    @subordinates = []
  end

  def bonus(multiplier)
    get_sub_salary * multiplier
  end

  def get_sub_salary
    queue = @subordinates
    total_salary = 0
    until queue.empty?
      emp = queue.shift
      total_salary += emp.salary
      if emp.is_a?(Manager)
        queue.concat(emp.subordinates)
      end
    end

    total_salary
  end


end
