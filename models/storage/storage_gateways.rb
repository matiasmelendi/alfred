module Storage
	module StorageGateways
		def self.get_gateway
			if PADRINO_ENV=='development'
				Storage::StubGateway.new
			else
				Storage::LocalGateway.new
			end
		end
	end
end
