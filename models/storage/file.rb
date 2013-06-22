module Storage
	class CannotUpdateNameError < StandardError
		def initialize
			super("File's name cannot be updated after being set.")
		end
	end

	module File
	  include DataMapper::Resource
	  is :remixable

	  property :id, Serial
		property :inner_path, String, :accessor => :protected, :field => 'path'

		validates_presence_of :path
		validates_uniqueness_of :path
		# TODO: validate path is not temporary

		def name
			return nil if self.inner_path.nil?
			Pathname.new(self.inner_path).basename.to_s
		end

		def name=(new_name)
			return if new_name.nil? || new_name.empty?

			new_name = new_name.downcase
			raise CannotUpdateNameError if self.inner_path && self.name != new_name

			# self.inner_path = calculate_path(new_name)
			self.inner_path = new_name
		end

		def path
			self.inner_path
		end

		module RemixerInstanceMethods
			after :create, :complete_path

			def complete_path
				# if self.path =~ /^\/assignments\/temp\/.*/ && !self.assignment.nil?
				# 	self.inner_path = calculate_path(self.name)
				# end
			end

			def calculate_path(file_name)
				path = ''
				if self.id.blank?
					path = "/#{self.class.downcase}/temp/#{file_name}"
				else
					path = "/#{self.class.downcase}/#{self.id}/#{file_name}"
				end

				return path
			end
  	end
	end
end