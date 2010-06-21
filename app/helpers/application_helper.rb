module ApplicationHelper

  def deep_clone(obj)
    case obj
    when Fixnum, Bignum, Float, NilClass, FalseClass, TrueClass, Symbol
      return obj
    when Hash
      klone = obj.clone
      obj.each {|k,v| klone[k] = deep_clone(v)}
    when Array
      klone = obj.clone
      klone.clear
      obj.each{|v| klone << deep_clone(v)}
    else
      klone = obj.clone
    end
    
    klone.instance_variables.each do |v|
      klone.instance_variable_set(v, deep_clone(klone.instance_variable_get(v)))
    end
    
    return klone
  end

end
