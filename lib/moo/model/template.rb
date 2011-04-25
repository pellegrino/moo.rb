require 'fileutils'
module Moo
  module Model
    class Template

      
      class << self
        attr_reader :all

        # Load all the templates into objects
        def load
          @all = [] #contains all template objects

          template_dir = Gem.datadir('moo') + '/templates/'

          template_files = Dir.entries(template_dir).reject do |t|
            t == '.' || t == '..'
          end

          template_files.each do |f|
            path = template_dir + f
            @all << Template.new(path)
          end
        end

        # Discard all the template objects
        def unload
          @all = nil
        end

        # True if templates loaded, false otherwise
        def loaded?
          !@all.nil?
        end

        # all template codes
        def codes
          load unless loaded? 
          @all.map { |t| t.code } 
        end

        def with_code(code)
          load unless loaded?
          @all.select { |t| t.code == code }[0]
        end
      end

      attr_reader :code, :filename, :product

      def initialize(template_filename)
        unless File.exists? template_filename
          raise ArgumentError, "Template file provided doesn't exist: #{template_filename}"
        end
        @filename = template_filename
        @code = File.basename @filename, '.xml'
        @product = @code.split('_')[0]
      end
    end
  end
end