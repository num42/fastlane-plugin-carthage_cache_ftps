require 'net/ftp'

class FTPRepository
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

  def connection
    Net::FTP.new(@ftps_host, {
      ssl:      { verify_mode: OpenSSL::SSL::VERIFY_NONE },
      passive:  true,
      username: @ftps_username,
      password: @ftps_password
    })
  end

  def archive_exist?(archive_filename)
    ftps = connection
    begin
      ftps.chdir(@ftps_remote_path)
    rescue StandardError
      return false
    end
    files = ftps.list
    ftps.close

    if files.select { |f| f.include? archive_filename.to_s }.empty?
      return false
    else
      puts "Remote File already exists"
      return true
    end
  end

  def download(archive_filename, destination_path)
    ftps = connection
    ftps.getbinaryfile("#{@ftps_remote_path}/#{archive_filename}", destination_path)
    ftps.close
  end

  def upload(archive_filename, archive_path)
    ftps = connection
    files = ftps.list

    if files.select { |f| f.include? @ftps_remote_path }.empty?
      ftps.mkdir(@ftps_remote_path)
    end

    remote_path = "#{@ftps_remote_path}/#{archive_filename}"
    if files.select { |f| f.include? remote_path }.empty?
      ftps.putbinaryfile(archive_path, remote_path)
    else
      puts "File #{remote_path} already exists"
    end

    ftps.close
  end
end
