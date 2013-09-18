class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
   private
  def generate_s3_upload_data
    bucket = 'reworkhosting' # S3 bucket
    access_key = 'AKIAJY566AL3L4WS5GQQ' # S3 Access Key
    secret = '8tY3W637ZAfWl3I0TMj4smWk1sy9ZZfvrP7mgW3i' # S3 Secret Key
 
    key = "uploads/pics/#{Time.now.to_s}/" # The folder in your bucket that you'd like uploaded files to land in. See note below.
    expiration = 15.years.from_now.utc.strftime('%Y-%m-%dT%H:%M:%S.000Z')
    max_filesize = 10.megabytes
    sas = '201' # Tells amazon to redirect after success instead of returning xml
    policy = "{'expiration': '#{expiration}',
        'conditions': [
          {'bucket': '#{bucket}'},
          {'acl': 'private'},
          {'success_action_status': '#{sas}'},
          ['starts-with', '$Filename', ''],
          ['starts-with', '$key', '#{key}'],
          ['content-length-range', 1, #{max_filesize}]
        ]}
      "
    encoded_policy = Base64.encode64(policy).gsub(/\n|\r/, '')
    digest = OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new('sha1'), secret, encoded_policy)
    signature = Base64.encode64(digest).gsub(/\n| |\r/, '')
 
    # Return a hash to be used in the view to populate some JS variables.
    {
      :access_key => access_key,
      :key => key,
      :policy => encoded_policy,
      :signature => signature,
      :sas => sas,
      :bucket => bucket,
      :filesize => max_filesize
    }
  end
 
  # Call this method in the action with the uploader.
  def prepare_uploadify
    @uploadify_data = generate_s3_upload_data
    @s3_url = "http://#{@uploadify_data[:bucket]}.s3.amazonaws.com"
  end
  
end
