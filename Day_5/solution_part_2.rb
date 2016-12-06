require "digest"
door_id = "ojvtpuvg"
password = [nil] * 8
index = 0

while password.length < 8
  md5 = Digest::MD5.hexdigest(door_id + index.to_s)
  if md5[0..4] == "00000" && password[md5[5]].nil?
    password[md5[5]] = md5[6]
    puts password.reduce(&:+)
  end
  index += 1
end

puts password.reduce(&:+)

