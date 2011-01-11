require File.dirname(__FILE__) + '/test_helper'
require 'fixtures/enumeration'

class EnumerationsTest < Test::Unit::TestCase
  class EnumController < ActionController::Base
    def test1
      @test = Enumeration.new
      render :inline => "<%= input('test', 'severity')%>"
    end

    def test2
      @test = Enumeration.new
      render :inline => "<%= enum_radio('test', 'severity')%>"
    end
  end

  def setup
    Enumeration.connection.execute 'DELETE FROM enumerations'
  end
  
  def test_column_values
    columns = Enumeration.columns_hash
    color_column = columns['color']
    assert color_column
    assert_equal [:red, :blue, :green, :yellow], color_column.values

    severity_column = columns['severity']
    assert severity_column
    assert_equal [:low, :medium, :high, :critical], severity_column.values
    assert_equal :medium, severity_column.default
  end

  def test_insert_enum
    row = Enumeration.new
    row.color = :blue
    row.string_field = 'test'
    assert_equal :medium, row.severity
    assert row.save

    db_row = Enumeration.find(row.id)
    assert db_row
    assert :blue, row.color
    assert :medium, row.severity
  end

  # Uses the automatic validates_columns to create automatic validation rules
  # for columns based on the schema information.
  def test_bad_value
    row = Enumeration.new
    row.color = :violet
    row.string_field = 'test'
    assert !row.save
    
    assert row.errors
    assert_equal 'is not included in the list', row.errors['color']
  end

  def test_other_types
    row = Enumeration.new
    row.string_field = 'a' * 10
    assert !row.save
    assert_equal 'is too long (maximum is 8 characters)', row.errors['string_field']

    row = Enumeration.new
    assert !row.save
    assert_equal 'can\'t be blank', row.errors['string_field']

    row = Enumeration.new
    row.string_field = 'test'
    row.int_field = 'aaaa'
    assert !row.save
    assert_equal 'is not a number', row.errors['int_field']

    row = Enumeration.new
    row.string_field = 'test'
    row.int_field = '500'
    assert row.save
  end

  def test_view_helper
    request  = ActionController::TestRequest.new
    response = ActionController::TestResponse.new
    request.action = 'test1'
    body = EnumController.process(request, response).body
    assert_equal '<select id="test_severity" name="test[severity]"><option value="low">low</option><option value="medium" selected="selected">medium</option><option value="high">high</option><option value="critical">critical</option></select>', body
  end

  def test_radio_helper
    request  = ActionController::TestRequest.new
    response = ActionController::TestResponse.new
    request.action = 'test2'
    body = EnumController.process(request, response).body
    assert_equal '<label>low: <input id="test_severity_low" name="test[severity]" type="radio" value="low" /></label><label>medium: <input checked="checked" id="test_severity_medium" name="test[severity]" type="radio" value="medium" /></label><label>high: <input id="test_severity_high" name="test[severity]" type="radio" value="high" /></label><label>critical: <input id="test_severity_critical" name="test[severity]" type="radio" value="critical" /></label>', body
  end


  # Basic tests
  def test_create_basic_default
    assert (object = BasicEnum.create)
    assert_nil object.value,
      "Enum columns without explicit default, default to null if allowed"
    assert !object.new_record?
  end

  def test_create_basic_good
    assert (object = BasicEnum.create(:value => :good))
    assert_equal :good, object.value
    assert !object.new_record?
    assert (object = BasicEnum.create(:value => :working))
    assert_equal :working, object.value
    assert !object.new_record?
  end

  def test_create_basic_null
    assert (object = BasicEnum.create(:value => nil))
    assert_nil object.value
    assert !object.new_record?
  end

  def test_create_basic_bad
    assert (object = BasicEnum.create(:value => :bad))
    assert object.new_record?
  end

  # Basic w/ Default

  ######################################################################

  def test_create_basic_wd_default
    assert (object = BasicDefaultEnum.create)
    assert_equal :working, object.value, "Explicit default ignored columns"
    assert !object.new_record?
  end

  def test_create_basic_wd_good
    assert (object = BasicDefaultEnum.create(:value => :good))
    assert_equal :good, object.value
    assert !object.new_record?
    assert (object = BasicDefaultEnum.create(:value => :working))
    assert_equal :working, object.value
    assert !object.new_record?
  end

  def test_create_basic_wd_null
    assert (object = BasicDefaultEnum.create(:value => nil))
    assert_nil object.value
    assert !object.new_record?
  end

  def test_create_basic_wd_bad
    assert (object = BasicDefaultEnum.create(:value => :bad))
    assert object.new_record?
  end



  # Nonnull

  ######################################################################

  def test_create_nonnull_default
    assert (object = NonnullEnum.create)
