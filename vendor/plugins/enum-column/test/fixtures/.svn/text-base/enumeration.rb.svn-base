
class Enumeration < ActiveRecord::Base
  validates_columns :color, :severity, :string_field, :int_field
end

class BasicEnum < ActiveRecord::Base
  validates_columns :value
end

class BasicDefaultEnum < ActiveRecord::Base
  validates_columns :value
end

class NonnullEnum < ActiveRecord::Base
  validates_columns :value
end

class NonnullDefaultEnum < ActiveRecord::Base
  validates_columns :value
end


# Typically the option to use strings would be defined in environment.rb
# Before the other classes are loaded. The validation loads the column information which is cached
# This test class is identical to Enumerations except we use strings for values instead of
# This allows us to run the tests using strings, then run the tests that do not use strings
ActiveRecordEnumerations::Column.use_strings = true
class EnumerationString < ActiveRecord::Base
  set_table_name 'enumerations'
  validates_columns :color, :severity, :string_field, :int_field
end


