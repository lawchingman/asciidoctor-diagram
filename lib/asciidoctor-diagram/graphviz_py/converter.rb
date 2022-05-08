require_relative '../diagram_converter'
require_relative '../util/cli_generator'
require_relative '../util/platform'

module Asciidoctor
  module Diagram
    # @private
    class GraphvizPyConverter
      include DiagramConverter
      include CliGenerator

      def supported_formats
        [:png, :pdf, :svg]
      end

      def collect_options(source)
        {
            :layout => source.attr('layout'),
            :argument => source.attr('argument')
        }
      end

      def convert(source, format, options)
        generate_stdin(source.find_command('graphviz-py'), format.to_s, source.to_s) do |tool_path, output_path|
          args = [tool_path, "-o#{Platform.native_path(output_path)}", "-T#{format.to_s}"]

          layout = options[:layout]
          args << "-K#{layout}" if layout

          argument = options[:argument]

          if argument
            args << "-a"
            args << argument
          end

          args
        end
      end
    end
  end
end
