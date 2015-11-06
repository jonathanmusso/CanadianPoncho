Aws.config.update({
region: 'us-east-1',
credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])
})
AWS_BUCKET = Aws::S3::Resource.new.bucket(ENV['AWS_BUCKET'])