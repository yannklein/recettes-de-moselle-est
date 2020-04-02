class ArrayInput < SimpleForm::Inputs::StringInput
  def input
    input_html_options[:type] ||= input_type

    input_html_options[:class] << 'form-control'
    Array(object.public_send(attribute_name)).map do |array_el|
      "<li>#{@builder.text_field(nil, input_html_options.merge(value: array_el, name: "#{object_name}[#{attribute_name}][]"))}</li>"
    end.join.html_safe
    # raise
  end

  def input_type
    :text
  end
end
