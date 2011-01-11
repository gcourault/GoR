# This module provides all the column helper methods to deal with the
# values and adds the common type management code for the adapters.
#
# Set the +use_strings+ options to true to support legacy applications still which 
# use enum columns as strings instead of symbols. Add this below the initalizer in
# the <tt>environment.rb</tt> file
#  ActiveRecordEnumerations::Column.use_strings = true
#
# Everything behaves the same, but all references to enumerated values should be strings instead of symbols.
# For example,
#   Enumeration.create!(:color => 'red', :severity => 'high') 
#   
#    Enumeration.columns_hash['color'].values
#    Will yield: ["red", "blue", "green", "yellow"] instead of [:red, :blue, :green, :yellow]
#
#    str_enum = Enumeration.find :first
#    str_enum.color        #'red'
#    str_enum.severity     #'high'
#  
# When creating the table, the +limit+ field can still take enums, and 
# finder query sanitation for the most part treats symbols like strings
#




module ActiveRecordEnumerations
  module Column
    

    mattr_accessor :use_strings
    self.use_strings = false 
  
    # Add the values accessor to the column class.
    def self.included(klass)
      klass.module_eval <<-EOE
        def values; @limit; end
      EOE
    end
      
    # Add the type to the native database types. This will most
    # likely need to be modified in the adapter as well.
    def native_database_types
      types = super
      types[:enum] = { :name => "enum" }
      types
    end

    # The new constructor with a values argument.
    def initialize(name, default, sql_type = nil, null = true, values = nil)
      super(name, default, sql_type, null)
      @limit = values if type == :enum
    end

    # The class for enum is Symbol.
    def klass
      if type == :enum
        use_strings? ? String : Symbol
      else
        super
      end
    end

    #cast the value to the appropriate type based on +use_strings+
    def cast_enum_value(value)
      if value.nil?
        nil
      elsif use_strings?
        value.to_s 
      else
        ActiveRecordEnumerations::Column.value_to_symbol(value)
      end
    end
    
    # Convert to a symbol.
    def type_cast(value)
      return nil if value.nil?
      if type == :enum 
        cast_enum_value(value)
      else
        super
      end
    end

    # Code to convert to a symbol.
    def type_cast_code(var_name)
      if type == :enum && !use_strings?
        "ActiveRecordEnumerations::Column.value_to_symbol(#{var_name})"
      else
        super
      end
    end

    # The enum simple type.
    def simplified_type(field_type)
      if field_type =~ /enum/i
        :enum
      else
        super
      end
    end
    
    def use_strings?
      ActiveRecordEnumerations::Column.use_strings
    end
    
    # Safely convert the value to a symbol. 
    def self.value_to_symbol(value)
      case value
      when Symbol
        value
      when String
        value.empty? ? nil : value.intern
      else
        nil
      end
    end
  end
end

