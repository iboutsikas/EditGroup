Judge::Validator.class_eval do
  def to_hash
    {
        :kind => kind,
        :options => get_js_compatible_options(options),
        :messages => messages.to_hash
    }
  end

  private

  def get_js_compatible_options(options)
    method_name = "get_js_compatible_#{self.kind}"
    if self.respond_to? method_name, options
      options = self.send method_name, options
    end
    options
  end

  def get_js_compatible_format(options)
    format_options = Hash.new
    options.each do |key, option|
      format_options[key] = (key == :with) ? convert_regex_to_js_compatible(option) : option
    end
    format_options
  end

  def convert_regex_to_js_compatible(regex)
    js_regex_source = regex.source.sub(/^\\A/, '^').sub(/\\z$/i, '$')
    /#{js_regex_source}/
  end
end

Judge.configure do
  expose Member,  :email
end