Rails.application.config.active_support.key_generator_hash_digest_class = OpenSSL::Digest::SHA256
Rails.application.config.active_support.encryption_key_length = 32  # Important: 32 bytes for SHA256
Rails.application.config.active_support.message_encryptor_cipher = "aes-256-gcm"