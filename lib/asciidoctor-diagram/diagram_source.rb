# This module describes the duck-typed interface that diagram sources must implement. Implementations
# may include this module but it is not required.

module Asciidoctor
  module Diagram
    module DiagramSource
      def image_name
        raise NotImplementedError.new
      end

      # @return [String] the String representation of the source code for the diagram
      # @abstract
      def code
        raise NotImplementedError.new
      end

      # Get the value for the specified attribute. First look in the attributes on
      # this document and return the value of the attribute if found. Otherwise, if
      # this document is a child of the Document document, look in the attributes of the
      # Document document and return the value of the attribute if found. Otherwise,
      # return the default value, which defaults to nil.
      #
      # @param name [String, Symbol] the name of the attribute to lookup
      # @param default_value [Object] the value to return if the attribute is not found
      # @inherit [Boolean, String] indicates whether to check for the attribute on the AsciiDoctor::Document if not found on this document.
      #                            When a non-nil String is given the an attribute name "#{inherit}-#{name}" is looked for on the document.
      #
      # @return the value of the attribute or the default value if the attribute is not found in the attributes of this node or the document node
      # @abstract
      def attr(name, default_value = nil, inherit = nil)
        raise NotImplementedError.new
      end

      # @return [String] the base directory against which relative paths in this diagram should be resolved
      # @abstract
      def base_dir
        attr('docdir', nil, true)
      end

      # Alias for code
      def to_s
        code
      end

      # Determines if the diagram should be regenerated or not. The default implementation of this method simply
      # returns true.
      #
      # @param image_file [String] the path to the previously generated version of the image
      # @param image_metadata [Hash] the image metadata Hash that was stored during the previous diagram generation pass
      # @return [Boolean] true if the diagram should be regenerated; false otherwise
      def should_process?(image_file, image_metadata)
        true
      end

      # Creates an image metadata Hash that will be stored to disk alongside the generated image file. The contents
      # of this Hash are reread during subsequent document processing and then passed to the should_process? method
      # where it can be used to determine if the diagram should be regenerated or not.
      # The default implementation returns an empty Hash.
      # @return [Hash] a Hash containing metadata
      def create_image_metadata
        {}
      end
    end
  end
end