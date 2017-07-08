class FTPRepository
  require 'double_bag_ftps'

  attr_reader :ftps_host
  attr_reader :ftps_remote_path
  attr_reader :ftps_username
  attr_reader :ftps_password

  def initialize(host, config)
    @ftps_host = config[:region]
    @ftps_remote_path = host
    @ftps_username = config[:aws_access_key_id]
    @ftps_password = config[:secret_access_key]
  end

  def login
    # Connect to a host using explicit FTPS and do not verify the host's cert
    ftps = DoubleBagFTPS.new
    ftps.ssl_context = DoubleBagFTPS.create_ssl_context(verify_mode: OpenSSL::SSL::VERIFY_NONE)
    ftps.connect(@ftps_host)
    ftps.login(@ftps_username, @ftps_password)
    ftps
  end

  def archive_exist?(archive_filename)
    ftps = login
    files = ftps.list
    ftps.close
    return !files.select { |f| f.include? "#{@ftps_remote_path}/#{archive_filename}" }.empty?
  end

  def download(archive_filename, destination_path)
    ftps = login
    ftps.getbinaryfile("#{@ftps_remote_path}/#{archive_filename}", destination_path)
    ftps.close
  end

  def upload(archive_filename, archive_path)
    ftps = login
    files = ftps.list
    ftps.mkdir(@ftps_remote_path) if files.select { |f| f.include? @ftps_remote_path }.empty?
    ftps.putbinaryfile(archive_path, "#{@ftps_remote_path}/#{archive_filename}")
    ftps.close
  end
end
