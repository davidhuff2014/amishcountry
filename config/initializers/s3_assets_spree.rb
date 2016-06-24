attachment_config = {

    s3_credentials: {
        access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
        secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
        bucket:            ENV['S3_BUCKET_NAME']
    },

    storage:        :s3,
    s3_headers:     { "Cache-Control" => "max-age=31557600" },
    s3_protocol:    "https",
    s3_region:      ENV['AWS_REGION'],
    url:            ':s3_alias_url',
    s3_host_alias:  ENV['CDN_HOST'],
    bucket:         ENV['S3_BUCKET_NAME'],

    styles: {
        mini:     "48x48>",
        small:    "100x100>",
        product:  "240x240>",
        large:    "600x600>"
    },

    path:          "/products/:id/:style/:basename.:extension",
    default_url:   "noimage/:style.png",
    default_style: "product",
}

attachment_config.each do |key, value|
  Spree::Image.attachment_definitions[:attachment][key.to_sym] = value
# end if Rails.env.production?
end # allow to run for test and development using environment_variables.rb
