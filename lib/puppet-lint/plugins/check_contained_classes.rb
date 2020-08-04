PuppetLint.new_check(:contained_classes) do
  def check
    resource_indexes.select {|r| r[:type].type == :CLASS}.each do |resource|
      token = resource[:type]
      class_name = token.next_code_token.next_code_token.value
      found = false
      manifest_lines.each do | line |
        if line =~ /[^\s#]*contain\s+\b#{class_name}\b/
          found = true
          break
        end
      end

      if !found
          notify :warning, {
            :message  => 'expected corresponding contain statement',
            :line     => token.line,
            :column   => token.column,
            :resource => resource,
            :class    => class_name,
            :token    => token,
          }
      end
    end
  end

  def fix(problem)
    resource = problem[:resource]
    last_token = tokens[resource[:end]]

    newline = PuppetLint::Lexer::Token.new(
      :NEWLINE, '\n',
      problem[:token].line, problem[:token].column+1
    )
    contain = PuppetLint::Lexer::Token.new(
      :NAME, 'contain',
      problem[:token].line, problem[:token].column+1
    )
    white = PuppetLint::Lexer::Token.new(
      :WHITESPACE, ' ',
      problem[:token].line, problem[:token].column+1
    )
    contain_class = PuppetLint::Lexer::Token.new(
      :NAME, problem[:class],
      problem[:token].line, problem[:token].column+1
    )

    pos = tokens.index(last_token)
    tokens.insert(pos + 1, contain_class)
    tokens.insert(pos + 1, white)
    tokens.insert(pos + 1, contain)
    (problem[:column] - 1).times do
      tokens.insert(pos + 1, white)
    end
    tokens.insert(pos + 1, newline)
  end
end
