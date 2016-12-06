require "digest"
door_id = "ojvtpuvg"
password = ""
index = 0

while password.length < 8
  md5 = Digest::MD5.hexdigest(door_id + index.to_s)
  if md5[0..4] == "00000"
    password += md5[5]
    puts password
  end
  index += 1
end

puts password

