class Storage::GoogleDriveGateway

  def initialize
    credentials = Signet::OAuth2::Client.new(client_id:"767571490573-phbcfn5o66h1tvpfj39a727oihiq85o3.apps.googleusercontent.com",
                                             client_secret:"p7jcpMugvVARUNfJ61sHLXwt")
    @drive = Google::Apis::DriveV2::DriveService.new
    @drive.authorization = credentials
  end

  def upload file_path, file
    metadata = Google::Apis::DriveV2::File.new(title: 'My document')
    metadata = @drive.insert_file(metadata, upload_source: file_path, content_type: 'text/plain')
  end

  def download file_path
    @drive.get_file(metadata.id, download_dest: '/tmp/myfile.txt')
  end

  def metadata file_path
    { upload_type: "multipart", content_type: "application/multipart", mime_type: "application/octet-stream" }
  end

end