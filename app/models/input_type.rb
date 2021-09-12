class InputType < ApplicationRecord
  def allows_additional_attributes?
    ruby_klass == "SelectOption" || ruby_klass == "Checkbox"
  end

  def process_additional_attributes(val)
    case ruby_klass
    when "SelectOption" then comma_separated_to_json_string(val)
    when "Checkbox" then comma_separated_to_json_string(val)
    else val
    end
  end

  def comma_separated_to_json_string(val)
    JSON.pretty_generate(
      val.split(',').map { |v| v.strip }
    )
  end

  def parsed_additional_attributes(val)
    case ruby_klass
    when "SelectOption" then JSON.parse(val)
    when "Checkbox" then JSON.parse(val)
    else val
    end
  end
end