#    assert_equal :good, object.value,
#      "Enum columns without explicit default, default to first value if null not allowed"
    assert object.new_record?
  end

  def test_create_nonnull_good
    assert (object = NonnullEnum.create(:value => :good))
    assert_equal :good, object.value
    assert !object.new_record?
    assert (object = NonnullEnum.create(:value => :working))
    assert_equal :working, object.value
    assert !object.new_record?
  end

  def test_create_nonnull_null
    assert (object = NonnullEnum.create(:value => nil))
    assert object.new_record?
  end

  def test_create_nonnull_bad
    assert (object = NonnullEnum.create(:value => :bad))
    assert object.new_record?
  end

  # Nonnull w/ Default

  ######################################################################

  def test_create_nonnull_wd_default
    assert (object = NonnullDefaultEnum.create)
    assert_equal :working, object.value
    assert !object.new_record?
  end

  def test_create_nonnull_wd_good
    assert (object = NonnullDefaultEnum.create(:value => :good))
    assert_equal :good, object.value
    assert !object.new_record?
    assert (object = NonnullDefaultEnum.create(:value => :working))
    assert_equal :working, object.value
    assert !object.new_record?
  end

  def test_create_nonnull_wd_null
    assert (object = NonnullDefaultEnum.create(:value => nil))
    assert object.new_record?
  end

  def test_create_nonnull_wd_bad
    assert (object = NonnullDefaultEnum.create(:value => :bad))
    assert object.new_record?
  end

  def test_quoting
    value = ActiveRecord::Base.send(:sanitize_sql, ["value = ? ", :"'" ] )
    assert_equal "value = '\\'' ", value
  end
  
    # String defaults instead of symbols

  ######################################################################
    def test_legacy_strings
    enum_string_test do 
      assert_equal 0,  EnumerationString.count
      
      # create a new Enumeration with string
      # blue medium
      row = EnumerationString.new
      row.color = 'blue'
      row.string_field = 'test'
      assert_equal 'medium', row.severity
      assert(row.save)
      
      row = EnumerationString.find_by_color('blue')
      validate_enum_row(row, :color => 'blue', :severity => 'medium')
      
      # change to red high
      row.severity = 'high'
      row.write_attribute(:color, 'red')
      assert(row.save, "Row was not saved.")
      
      row.reload
      validate_enum_row(row, :color => "red", :severity => 'high')

    end
  end
  
  #test about a bunch of finder methods and update methods to make sure the queries are sanitized well
  #and successful
  def test_legacy_string_with_finder_and_update_methods
    enum_string_test do
      
      #create a green critical row using create!
      row = EnumerationString.create!(:color => 'green', :severity => 'critical', :string_field => 'giraffe')
      row = EnumerationString.find :first, :conditions => ['color = :col', {:col => 'green'}]
      validate_enum_row(row, :color => 'green', :severity => 'critical')
      
      #update attribute to be green high and find(:first) without params
      
      row.update_attribute(:severity, :high)
      assert_nil(EnumerationString.find_by_color(:blue))
      assert_nil(EnumerationString.find_by_severity('critical'))
      row = EnumerationString.find :first
      validate_enum_row(row, :color => 'green', :severity => "high")
      
      #update attributes to red high and find(:first)
      row.update_attributes(:string_field => 'gorilla', :color => 'red')
      row = EnumerationString.find :first, :conditions => ['color = ?', :red]
      validate_enum_row(row, :color => 'red', :string_field => 'gorilla', :severity => 'high')
  
      #update all to blue low and find(:all)
      row = EnumerationString.update_all(['color = ?, severity = ?', :blue, 'low'], 
                  ['color = :color and severity = :severity', {:color => :red, :severity => 'high'} ])           
      rows = EnumerationString.find :all, :conditions => ['color = ?', 'blue']
      assert_equal 1, rows.length
      validate_enum_row rows.first, :color => 'blue', :severity => 'low'
      
    end
  end
  
  protected
  
  #test that resets the use_strings value
  def enum_string_test(&block) 
    ActiveRecordEnumerations::Column.use_strings = true
    yield block
  ensure
    ActiveRecordEnumerations::Column.use_strings = false
  end
  
  #validate that the methods on the record are the same as specified in  options
  def validate_enum_row(row, options={})
    assert row, "The expected row does not exist. #{options.inspect}"
    options.each{|k,v| 
      assert_equal v, row.send(k), "Row expecting #{k} = #{v} but was #{row.send(k)}"
    }
  end
end
