module compiler

// Helper struct for outputing formatted files

import strings

struct Writer {
	builder strings.Builder

	indent int
}

fn new_writer() Writer {
	return Writer{
		builder: strings.new_builder(100)
		indent: 0
	}
}

// check_line checks the line for {, } and adapts the indent as neccessary
// it also returns the current indentation string
fn (w mut Writer) check_line(l string) string {
	if l == '}' {
		// Kinda special case
		w.indent--
	} else {
		opens := l.count('{')
		closes := l.count('}')

		w.indent += (opens - closes)
	}

	if w.indent < 0 {
		// We dont really care if it goes below 0
		// but just make sure that it is limited
		w.indent = 0
	}

	return w.indent * '\t'
}

// l writes a line to the output
pub fn (w mut Writer) l(l string) {
	indent := w.check_line(l)
	w.builder.writeln('$indent$l')
}

// text gets the current text of the writer
pub fn (w mut Writer) text() string {
	return builder.str()
}