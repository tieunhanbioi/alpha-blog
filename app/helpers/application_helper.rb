module ApplicationHelper
  #can either use variable or hash or even array for the options parameter
  def gravatar_for(user, options = "80")
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: "img-circle")
  end
end
