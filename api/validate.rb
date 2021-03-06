module Validation
  def valid?
    klass = Object.const_get("#{self.class.name}Validator")
    @validator = klass.new(self)
    @validator.valid?
  end

  def errors
    return {} unless defined?(@validator)
    @validator.errors
  end
end

module Validate
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.extend(ClassMethods)
  end

  module InstanceMethods
    attr_reader :object, :errors

    def initialize(object)
      @object = object
      @errors = {}
    end

    def valid?
      self.class.validators.each { |args| validate(args) }
      @errors.empty?
    end

    private

    def validate(args)
      case
      when args[1].key?(:with)
        with_validator(*args)
      when args[1].key?(:type)
        type_validator(*args)
      end
    end

    def with_validator(name, options)
      fail unless options[:with].call(@object)
    rescue
      add_error(name, options[:msg])
    end

    def type_validator(name, options)
      return if @object.send(name).is_a?(options[:type])
      add_error(name, "must be a #{options[:type].name}.")
    end

    def add_error(name, msg)
      @object.errors.merge!(name => [msg])
    end
  end

  module ClassMethods
    def validates(*args)
      create_validation(args)
    end

    def validators
      @validators
    end

    private

    def create_validation(args)
      @validators = [] unless defined?(@validators)
      @validators << args
    end
  end
end
