require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutArrayAssignment < Neo::Koan
  def test_non_parallel_assignment
    names = ["John", "Smith"] # Non-parallel assignment. It assigns the array to the variable.
    assert_equal ["John", "Smith"], names
  end

  def test_parallel_assignments
    first_name, last_name = ["John", "Smith"] # Parallel assignment. It unpacks the array into variables. First name gets "John", last name gets "Smith"
    assert_equal "John", first_name
    assert_equal "Smith", last_name
  end

  def test_parallel_assignments_with_extra_values
    first_name, last_name = ["John", "Smith", "III"] # Parallel assignment with more values than variables (like above). Extra values are ignored, in this case "III"
    assert_equal "John", first_name
    assert_equal "Smith", last_name
  end

  def test_parallel_assignments_with_splat_operator
    first_name, *last_name = ["John", "Smith", "III"] # In this case start symbol (*) will take all other values or in the middle
    assert_equal "John", first_name
    assert_equal ["Smith", "III"], last_name
  end

  def test_parallel_assignments_with_too_few_values # First variable assign value, second variable gets nil, not "" (empty string)
    first_name, last_name = ["Cher"]
    assert_equal "Cher", first_name
    assert_equal nil, last_name
  end

  def test_parallel_assignments_with_subarrays # Here we have a nested array. The first variable gets the first element of the subarray, and the second variable gets the second element.
    first_name, last_name = [["Willie", "Rae"], "Johnson"]
    assert_equal ["Willie", "Rae"], first_name
    assert_equal "Johnson", last_name
  end

  def test_parallel_assignment_with_one_variable # When we have only one variable, it gets the first element of the array, and the rest is ignored.
    first_name, = ["John", "Smith"]
    assert_equal "John", first_name
  end

  def test_swapping_with_parallel_assignment # Common assignments can be used to swap values. Here we swap first_name and last_name.
    first_name = "Roy"
    last_name = "Rob"
    first_name, last_name = last_name, first_name
    assert_equal "Rob", first_name
    assert_equal "Roy", last_name
  end
end
