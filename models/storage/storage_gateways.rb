module Storage
	module StorageGateways
		def self.get_gateway
			if PADRINO_ENV=='development'
				Storage::GoogleDriveGateway.new
			else
				Storage::DropboxGateway.new
			end
		end
	end
end
