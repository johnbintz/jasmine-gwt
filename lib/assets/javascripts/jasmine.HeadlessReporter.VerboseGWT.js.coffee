#= require jasmine.HeadlessReporter.Verbose

class jasmine.HeadlessReporter.VerboseGWT extends jasmine.HeadlessReporter.Verbose
  colorLine: (line, color) =>
    parts = line.split(' ')
    type = parts.shift()

    switch type
      when 'Given'
        type.foreground('yellow') + ' ' + parts.join(' ').foreground(color)
      when 'When'
        type.foreground('cyan') + ' ' + parts.join(' ').foreground(color)
      when 'Then'
        type.foreground('magenta') + ' ' + parts.join(' ').foreground(color)
      else
        line.foreground(color)
